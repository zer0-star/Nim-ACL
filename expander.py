#!/usr/bin/env python3

import re
import argparse
from logging import Logger, basicConfig, getLogger
import os, platform
from os import getenv, environ, path
from pathlib import Path
from typing import List
import subprocess, tempfile

system_name = platform.system()


logger = getLogger(__name__)  # type: Logger

ATCODER_INCLUDE = re.compile(
        r'\s*(include|import)\s*([a-zA-Z0-9_,./\s"]*)\s*')

WHEN_STATEMENT = re.compile(r'^\s*when\s+.*:')
ATCODER_DIR = re.compile('^(?:atcoder|lib)\/')
INDENT_WIDTH = 2
compress_type = "xz"  # "xz" or "bzip2" or "gzip"

if compress_type == "xz":
    decompress = "xzcat"
elif compress_type == "bzip2":
    decompress = "bzcat"
elif compress_type == "gzip":
    decompress = "zcat"


outputPrefix = """import macros
macro Please(x): untyped = nnkStmtList.newTree()

Please use Nim-ACL
Please use Nim-ACL
Please use Nim-ACL

"""


def indent_level(line: str):
    """
    インデント用のスペースがいくつあるかを返す
    """
    for i, _c in enumerate(line):
        if _c != ' ':
            return i
    return len(line)


def strip_as(line: str) -> str:
    """
    import時のasを取り除く
    """
    pos = line.find(' as ')
    if pos != -1:
        line = line[:pos]
    return line


def main():
    """
    メイン関数
    """
    td = tempfile.TemporaryDirectory()
    lib_tmp = Path(td.name)
    lib_path = Path(__file__).parent.resolve()
    basicConfig(
        format="%(asctime)s [%(levelname)s] %(message)s",
        datefmt="%H:%M:%S",
        level=getenv('LOG_LEVEL', 'INFO'),
    )
    parser = argparse.ArgumentParser(description='Expander')
    parser.add_argument('source', help='Source File')
    parser.add_argument('-c', '--console',
                        action='store_true', help='Print to Console')
    parser.add_argument('-s', '--single-line',
                        action='store_true', help='Single line import')
    parser.add_argument('-cmp', '--compress',
                        action='store_true', help='Compress import')
    parser.add_argument('--lib', help='Path to Atcoder Library')
    parser.add_argument('-d', '--directory',
                        action='store_true', help='Submit by directory')
    parser.add_argument('-b', '--raw',
                        action='store_true', help='submit raw data')

    opts = parser.parse_args()

    if opts.lib:
        lib_path = Path(opts.lib) / "src"
    elif 'NIM_INCLUDE_PATH' in environ:
        lib_path = Path(environ['NIM_INCLUDE_PATH']) / "src"
