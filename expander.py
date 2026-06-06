#!/usr/bin/env python3

import re
import argparse
import subprocess
import tempfile
import os
import platform
from pathlib import Path
from logging import Logger, basicConfig, getLogger

logger = getLogger(__name__)
system_name = platform.system()

ATCODER_INCLUDE = re.compile(r'\s*(include|import)\s*([a-zA-Z0-9_,./\s"\[\]]*)')
WHEN_STATEMENT = re.compile(r'^\s*when\s+.*:')

INDENT_WIDTH = 2

# ----------------------------
# utility
# ----------------------------

def indent_level(line):
    for i, c in enumerate(line):
        if c != " ":
            return i
    return len(line)


def split_import_items(s):
    items = []
    cur = []
    depth = 0

    for c in s:
        if c == "[":
            depth += 1
        elif c == "]":
            depth -= 1

        if c == "," and depth == 0:
            items.append("".join(cur).strip())
            cur = []
            continue

        cur.append(c)

    if cur:
        items.append("".join(cur).strip())

    return items


def expand_bracket_import(item):

    m = re.match(r"^(.*?)/\[(.*)\]$", item)

    if not m:
        return [item]

    prefix = m.group(1)
    inner = m.group(2)

    parts = [x.strip() for x in inner.split(",")]

    return [f"{prefix}/{p}" for p in parts]


def strip_relative_prefix(name):

    name = name.strip().strip('"')

    # Nim's `./foo/bar` and `foo/bar` refer to the same module here.
    # Do not use lstrip("./"): it would also mangle paths like `../foo`.
    while name.startswith("./"):
        name = name[2:]

    return name


def is_internal_module(name):

    name = strip_relative_prefix(name)

    return (
        name.startswith("atcoder/")
        or name.startswith("lib/")
        or name.startswith("mylib/")
    )


def normalize_internal_path(name):

    name = strip_relative_prefix(name)

    if name.startswith("lib/"):
        name = name.replace("lib/", "atcoder/extra/", 1)

    if not name.endswith(".nim"):
        name += ".nim"

    return name


def module_import_path(relpath):

    relpath = strip_relative_prefix(relpath)

    if relpath.endswith(".nim"):
        relpath = relpath[:-4]

    return relpath


# ----------------------------
# file read
# ----------------------------

def read_module_text(path, lib_root, local_root):
    p = Path(path)

    if p.is_absolute():
        return p.read_text()

    if path.startswith("mylib/"):
        return (local_root / path).read_text()

    return (lib_root / path).read_text()


def copy_for_bundle(relpath, lib_root, local_root, bundle_tmp):
    p = Path(relpath)

    if p.is_absolute():
        src = p
        rel = p.name
    elif relpath.startswith("mylib/"):
        src = local_root / relpath
        rel = relpath
    else:
        src = lib_root / relpath
        rel = relpath

    dst = bundle_tmp / rel
    dst.parent.mkdir(parents=True, exist_ok=True)
    dst.write_text(src.read_text())


def write_bundle_module(relpath, lines, bundle_tmp):
    p = Path(relpath)

    # Internal modules are bundled under their module path.  Absolute paths are
    # not expected for internal modules, but keep the old behavior just in case.
    rel = p.name if p.is_absolute() else relpath

    dst = bundle_tmp / rel
    dst.parent.mkdir(parents=True, exist_ok=True)
    dst.write_text("\n".join(lines) + "\n")


# ----------------------------
# recursive resolver
# ----------------------------

def read_source(path, prefix, defined, lib_root, local_root,
                bundle_tmp, mode, depth):

    if path in defined:
        logger.info(f"already included {path}, skip")
        return []

    defined.add(path)

    source = read_module_text(path, lib_root, local_root).splitlines()

    result = []

    i = 0
    while i < len(source):

        line = source[i]
        spaces = indent_level(line)

        if WHEN_STATEMENT.match(line):
            result.append(line)
            i += 1
            continue

        matched = ATCODER_INCLUDE.match(line)

        if not matched:
            result.append(line)
            i += 1
            continue

        keyword = matched.group(1)
        tail = matched.group(2)

        items = []

        for it in split_import_items(tail):
            items.extend(expand_bracket_import(it))

        for item in items:

            item = item.strip('"')

            if is_internal_module(item):

                fname = normalize_internal_path(item)

                if mode == "bundle":

                    read_source(
                        fname, "", defined,
                        lib_root, local_root, bundle_tmp,
                        mode, depth + 1
                    )

                    result.append(" " * spaces + f"{keyword} {module_import_path(fname)}")

                else:


                    
                    expanded = read_source(
                        fname, " " * spaces, defined,
                        lib_root, local_root, bundle_tmp,
                        mode, depth + 1
                    )

                    if mode == "embed" and depth == 0:

                        import base64
                        import lzma
                        
                        text = "\n".join(expanded) + "\n"
                        
                        compressed = lzma.compress(text.encode(), preset=9)
                        
                        b64 = base64.b64encode(compressed).decode()

                        result.append(
                            prefix + f'ImportExpand "{fname}" <=== "{b64}"'
                        )

                    else:
                        result.extend((" " * spaces) + ln for ln in expanded)

            else:
                result.append(" " * spaces + f"{keyword} {item}")

        i += 1

    if depth > 0:
        result.append(prefix + "discard")

    if mode == "bundle" and depth > 0:
        write_bundle_module(path, result, bundle_tmp)

    return result


