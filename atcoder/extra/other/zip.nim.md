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
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_ZIP_HPP:\n  const ATCODER_ZIP_HPP* = 1\n  import\
    \ macros\n\n  macro zip*(v:varargs[untyped]):untyped =\n    result = newStmtList()\n\
    \    var par = newPar()\n    for i,a in v:\n      var ts = newNimNode(nnkTypeSection)\n\
    \      par.add(ident(\"T\" & $i))\n      ts.add(newNimNode(nnkTypeDef).add(\n\
    \        ident(\"T\" & $i),\n        newEmptyNode(),\n        newDotExpr(newNimNode(nnkBracketExpr).add(a,\
    \ newIntLitNode(0)), ident(\"type\"))\n      ))\n      result.add ts\n    var\
    \ varSection = newNimNode(nnkVarSection)\n    varSection.add newIdentDefs(ident(\"\
    a\"), newEmptyNode(), newCall(\n      newNimNode(nnkBracketExpr).add(\n      \
    \  ident(\"newSeq\"), \n        par\n      ), \n      ident(\"n\")\n    ))\n \
    \   result.add newNimNode(nnkLetSection).add(newIdentDefs(ident(\"n\"), newEmptyNode(),\
    \ \n      newDotExpr(v[0] , ident(\"len\"))\n    ))\n    result.add(varSection)\n\
    \  \n    var forStmt = newNimNode(nnkForStmt).add(ident(\"i\")).add(\n      newNimNode(nnkInfix).add(ident(\"\
    ..<\")).add(newIntLitNode(0), ident(\"n\"))\n    )\n    var fs = newStmtList()\n\
    \    for j,a in v:\n      fs.add newAssignment(\n        newNimNode(nnkBracketExpr).add(\n\
    \          newNimNode(nnkBracketExpr).add(\n            ident(\"a\"), \n     \
    \       ident(\"i\")\n          ), \n          newIntLitNode(j)), \n        newNimNode(nnkBracketExpr).add(\n\
    \          a, \n          ident(\"i\")\n        )\n      )\n    forStmt.add fs\n\
    \    result.add(forStmt)\n    result.add(ident(\"a\"))\n    result = newBlockStmt(newEmptyNode(),\
    \ result)\n  \n  macro unzip*(n:int, p:tuple):untyped = \n    result = newStmtList()\n\
    \    result.add(newNimNode(nnkLetSection).add(newIdentDefs(ident(\"n\"), newEmptyNode(),\
    \ n)))\n    for i,a in p:\n      var a = newPar(a)\n      var t = newCall(\n \
    \       newNimNode(nnkBracketExpr).add(\n          ident(\"newSeq\"), \n     \
    \     newDotExpr(a, ident(\"type\"))\n        ), \n        ident(\"n\")\n    \
    \  )\n      var varSection = newNimNode(nnkVarSection).add(\n        newIdentDefs(ident(\"\
    a\" & $i), newEmptyNode(), t), \n      )\n      result.add(varSection)\n    var\
    \ forStmt = newNimNode(nnkForStmt).add(ident(\"i\"))\n    var rangeDef = newNimNode(nnkInfix).add(ident(\"\
    ..<\")).add(newIntLitNode(0), ident(\"n\"))\n    forStmt.add(rangeDef)\n    var\
    \ fs = newStmtList()\n    for i,a in p:\n      fs.add newAssignment(\n       \
    \ newNimNode(nnkBracketExpr).add(\n          ident(\"a\" & $i), \n          ident(\"\
    i\")), \n        a\n      )\n    forStmt.add fs\n    result.add(forStmt)\n   \
    \ var par = newPar()\n    for i, a in p:\n      par.add(ident(\"a\" & $i))\n \
    \   result.add(par)\n    result = newBlockStmt(newEmptyNode(), result)\n\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/other/zip.nim
  requiredBy:
  - atcoder/extra/header/chaemon_header.nim
  - atcoder/extra/header/chaemon_header.nim
  - atcoder/extra/header/chaemon_header.nim
  - atcoder/extra/header/chaemon_header.nim
  timestamp: '2021-03-01 01:28:35+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/other/zip.nim
layout: document
redirect_from:
- /library/atcoder/extra/other/zip.nim
- /library/atcoder/extra/other/zip.nim.html
title: atcoder/extra/other/zip.nim
---