#    source = open(opts.source, encoding="utf8", errors='ignore').read()

    def read_source(f: str, prefix: str, defined: set, lib_path, is_main=True,
                    load_type=None) -> List[str]:
        """
        stringで渡されたsourceを読み。import, includeが出てきたら深堀りする
        深さ優先でimport/includeを調べる
        """
        if f in defined:
            logger.info('already included {:s}, skip'.format(f))
            return []

        defined.add(f)

        if is_main:
            source = open(f, encoding="utf8", errors='ignore').read()
        else:
            source = open(str(lib_path / f), encoding="utf8",
                          errors='ignore').read()
            logger.info('{:s} {:s}'.format(load_type, f))

        if not is_main and opts.directory:
            copy_source_path = lib_tmp / f
            os.makedirs(copy_source_path.parents[0], exist_ok=True)
            r = open(Path(lib_path / f)).read()
            open(copy_source_path, "w").write(r)

        result = []
        i = 0
        source = source.splitlines()
        while i < len(source):
            line = source[i]
            if WHEN_STATEMENT.match(line):
                result.append(line)
            else:
                matched = ATCODER_INCLUDE.match(line)
                spaces = indent_level(line)
                if matched:
                    keyword = line.strip().split()[0]
                    import_start = True
                    fnames = []
                    load_type_local = matched.group(1)
                    while True:
                        if import_start:
                            import_line = matched.group(2).split(",")
                            import_start = False
                        else:
                            import_line = source[i].split(",")
                        for fname in import_line:
                            fname = fname.strip()
                            if fname == '':
                                continue
                            fnames.append(fname)
                        i_next = i + 1
                        if i_next >= len(source) or \
                                indent_level(source[i_next]) != spaces + INDENT_WIDTH:
                            break
                        i = i_next

                    for fname in fnames:
                        line_local = "{} {}".format(load_type_local, fname)
                        if fname == '':
                            continue
                        if fname[0] == '\"':
                            assert fname[-1] == '\"'
                            fname = fname[1:-1]
                        fname = fname.replace("lib/", "atcoder/extra/")
                        if ATCODER_DIR.match(fname):
                            fname = strip_as(fname)
                            original_fname = fname
                            if not fname.endswith(".nim"):
                                fname += ".nim"
                            s = read_source(fname, " " * spaces, defined,
                                            lib_path, False, load_type_local)
                            if opts.single_line and is_main:
                                s0 = ""

                                if opts.compress:
                                    for l in s:
                                        s0 += l
                                        s0 += '\n'

                                    with open('/tmp/expander_tmp.txt', 'w') as f:
                                        #f.write(s0 + "\n")
                                        f.write(s0)
                                    if system_name == 'Darwin':
                                        s0 = subprocess.run("cat /tmp/expander_tmp.txt | {:s} -9 | base64 -b 0".format(compress_type), shell=True, stdout=subprocess.PIPE).stdout.decode()
                                    elif system_name == 'Linux':
                                        s0 = subprocess.run("cat /tmp/expander_tmp.txt | {:s} -9 | base64 -w 0".format(compress_type), shell=True, stdout=subprocess.PIPE).stdout.decode()
                                    else:
                                        print("unknown system")
                                    #s0 = base64.b64encode(s0.encode()).decode()
                                else:
                                    for l in s:
                                        l = l.replace("\\", "\\\\")
                                        l = l.replace("\"", "\\\"")
                                        s0 += l
                                        s0 += '\\n'

                                url = "https://github.com/zer0-star/Nim-ACL/tree/master/src/{}".format(fname)
                                result.append("# see {}".format(url))
                                if opts.directory:
                                    result.append("{} {}".format(keyword, original_fname))
                                    result.append("")
                                else:
                                    result.append("ImportExpand \"{}\" <=== \"{}\"".format(fname, s0))
                                    result.append("")
                            else:
                                import_message = " " * spaces + "#[ " + line_local + " ]#"
                                result.append(import_message)
                                result.extend(s)
                        else:
                            result.extend([" " * spaces + line_local])
                else:
                    result.append(line)
            i += 1
        if not is_main:
            result.append("  discard")
        result2 = []
        for line in result:
            result2.append(prefix + line)
        result = result2
        return result
    result = []
    if opts.single_line and not opts.directory:
        if opts.compress:
            result.append("import macros;macro ImportExpand(s:untyped):untyped = parseStmt(staticExec(\"echo \" & $s[2] & \" | base64 -d | {:s}\"))".format(decompress))
        else:
            result.append("import macros;macro ImportExpand(s:untyped):untyped = parseStmt($s[2])")

    result.extend(read_source(opts.source, "", set(), lib_path))
    outputSuffix = b""
    if opts.directory:
        global outputPrefix
        subprocess.run("export XZ_OPT=-9 && tar -Jcvf atcoder.tar.xz atcoder", cwd=lib_tmp, shell=True, stdout=subprocess.PIPE)
        md5sum = subprocess.run("md5sum atcoder.tar.xz", cwd=lib_tmp, shell=True, stdout=subprocess.PIPE).stdout.decode()
        second_compile_command = "nim cpp -d:release -d:SecondCompile -d:danger --path:./ --opt:speed --multimethods:on --warning[SmallLshouldNotBeUsed]:off --checks:off -o:a.out"
        if opts.raw:
            d = open(lib_tmp / "atcoder.tar.xz", 'rb').read()
      #let (output, ex) = gorgeEx("tail -c " & $zs & " " & fn & " > atcoder.tar.xz && tar -Jxvf atcoder.tar.xz && rm atcoder.tar.xz")
            outputPrefix += """
static:
  when not defined SecondCompile:
    template getFileName():string = instantiationInfo().filename
    let
      fn = getFileName()
      zs = {:d}
    block:
      let (output, ex) = gorgeEx("if [ -e ./atcoder ]; then exit 1; else exit 0; fi")
      doAssert ex == 0, "atcoder directory already exisits"
    block:
      let (output, ex) = gorgeEx("tail -c " & $zs & " " & fn & " > atcoder.tar.xz")
      doAssert ex == 0, "tail failed"
      # md5sum: {:s}
      let md5sum = staticExec("md5sum " & fn)
      let tarResult = staticExec("tar -Jxvf atcoder.tar.xz")
      doAssert false, tarResult
    let ss = staticExec("MS=`wc --bytes " & fn & " | cut -d' ' -f1`; echo $((MS-{:d}))")
    discard staticExec("head -c " & ss & " " & fn & " > Main2.nim")
    let s = staticExec("du -a")
    doAssert false, s
    let (output, ex) = gorgeEx("{:s} Main2.nim")
    discard staticExec("rm -rf ./atcoder && rm Main2.nim");doAssert ex == 0, output;quit(0)
""".format(len(d), md5sum, len(d), second_compile_command)
            outputSuffix += d
        else:
            if system_name == 'Darwin':
                s = subprocess.run("cat atcoder.tar.xz | base64 -b 0", cwd=lib_tmp, shell=True, stdout=subprocess.PIPE).stdout.decode()
            elif system_name == 'Linux':
                s = subprocess.run("cat atcoder.tar.xz | base64 -w 0", cwd=lib_tmp, shell=True, stdout=subprocess.PIPE).stdout.decode()
            else:
                print('unknown system')
            if s[-1] == '\n':
                print("WARNING!!! newline")
                s = s.strip()
            outputPrefix += """
static:
  when not defined SecondCompile:
    # md5sum: {:s}
    template getFileName():string = instantiationInfo().filename
    let fn = getFileName()
    block:
      let (output, ex) = gorgeEx("if [ -e ./atcoder ]; then exit 1; else exit 0; fi")
      doAssert ex == 0, "atcoder directory already exisits"
    discard staticExec("echo \\"{:s}\\" | base64 -d > atcoder.tar.xz && tar -Jxvf atcoder.tar.xz")
    let (output, ex) = gorgeEx("{:s} " & fn)
    discard staticExec("rm -rf ./atcoder");doAssert ex == 0, output;quit(0)
""".format(md5sum, s, second_compile_command)

    output = (outputPrefix + '\n\n' + '\n'.join(result) + '\n').encode() + outputSuffix
    if opts.console:
        print(output.decode())
    else:
        #with open('combined.nim', 'w', encoding="utf8", errors='ignore') as f:
        with open('combined.nim', 'wb') as f:
            f.write(output)
        md5sum_combined = subprocess.run("md5sum combined.nim", shell=True, stdout=subprocess.PIPE).stdout.decode()
        with open('/tmp/md5sum_combined.txt', 'w') as f:
            f.write(md5sum_combined)


if __name__ == "__main__":
    main()