# ----------------------------
# bundle bootstrap
# ----------------------------

def bundle_bootstrap(bundle_tmp, keep_tmp):

    if (bundle_tmp / "mylib").exists():
        tar_cmd = "tar -Jcvf atcoder.tar.xz atcoder mylib"
    else:
        tar_cmd = "tar -Jcvf atcoder.tar.xz atcoder"

    subprocess.run(tar_cmd, cwd=bundle_tmp, shell=True)

    if system_name == "Darwin":
        s = subprocess.run(
            "cat atcoder.tar.xz | base64 -b 0",
            cwd=bundle_tmp, shell=True, stdout=subprocess.PIPE
        ).stdout.decode()
    else:
        s = subprocess.run(
            "cat atcoder.tar.xz | base64 -w 0",
            cwd=bundle_tmp, shell=True, stdout=subprocess.PIPE
        ).stdout.decode()

    s = s.strip()

    cleanup = "" if keep_tmp else 'discard staticExec("rm -rf __bundle_tmp__")'

    return f"""
static:
  when not defined SecondCompile:
    template getFileName():string = instantiationInfo().filename
    let fn = getFileName()

    const bundleData = \"\"\"{s}\"\"\"

    discard staticExec("mkdir -p __bundle_tmp__")
    discard staticExec("echo " & bundleData & " | base64 -d > __bundle_tmp__/atcoder.tar.xz")
    discard staticExec("tar -Jxvf __bundle_tmp__/atcoder.tar.xz -C __bundle_tmp__")

    let (output, ex) = gorgeEx("nim cpp --path:./__bundle_tmp__ -d:SecondCompile -d:release -d:danger --path:./ --opt:speed --multimethods:on --warning[SmallLshouldNotBeUsed]:off --checks:off -o:a.out " & fn)

    {cleanup}
    doAssert ex == 0, output
    quit(0)
"""

# ----------------------------
# main
# ----------------------------

def main():

    parser = argparse.ArgumentParser()

    parser.add_argument("source")
    parser.add_argument("--mode", choices=["plain", "embed", "bundle"], default="bundle")
    parser.add_argument("--lib")
    parser.add_argument("--mylib")
    parser.add_argument("--keep-bundle-tmp", action="store_true")

    opts = parser.parse_args()

    basicConfig(level="INFO")

    src = Path(opts.source)
    if src.suffix == "":
        src = src.with_suffix(".nim")

    main_file = src.resolve()
    
    if not main_file.exists():
        raise FileNotFoundError(f"source file not found: {main_file}")
    if not main_file.is_file():
        raise ValueError(f"source is not a file: {main_file}")
    if main_file.suffix != ".nim":
        raise ValueError(f"source must be a .nim file: {main_file}")

    local_root = Path(opts.mylib).resolve() if opts.mylib else main_file.parent

    if opts.lib:
        lib_root = Path(opts.lib).resolve() / "src"
    else:
        lib_root = Path("~/git/Nim-ACL/src").expanduser()

    bundle_tmp = Path(tempfile.mkdtemp())

    expanded = read_source(
        str(main_file), "", set(),
        lib_root, local_root, bundle_tmp,
        opts.mode, 0
    )

    outputPrefix = ""
    if opts.mode == "embed":
        outputPrefix += """import macros
macro ImportExpand(s: untyped): untyped =
  parseStmt(staticExec("printf %s " & $s[2] & " | base64 -d | xzcat"))
"""

    output = outputPrefix + "\n".join(expanded)

    if opts.mode == "bundle":
        output = bundle_bootstrap(bundle_tmp, opts.keep_bundle_tmp) + output

    Path("combined.nim").write_text(output)


if __name__ == "__main__":
    main()
