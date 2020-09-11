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

include_guard = re.compile('when.*ATCODER_[A-Z_]*_HPP')
atcoder_dir = 'src/nim_acl/'

lib_path = Path.cwd()

defined = set()

def trailingSpace(s:str):
    for i in range(0, len(s)):
        if s[i] != ' ':
            return i
    return len(s)

def dfs(f: str, level:int) -> List[str]:
    global defined
    if f in defined:
        logger.info('already included {}, skip'.format(f))
        return []
    defined.add(f)

    logger.info('include {}'.format(f))

    s = open(str(lib_path / f)).read()
    result = []
    result.append("when true:")
    for line in s.splitlines():
        if include_guard.match(line):
            continue

        m = atcoder_include.match(line)
        if m:
            for f in m.group(1).split(","):
                if not f.startswith(atcoder_dir):
                    result.extend([" " * trailingSpace(line) + "import " + f])
                else:
                    if not f.endswith(".nim"):
                        f = f + ".nim"
                    result.extend(dfs(f, level + 1))
            continue
        result.append(line)
    result.append("  discard")
    result2 = []
    for line in result:
        result2.append("  " * level + line)
    return result2


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

    result = []
    for line in s.splitlines():
        m = atcoder_include.match(line)

        if m:
            for f in m.group(1).split(","):
                f = f.strip()
                if not f.startswith(atcoder_dir):
                    result.extend([" " * trailingSpace(line) + "import " + f])
                else:
                    if not f.endswith(".nim"):
                        f = f + ".nim"
                    result.extend(dfs(f, 0))
            continue
        result.append(line)

    output = '\n'.join(result) + '\n'
    if opts.console:
        print(output)
    else:
        with open('combined.nim', 'w') as f:
            f.write(output)
