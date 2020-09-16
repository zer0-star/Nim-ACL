---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _pathExtension: py
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 70, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir).decode()\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/python.py\"\
    , line 84, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "#!/usr/bin/env python3\n\nimport re\nimport sys\nimport argparse\nfrom logging\
    \ import Logger, basicConfig, getLogger\nfrom os import getenv, environ\nfrom\
    \ pathlib import Path\nfrom typing import List\n\n\nlogger = getLogger(__name__)\
    \  # type: Logger\n\natcoder_include = re.compile('\\s*(?:include|import)\\s*([a-z0-9_,/\\\
    s\"]*)\\s*')\n\ninclude_guard = re.compile('when\\s+not\\s+declared\\s+ATCODER_[A-Z_]*_HPP')\n\
    atcoder_dir = 'src/nim_acl/'\n\nlib_path = Path.cwd()\n\ndefined = set()\n\ndef\
    \ trailingSpace(s:str):\n    for i in range(0, len(s)):\n        if s[i] != '\
    \ ':\n            return i\n    return len(s)\n\ndef read_source(s:str, level:int)\
    \ -> List[str]:\n    result = []\n#    if level >= 0:\n#        result.append(\"\
    when true:\")\n    for line in s.splitlines():\n        if include_guard.match(line):\n\
    \            result.append(line)\n            continue\n\n        m = atcoder_include.match(line)\n\
    \        if m:\n            for f in m.group(1).split(\",\"):\n              \
    \  f_orig = f = f.strip()\n                if f[0] == '\\\"':\n              \
    \      assert f[-1] == '\\\"'\n                    f = f[1:-1]\n             \
    \   if not f.startswith(atcoder_dir):\n                    result.extend([\" \"\
    \ * trailingSpace(line) + \"import \" + f_orig])\n                else:\n    \
    \                if not f.endswith(\".nim\"):\n                        f = f +\
    \ \".nim\"\n                    result.extend(dfs(f, level + 1))\n           \
    \ continue\n        result.append(line)\n    if level >= 0:\n        result.append(\"\
    \  discard\")\n        result2 = []\n        for line in result:\n           \
    \ result2.append(\"  \" * level + line)\n        result = result2\n    return\
    \ result\n\n\ndef dfs(f: str, level:int) -> List[str]:\n    global defined\n \
    \   if f in defined:\n        logger.info('already included {}, skip'.format(f))\n\
    \        return []\n    defined.add(f)\n\n    logger.info('include {}'.format(f))\n\
    \n    s = open(str(lib_path / f)).read()\n    return read_source(s, level)\n\n\
    if __name__ == \"__main__\":\n    basicConfig(\n        format=\"%(asctime)s [%(levelname)s]\
    \ %(message)s\",\n        datefmt=\"%H:%M:%S\",\n        level=getenv('LOG_LEVEL',\
    \ 'INFO'),\n    )\n    parser = argparse.ArgumentParser(description='Expander')\n\
    \    parser.add_argument('source', help='Source File')\n    parser.add_argument('-c',\
    \ '--console',\n                        action='store_true', help='Print to Console')\n\
    \    parser.add_argument('--lib', help='Path to Atcoder Library')\n    opts =\
    \ parser.parse_args()\n\n    if opts.lib:\n        lib_path = Path(opts.lib)\n\
    \    elif 'CPLUS_INCLUDE_PATH' in environ:\n        lib_path = Path(environ['CPLUS_INCLUDE_PATH'])\n\
    \    s = open(opts.source).read()\n    result = read_source(s, -1)\n\n    output\
    \ = '\\n'.join(result) + '\\n'\n    if opts.console:\n        print(output)\n\
    \    else:\n        with open('combined.nim', 'w') as f:\n            f.write(output)\n"
  dependsOn: []
  isVerificationFile: false
  path: expander.py
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: expander.py
layout: document
redirect_from:
- /library/expander.py
- /library/expander.py.html
title: expander.py
---
