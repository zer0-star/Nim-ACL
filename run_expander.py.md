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
  code: "#!/usr/bin/python3\n# -*- coding: utf-8 -*-\n\nimport sys, subprocess, os\n\
    \nargs = sys.argv\n\nfile_name = args[1]\next = os.path.splitext(file_name)[1]\n\
    combined_file_name = \"combined\" + ext\nhome_dir = \"/home/chaemon\"\n\nif ext\
    \ == '.cpp':\n    expander_path = home_dir + \"/git/ac-library/expander.py\"\n\
    \    lib_path = home_dir + \"/git/ac-library/\"\nelif ext == '.nim':\n    expander_path\
    \ = home_dir + \"/git/Nim-ACL/expander.py\"\n    lib_path = home_dir + \"/git/Nim-ACL/\"\
    \nelse:\n    print(\"Undefined Extension\")\n    exit(1)\n\nos.system(\"python3\
    \ {} {} --lib {}\".format(expander_path, file_name, lib_path))\nos.system(\"cat\
    \ {} | xsel --clipboard --input\".format(combined_file_name))\nos.system(\"rm\
    \ {}\".format(combined_file_name))\n"
  dependsOn: []
  isVerificationFile: false
  path: run_expander.py
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: run_expander.py
layout: document
redirect_from:
- /library/run_expander.py
- /library/run_expander.py.html
title: run_expander.py
---
