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
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_SOLVEPROC_HPP:\n  const ATCODER_SOLVEPROC_HPP*\
    \ = 1\n  import std/macros, std/strformat, std/algorithm\n  proc mainBodyHeader():NimNode\
    \ =\n    result = newStmtList()\n    result.add parseStmt \"result = \\\"\\\"\"\
    \n    result.add parseStmt \"var resultPointer = result.addr\"\n#    let macro_def\
    \ = \"(for s in {x.repr}: (result &= $s;(when output_stdout: stdout.write $s)));(result\
    \ &= \\\"\\\\n\\\";when output_stdout: stdout.write \\\"\\\\n\\\")\"\n    let\
    \ d = &\"proc echo(x:varargs[string, `$`]) = (for s in x: (resultPointer[] &=\
    \ $s; when output_stdout: stdout.write $s)); (resultPointer[] &= \\\"\\\\n\\\"\
    ; when output_stdout: stdout.write \\\"\\\\n\\\")\"\n    result.add parseStmt(d)\n\
    \n  macro solveProc*(head, body:untyped):untyped =\n    var prev_type:NimNode\n\
    \    var params:seq[NimNode]\n    for i in countdown(head.len - 1, 1):\n     \
    \ var identDefs = newNimNode(nnkIdentDefs)\n      if head[i].kind == nnkExprColonExpr:\n\
    \        identDefs.add(head[i][0])\n        prev_type = head[i][1]\n      elif\
    \ head[i].kind == nnkIdent:\n        identDefs.add(head[i])\n      identDefs.add(prev_type)\n\
    \      identDefs.add(newEmptyNode())\n      params.add(identDefs)\n    params.add(ident\"\
    auto\")\n    params.reverse()\n    var callparams:seq[NimNode]\n    for i in 1..<params.len:\n\
    \      callparams.add(params[i][0])\n#    var mainBody, naiveBody = mainBodyHeader()\n\
    \    var mainBody, checkBody, naiveBody, testBody, generateBody = newStmtList()\n\
    \    var hasNaive, hasCheck, hasTest, hasGenerate = false\n    for b in body:\n\
    \      if b.kind == nnkCall:\n        if b[0] == ident\"Check\":\n          hasCheck\
    \ = true\n          checkBody.add b[1]\n        elif b[0] == ident\"Naive\":\n\
    \          hasNaive = true\n          naiveBody.add b[1]\n        elif b[0] ==\
    \ ident\"Test\":\n          hasTest = true\n          testBody.add b[1]\n    \
    \    elif b[0] == ident\"Generate\":\n          hasGenerate = true\n         \
    \ generateBody.add b[1]\n        else:\n          mainBody.add b\n      else:\n\
    \        mainBody.add b\n    mainBody = newStmtList().add newBlockStmt(newEmptyNode(),\
    \ newStmtList().add(mainBodyHeader()).add(mainBody))\n    if hasCheck:\n     \
    \ mainBody.add(checkBody)\n    result = newStmtList()\n    let procName = $head[0]\n\
    \    var discardablePragma = newNimNode(nnkPragma).add(ident(\"discardable\"))\n\
    \    var mainParams = params\n    mainParams[0] = ident\"string\"\n    var identDefs\
    \ = newNimNode(nnkIdentDefs)\n    identDefs.add(ident\"output_stdout\")\n    identDefs.add(newNimNode(nnkBracketExpr).add(ident\"\
    static\").add(ident\"bool\"))\n    identDefs.add(ident\"true\")\n    mainParams.add(identDefs)\n\
    \    var mainProcDef = newNimNode(nnkProcDef).add(ident\"solve\").add(newEmptyNode()).add(newEmptyNode()).add(newNimNode(nnkFormalParams).add(mainParams)).add(discardablePragma).add(newEmptyNode()).add(newEmptyNode())\n\
    \    result.add(mainProcDef)\n    if hasNaive:\n      var naiveProcDef = newNimNode(nnkProcDef).add(ident\"\
    solve_naive\").add(newEmptyNode()).add(newEmptyNode()).add(newNimNode(nnkFormalParams).add(mainParams)).add(discardablePragma).add(newEmptyNode()).add(newEmptyNode())\n\
    \      result.add(naiveProcDef)\n\n\n    var naiveParams = mainParams\n    result.add\
    \ newProc(name = ident(procName), params = mainParams, body = mainBody, pragmas\
    \ = discardablePragma)\n#    echo mainParams.repr\n    if hasNaive:\n      let\
    \ naiveProcName = procName & \"naive\"\n      naiveBody = mainBodyHeader().add(newBlockStmt(newEmptyNode(),\
    \ naiveBody))\n      result.add newProc(name = ident(naiveProcName), params =\
    \ naiveParams, body = naiveBody, pragmas = discardablePragma)\n#      var b =\
    \ newNimNode(nnkInfix)\n      var test_body = newStmtList()\n      var var_names\
    \ = newSeq[string]()\n      for procName in [procName, procName & \"_naive\"]:\n\
    \        let var_name = \"v\" & procName\n        var_names.add(var_name)\n  \
    \      var l = newNimNode(nnkCall).add(ident(procName))\n        for c in callparams:\
    \ l.add(c)\n        l.add(ident\"false\")\n        test_body.add(\n          newNimNode(nnkLetSection).add(\n\
    \            newNimNode(nnkIdentDefs).add(ident(var_name)).add(newEmptyNode()).add(l)\n\
    \          ))\n      var test_params = params\n      var vars = \"\"\n      for\
    \ i in 1..<params.len:\n        let p = params[i][0]\n        vars &= &\"  {p.repr}\
    \ = {{{p.repr}}}\\\\n\"\n      test_params[0] = ident\"bool\"\n      test_body.add\
    \ parseStmt(&\"if vsolve != vsolve_naive: echo &\\\"test failed for\\\\n{vars}\\\
    \", \\\"[solve]\\\\n\\\", vsolve, \\\"[solve_naive]\\\\n\\\", vsolve_naive;doAssert\
    \ false\")\n      result.add newProc(name = ident\"test\", params = test_params,\
    \ body = test_body, pragmas = discardablePragma)\n    if hasGenerate:\n      discard\n\
    \    if hasTest:\n      discard\n#    echo result.repr\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/other/solve_proc.nim
  requiredBy:
  - atcoder/extra/header/chaemon_header.nim
  - atcoder/extra/header/chaemon_header.nim
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/other/solve_proc.nim
layout: document
redirect_from:
- /library/atcoder/extra/other/solve_proc.nim
- /library/atcoder/extra/other/solve_proc.nim.html
title: atcoder/extra/other/solve_proc.nim
---
