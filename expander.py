#!/usr/bin/env python3

import re
import argparse
from logging import Logger, basicConfig, getLogger
from os import getenv, environ
from pathlib import Path
from typing import List


logger = getLogger(__name__)  # type: Logger

ATCODER_INCLUDE = re.compile(
        r'\s*(?:include|import)\s*([a-zA-Z0-9_,./\s"]*)\s*')

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


def read_source(f: str, prefix: str, defined: set, lib_path, start=True) -> List[str]:
    """
    stringで渡されたsourceを読み。import, includeが出てきたら深堀りする
    深さ優先でimport/includeを調べる
    """
    if f in defined:
        logger.info('already included {:s}, skip'.format(f))
        return []
    defined.add(f)

    logger.info('include {:s}'.format(f))
    
    if start:
        source = open(f, encoding="utf8", errors='ignore').read()
    else:
        source = open(str(lib_path / f), encoding="utf8", errors='ignore').read()

    result = []
    for line in source.splitlines():
        if WHEN_STATEMENT.match(line):
            result.append(line)
        else:
            matched = ATCODER_INCLUDE.match(line)
            if matched:
                for fname in matched.group(1).split(","):
                    fname_orig = fname = fname.strip()
                    if fname[0] == '\"':
                        assert fname[-1] == '\"'
                        fname = fname[1:-1]
                    if ATCODER_DIR.match(fname):
                        fname = strip_as(fname)
                        fname = "src/" + fname
                        if not fname.endswith(".nim"):
                            fname += ".nim"
                        spaces = indent_level(line)
                        result.extend(read_source(fname, " " * spaces, defined, lib_path, False))
                    else:
                        spaces = indent_level(line)
                        result.extend([" " * spaces + "import " + fname_orig])
            else:
                result.append(line)
    if not start:
        result.append("  discard")
    result2 = []
    for line in result:
        result2.append(prefix + line)
    result = result2
    return result


#def dfs(f: str, level: int, defined: set, lib_path) -> List[str]:
#    """
#    深さ優先でimport/includeを調べる
#    """
#    if f in defined:
#        logger.info('already included {:s}, skip'.format(f))
#        return []
#    defined.add(f)
#
#    logger.info('include {:s}'.format(f))
#
#    source = open(str(lib_path / f), encoding="utf8", errors='ignore').read()
#    return read_source(source, level, defined, lib_path)


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
    parser.add_argument('--lib', help='Path to Atcoder Library')
    opts = parser.parse_args()

    if opts.lib:
        lib_path = Path(opts.lib)
    elif 'NIM_INCLUDE_PATH' in environ:
        lib_path = Path(environ['NIM_INCLUDE_PATH'])
#    source = open(opts.source, encoding="utf8", errors='ignore').read()
    result = read_source(opts.source, "", set(), lib_path)

    output = '\n'.join(result) + '\n'
    if opts.console:
        print(output)
    else:
        with open('combined.nim', 'w', encoding="utf8", errors='ignore') as f:
            f.write(output)


if __name__ == "__main__":
    main()
