---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.5/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.5/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_SPECIAL_JUDGE_HPP:\n  const ATCODER_SPECIAL_JUDGE_HPP*\
    \ = 1\n  when declared(DEBUG):\n    when DEBUG:\n      var strm = newStringStream(\"\
    \")\n      proc echo*(s:varargs[string, toStr]) =\n        let s = s.join(\"\"\
    )\n        strm.write(s & \"\\n\")\n        system.echo(s.join(\"\"))\n  \n  template\
    \ check*(body:untyped):untyped =\n    when declared(DEBUG):\n      when DEBUG:\n\
    \        strm.setPosition(0)\n        body\n    discard\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/other/special_judge.nim
  requiredBy: []
  timestamp: '2021-03-01 01:28:35+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/other/special_judge.nim
layout: document
redirect_from:
- /library/atcoder/extra/other/special_judge.nim
- /library/atcoder/extra/other/special_judge.nim.html
title: atcoder/extra/other/special_judge.nim
---
