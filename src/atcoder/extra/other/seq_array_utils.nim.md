---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: atcoder/extra/header/chaemon_header.nim
    title: atcoder/extra/header/chaemon_header.nim
  - icon: ':warning:'
    path: atcoder/extra/header/chaemon_header.nim
    title: atcoder/extra/header/chaemon_header.nim
  - icon: ':warning:'
    path: atcoder/extra/header/chaemon_header.nim
    title: atcoder/extra/header/chaemon_header.nim
  - icon: ':warning:'
    path: atcoder/extra/header/chaemon_header.nim
    title: atcoder/extra/header/chaemon_header.nim
  - icon: ':warning:'
    path: atcoder/extra/header/header.nim
    title: atcoder/extra/header/header.nim
  - icon: ':warning:'
    path: atcoder/extra/header/header.nim
    title: atcoder/extra/header/header.nim
  - icon: ':warning:'
    path: atcoder/extra/header/header.nim
    title: atcoder/extra/header/header.nim
  - icon: ':warning:'
    path: atcoder/extra/header/header.nim
    title: atcoder/extra/header/header.nim
  - icon: ':warning:'
    path: atcoder/extra/template/atcoder-tools_template.nim
    title: atcoder/extra/template/atcoder-tools_template.nim
  - icon: ':warning:'
    path: atcoder/extra/template/atcoder-tools_template.nim
    title: atcoder/extra/template/atcoder-tools_template.nim
  - icon: ':warning:'
    path: atcoder/extra/template/atcoder-tools_template.nim
    title: atcoder/extra/template/atcoder-tools_template.nim
  - icon: ':warning:'
    path: atcoder/extra/template/atcoder-tools_template.nim
    title: atcoder/extra/template/atcoder-tools_template.nim
  - icon: ':warning:'
    path: atcoder/extra/template/atcoder-tools_template_global.nim
    title: atcoder/extra/template/atcoder-tools_template_global.nim
  - icon: ':warning:'
    path: atcoder/extra/template/atcoder-tools_template_global.nim
    title: atcoder/extra/template/atcoder-tools_template_global.nim
  - icon: ':warning:'
    path: atcoder/extra/template/atcoder-tools_template_global.nim
    title: atcoder/extra/template/atcoder-tools_template_global.nim
  - icon: ':warning:'
    path: atcoder/extra/template/atcoder-tools_template_global.nim
    title: atcoder/extra/template/atcoder-tools_template_global.nim
  - icon: ':warning:'
    path: atcoder/extra/template/atcoder-tools_template_with_solve.nim
    title: atcoder/extra/template/atcoder-tools_template_with_solve.nim
  - icon: ':warning:'
    path: atcoder/extra/template/atcoder-tools_template_with_solve.nim
    title: atcoder/extra/template/atcoder-tools_template_with_solve.nim
  - icon: ':warning:'
    path: atcoder/extra/template/atcoder-tools_template_with_solve.nim
    title: atcoder/extra/template/atcoder-tools_template_with_solve.nim
  - icon: ':warning:'
    path: atcoder/extra/template/atcoder-tools_template_with_solve.nim
    title: atcoder/extra/template/atcoder-tools_template_with_solve.nim
  - icon: ':warning:'
    path: atcoder/extra/template/template.nim
    title: atcoder/extra/template/template.nim
  - icon: ':warning:'
    path: atcoder/extra/template/template.nim
    title: atcoder/extra/template/template.nim
  - icon: ':warning:'
    path: atcoder/extra/template/template.nim
    title: atcoder/extra/template/template.nim
  - icon: ':warning:'
    path: atcoder/extra/template/template.nim
    title: atcoder/extra/template/template.nim
  - icon: ':warning:'
    path: atcoder/extra/template/vim_template.nim
    title: atcoder/extra/template/vim_template.nim
  - icon: ':warning:'
    path: atcoder/extra/template/vim_template.nim
    title: atcoder/extra/template/vim_template.nim
  - icon: ':warning:'
    path: atcoder/extra/template/vim_template.nim
    title: atcoder/extra/template/vim_template.nim
  - icon: ':warning:'
    path: atcoder/extra/template/vim_template.nim
    title: atcoder/extra/template/vim_template.nim
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
  code: "when not declared ATCODER_SEQ_ARRAY_UTILS:\n  const ATCODER_SEQ_ARRAY_UTILS*\
    \ = 1\n  import std/strformat, std/macros\n  type SeqType = object\n  type ArrayType\
    \ = object\n  let\n    Seq* = SeqType()\n    Array* = ArrayType()\n\n  template\
    \ fill*[T](a:var T, init:untyped) =\n    when T is init.type:\n      a = init\n\
    \    else:\n      for x in a.mitems: fill(x, init)\n\n  template makeSeq*(x:int;\
    \ init):auto =\n    when init is typedesc: newSeq[init](x)\n    else:\n      var\
    \ a = newSeq[typeof(init, typeofProc)](x)\n      a.fill(init)\n      a\n\n  template\
    \ makeArray*(x:int or Slice[int]; init):auto =\n    var v:array[x, init.type]\n\
    \    v\n\n  macro `[]`*(x:ArrayType or SeqType, args:varargs[untyped]):auto =\n\
    \    var a:string\n    if $x == \"Seq\" and args.len == 1 and args[0].kind !=\
    \ nnkExprColonExpr:\n      a = fmt\"newSeq[{args[0].repr}]()\"\n    else:\n  \
    \    let tail = args[^1]\n      assert tail.kind == nnkExprColonExpr, \"Wrong\
    \ format of tail\"\n      let\n        args = args[0 .. ^2] & tail[0]\n      \
    \  init = tail[1]\n      a = fmt\"{init.repr}\"\n      if $x == \"Array\":\n \
    \       for i in countdown(args.len - 1, 0): a = fmt\"makeArray({args[i].repr},\
    \ {a})\"\n        a = fmt\"{'\\n'}block:{'\\n'}  var a = {a}{'\\n'}  when {init.repr}\
    \ isnot typedesc:{'\\n'}    a.fill({init.repr}){'\\n'}  a\"\n      elif $x ==\
    \ \"Seq\":\n        for i in countdown(args.len - 1, 0): a = fmt\"makeSeq({args[i].repr},\
    \ {a})\"\n        a = fmt\"{'\\n'}block:{'\\n'}  {a}\"\n      else:\n        assert(false)\n\
    \    parseStmt(a)\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/other/seq_array_utils.nim
  requiredBy:
  - atcoder/extra/header/chaemon_header.nim
  - atcoder/extra/header/chaemon_header.nim
  - atcoder/extra/header/header.nim
  - atcoder/extra/header/header.nim
  - atcoder/extra/template/vim_template.nim
  - atcoder/extra/template/vim_template.nim
  - atcoder/extra/template/atcoder-tools_template_with_solve.nim
  - atcoder/extra/template/atcoder-tools_template_with_solve.nim
  - atcoder/extra/template/atcoder-tools_template.nim
  - atcoder/extra/template/atcoder-tools_template.nim
  - atcoder/extra/template/atcoder-tools_template_global.nim
  - atcoder/extra/template/atcoder-tools_template_global.nim
  - atcoder/extra/template/template.nim
  - atcoder/extra/template/template.nim
  - atcoder/extra/header/chaemon_header.nim
  - atcoder/extra/header/chaemon_header.nim
  - atcoder/extra/header/header.nim
  - atcoder/extra/header/header.nim
  - atcoder/extra/template/vim_template.nim
  - atcoder/extra/template/vim_template.nim
  - atcoder/extra/template/atcoder-tools_template_with_solve.nim
  - atcoder/extra/template/atcoder-tools_template_with_solve.nim
  - atcoder/extra/template/atcoder-tools_template.nim
  - atcoder/extra/template/atcoder-tools_template.nim
  - atcoder/extra/template/atcoder-tools_template_global.nim
  - atcoder/extra/template/atcoder-tools_template_global.nim
  - atcoder/extra/template/template.nim
  - atcoder/extra/template/template.nim
  timestamp: '2022-02-05 00:42:13+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/other/seq_array_utils.nim
layout: document
redirect_from:
- /library/atcoder/extra/other/seq_array_utils.nim
- /library/atcoder/extra/other/seq_array_utils.nim.html
title: atcoder/extra/other/seq_array_utils.nim
---
