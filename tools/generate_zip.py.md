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
  code: "#!/usr/bin/env python3\n\nfrom logging import Logger, basicConfig, getLogger\n\
    from os import getenv\nfrom pathlib import Path\nimport zipfile\n\nlogger: Logger\
    \ = getLogger(__name__)\n\nif __name__ == \"__main__\":\n    basicConfig(\n  \
    \      format=\"%(asctime)s [%(levelname)s] %(message)s\",\n        datefmt=\"\
    %H:%M:%S\",\n        level=getenv('LOG_LEVEL', 'INFO'),\n    )\n    with zipfile.ZipFile('ac-library.zip',\
    \ 'w') as zipf:\n        langs = ['en', 'ja']\n        for lang in langs:\n  \
    \          for f in (Path('..') / 'document_{}'.format(lang)).glob('*.html'):\n\
    \                zipf.write(f, 'document_{}/'.format(lang) + f.name)\n\n\n   \
    \     for f in (Path('..') / 'atcoder').glob('*'):\n            zipf.write(f,\
    \ f.relative_to(Path('..')))\n\n        zipf.write('../expander.py', 'expander.py')\n"
  dependsOn: []
  isVerificationFile: false
  path: tools/generate_zip.py
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: tools/generate_zip.py
layout: document
redirect_from:
- /library/tools/generate_zip.py
- /library/tools/generate_zip.py.html
title: tools/generate_zip.py
---
