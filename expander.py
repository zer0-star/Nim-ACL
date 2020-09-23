#!/usr/bin/env python3

import re
import sys
import argparse
from logging import Logger, basicConfig, getLogger
from os import getenv, environ
from pathlib import Path
from typing import List


logger = getLogger(__name__)  # type: Logger

atcoder_include = re.compile('\s*(?:include|import)\s*([a-z0-9_,/\s"]*)\s*')

include_guard = re.compile('when\s+not\s+declared\s+ATCODER_[A-Z_]*_HPP')
atcoder_dir = 'atcoder/'

lib_path = Path.cwd()

defined = set()

def trailingSpace(s:str):
    for i in range(0, len(s)):
        if s[i] != ' ':
            return i
    return len(s)

def read_source(s:str, level:int) -> List[str]:
    result = []
#    if level >= 0:
#        result.append("when true:")
    for line in s.splitlines():
        if include_guard.match(line):
            result.append(line)
            continue

        m = atcoder_include.match(line)
        if m:
            for f in m.group(1).split(","):
                f_orig = f = f.strip()
                if f[0] == '\"':
                    assert f[-1] == '\"'
                    f = f[1:-1]
                if not f.startswith(atcoder_dir):
                    d = trailingSpace(line)
                    result.extend([" " * d + "import " + f_orig])
                else:
                    if not f.endswith(".nim"):
                        f = "src/" + f + ".nim"
                    result.extend(dfs(f, level + 1))
            continue
        result.append(line)
    if level > 0:
        result.append("  discard")
        result2 = []
#        print(level)
        for line in result:
#            result2.append("  " * level + line)
            result2.append("  " + line)
        result = result2
    return result


def dfs(f: str, level:int) -> List[str]:
    global defined
    if f in defined:
        logger.info('already included {}, skip'.format(f))
        return []
    defined.add(f)

    logger.info('include {}'.format(f))

    s = open(str(lib_path / f)).read()
    return read_source(s, level)

if __name__ == "__main__":
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
    elif 'CPLUS_INCLUDE_PATH' in environ:
        lib_path = Path(environ['CPLUS_INCLUDE_PATH'])
    s = open(opts.source).read()
    result = read_source(s, -1)

    output = '\n'.join(result) + '\n'
    if opts.console:
        print(output)
    else:
        with open('combined.nim', 'w') as f:
            f.write(output)
