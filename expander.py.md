---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: py
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/python.py\"\
    , line 96, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "#!/usr/bin/env python3\n\nimport re\nimport argparse\nfrom logging import\
    \ Logger, basicConfig, getLogger\nfrom os import getenv, environ\nfrom pathlib\
    \ import Path\nfrom typing import List\n\n\nlogger = getLogger(__name__)  # type:\
    \ Logger\n\nATCODER_INCLUDE = re.compile(\n        r'\\s*(?:include|import)\\\
    s*([a-zA-Z0-9_,./\\s\"]*)\\s*')\n\nWHEN_STATEMENT = re.compile(r'^\\s*when\\s+.*:')\n\
    ATCODER_DIR = 'atcoder/'\n\n\ndef indent_level(line: str):\n    \"\"\"\n    \u30A4\
    \u30F3\u30C7\u30F3\u30C8\u7528\u306E\u30B9\u30DA\u30FC\u30B9\u304C\u3044\u304F\
    \u3064\u3042\u308B\u304B\u3092\u8FD4\u3059\n    \"\"\"\n    for i, _c in enumerate(line):\n\
    \        if _c != ' ':\n            return i\n    return len(line)\n\n\ndef strip_as(line:\
    \ str) -> str:\n    \"\"\"\n    import\u6642\u306Eas\u3092\u53D6\u308A\u9664\u304F\
    \n    \"\"\"\n    pos = line.find(' as ')\n    if pos != -1:\n        line = line[:pos]\n\
    \    return line\n\n\ndef read_source(source: str, level: int, defined: set, lib_path)\
    \ -> List[str]:\n    \"\"\"\n    string\u3067\u6E21\u3055\u308C\u305Fsource\u3092\
    \u8AAD\u307F\u3002import, include\u304C\u51FA\u3066\u304D\u305F\u3089\u6DF1\u5800\
    \u308A\u3059\u308B\n    \"\"\"\n    result = []\n    for line in source.splitlines():\n\
    \        if WHEN_STATEMENT.match(line):\n            result.append(line)\n   \
    \     else:\n            matched = ATCODER_INCLUDE.match(line)\n            if\
    \ matched:\n                for fname in matched.group(1).split(\",\"):\n    \
    \                fname_orig = fname = fname.strip()\n                    if fname[0]\
    \ == '\\\"':\n                        print(fname)\n                        assert\
    \ fname[-1] == '\\\"'\n                        fname = fname[1:-1]\n         \
    \           if fname.startswith(ATCODER_DIR):\n                        fname =\
    \ strip_as(fname)\n                        fname = \"src/\" + fname\n        \
    \                if not fname.endswith(\".nim\"):\n                          \
    \  fname += \".nim\"\n                        result.extend(dfs(fname, level +\
    \ 1, defined, lib_path))\n                    else:\n                        spaces\
    \ = indent_level(line)\n                        result.extend([\" \" * spaces\
    \ + \"import \" + fname_orig])\n            else:\n                result.append(line)\n\
    \    if level > 0:\n        result.append(\"  discard\")\n        result2 = []\n\
    \        for line in result:\n            result2.append(\"  \" + line)\n    \
    \    result = result2\n    return result\n\n\ndef dfs(f: str, level: int, defined:\
    \ set, lib_path) -> List[str]:\n    \"\"\"\n    \u6DF1\u3055\u512A\u5148\u3067\
    import/include\u3092\u8ABF\u3079\u308B\n    \"\"\"\n    if f in defined:\n   \
    \     logger.info('already included {:s}, skip'.format(f))\n        return []\n\
    \    defined.add(f)\n\n    logger.info('include {:s}'.format(f))\n\n    source\
    \ = open(str(lib_path / f), encoding=\"utf8\", errors='ignore').read()\n    return\
    \ read_source(source, level, defined, lib_path)\n\n\ndef main():\n    \"\"\"\n\
    \    \u30E1\u30A4\u30F3\u95A2\u6570\n    \"\"\"\n    lib_path = Path.cwd()\n \
    \   basicConfig(\n        format=\"%(asctime)s [%(levelname)s] %(message)s\",\n\
    \        datefmt=\"%H:%M:%S\",\n        level=getenv('LOG_LEVEL', 'INFO'),\n \
    \   )\n    parser = argparse.ArgumentParser(description='Expander')\n    parser.add_argument('source',\
    \ help='Source File')\n    parser.add_argument('-c', '--console',\n          \
    \              action='store_true', help='Print to Console')\n    parser.add_argument('--lib',\
    \ help='Path to Atcoder Library')\n    opts = parser.parse_args()\n\n    if opts.lib:\n\
    \        lib_path = Path(opts.lib)\n    elif 'NIM_INCLUDE_PATH' in environ:\n\
    \        lib_path = Path(environ['NIM_INCLUDE_PATH'])\n    source = open(opts.source,\
    \ encoding=\"utf8\", errors='ignore').read()\n    result = read_source(source,\
    \ -1, set(), lib_path)\n\n    output = '\\n'.join(result) + '\\n'\n    if opts.console:\n\
    \        print(output)\n    else:\n        with open('combined.nim', 'w', encoding=\"\
    utf8\", errors='ignore') as f:\n            f.write(output)\n\n\nif __name__ ==\
    \ \"__main__\":\n    main()\n"
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
