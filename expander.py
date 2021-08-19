#!/usr/bin/env python3

import re
import argparse
from logging import Logger, basicConfig, getLogger
from os import getenv, environ
from pathlib import Path
from typing import List


logger = getLogger(__name__)  # type: Logger

ATCODER_INCLUDE = re.compile(
        r'\s*(include|import)\s*([a-zA-Z0-9_,./\s"]*)\s*')

WHEN_STATEMENT = re.compile(r'^\s*when\s+.*:')
ATCODER_DIR = re.compile('^(?:atcoder|lib)\/')
INDENT_WIDTH = 2


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
    lib_path = Path.cwd()
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
    parser.add_argument('--lib', help='Path to Atcoder Library')
    opts = parser.parse_args()

    if opts.lib:
        lib_path = Path(opts.lib)
    elif 'NIM_INCLUDE_PATH' in environ:
        lib_path = Path(environ['NIM_INCLUDE_PATH'])
#    source = open(opts.source, encoding="utf8", errors='ignore').read()
    
    def read_source(f: str, prefix: str, defined: set, lib_path, start=True, load_type=None) -> List[str]:
        """
        stringで渡されたsourceを読み。import, includeが出てきたら深堀りする
        深さ優先でimport/includeを調べる
        """
        if f in defined:
            logger.info('already included {:s}, skip'.format(f))
            return []
        defined.add(f)
    
        
        if start:
            source = open(f, encoding="utf8", errors='ignore').read()
        else:
            source = open(str(lib_path / f), encoding="utf8", errors='ignore').read()
            logger.info('{:s} {:s}'.format(load_type, f))
    
        result = []
        i = 0
        source = source.splitlines()
        while i < len(source):
#        for line in source.splitlines():
            line = source[i]
            if WHEN_STATEMENT.match(line):
                result.append(line)
            else:
                matched = ATCODER_INCLUDE.match(line)
                spaces = indent_level(line)
                if matched:
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
                        if i_next >= len(source) or indent_level(source[i_next]) != spaces + INDENT_WIDTH:
                            break
                        i = i_next

                    for fname in fnames:
                        line_local = "{} {}".format(load_type_local, fname)
                        if fname == '':
                            continue
                        if fname[0] == '\"':
                            assert fname[-1] == '\"'
                            fname = fname[1:-1]
                        if ATCODER_DIR.match(fname):
                            fname = strip_as(fname)
                            fname = "src/" + fname
                            if not fname.endswith(".nim"):
                                fname += ".nim"
                            s = read_source(fname, " " * spaces, defined,
                                            lib_path, False, load_type_local)
                            if opts.single_line and start:
                                s0 = ""
                                for l in s:
                                    l = l.replace("\\", "\\\\")
                                    l = l.replace("\"", "\\\"")
                                    s0 += l
                                    s0 += '\\n'
                                url = "https://github.com/zer0-star/Nim-ACL/tree/master/src/{}.nim".format(fname.replace("lib/", "atcoder/extra/"))
                                result.append("# see {}".format(url))
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
        if not start:
            result.append("  discard")
        result2 = []
        for line in result:
            result2.append(prefix + line)
        result = result2
        return result
    result = []
    if opts.single_line:
        result.append("import macros;macro ImportExpand(s:untyped):untyped = parseStmt($s[2])")
    result.extend(read_source(opts.source, "", set(), lib_path))

    output = '\n'.join(result) + '\n'
    if opts.console:
        print(output)
    else:
        with open('combined.nim', 'w', encoding="utf8", errors='ignore') as f:
            f.write(output)


if __name__ == "__main__":
    main()
