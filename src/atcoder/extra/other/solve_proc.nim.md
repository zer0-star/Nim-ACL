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
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_SOLVEPROC_HPP:\n  const ATCODER_SOLVEPROC_HPP*\
    \ = 1\n  import std/macros, std/strformat, std/algorithm, std/sequtils, std/streams\n\
    \  import std/strutils\n  import math\n\n  proc compare_answer_string*(s, t:string,\
    \ error:float = NaN):bool =\n    if error.classify == fcNaN:\n      return s ==\
    \ t\n    else:\n      var\n        s = s.split(\"\\n\")\n        t = t.split(\"\
    \\n\")\n      if s.len != t.len: return false\n      for i in 0 ..< s.len:\n \
    \       var s = s[i].split()\n        var t = t[i].split()\n        if s.len !=\
    \ t.len: return false\n        for j in 0 ..< s.len:\n          if s[j].len ==\
    \ 0:\n            if t[j].len != 0: return false\n          elif t[j].len == 0:\n\
    \            return false\n          else:\n            var fs = s[j].parseFloat\n\
    \            var ft = t[j].parseFloat\n            if abs(fs - ft) > error and\
    \ abs(fs - ft) > min(abs(ft), abs(fs)) * error: return false\n      return true\n\
    \    doAssert false\n\n  proc mainBodyHeader():NimNode =\n#    let macro_def =\
    \ \"(for s in {x.repr}: (result &= $s;(when output_stdout: stdout.write $s)));(result\
    \ &= \\\"\\\\n\\\";when output_stdout: stdout.write \\\"\\\\n\\\")\"\n    result\
    \ = newStmtList()\n    result.add quote(\"@@\") do:\n      mixin echo\n      result\
    \ = \"\"\n      var resultPointer = result.addr\n      proc echo(x:varargs[string,\
    \ `$`]) =\n        for s in x:\n          resultPointer[] &= $s\n          when\
    \ output_stdout: stdout.write $s\n        resultPointer[] &= \"\\n\"\n       \
    \ when output_stdout: stdout.write \"\\n\"\n\n  macro solveProc*(head, body:untyped):untyped\
    \ =\n    var prev_type:NimNode\n    var params:seq[NimNode]\n    for i in countdown(head.len\
    \ - 1, 1):\n      var identDefs = newNimNode(nnkIdentDefs)\n      if head[i].kind\
    \ == nnkExprColonExpr:\n        identDefs.add(head[i][0])\n        prev_type =\
    \ head[i][1]\n      elif head[i].kind == nnkIdent:\n        identDefs.add(head[i])\n\
    \      identDefs.add(prev_type)\n      identDefs.add(newEmptyNode())\n      params.add(identDefs)\n\
    \    params.add(ident\"auto\")\n    params.reverse()\n    var callparams:seq[NimNode]\n\
    \    for i in 1..<params.len:\n      callparams.add(params[i][0])\n#    var mainBody,\
    \ naiveBody = mainBodyHeader()\n    var mainBody, checkBody, naiveBody, testBody,\
    \ generateBody = newStmtList()\n    var hasNaive, hasCheck, hasTest, hasGenerate\
    \ = false\n    for b in body:\n      if b.kind == nnkCall:\n        if b[0] ==\
    \ ident\"Check\":\n          hasCheck = true\n          var checkStmt = if b.len\
    \ == 2: b[1] else: b[2]\n          var strmName = if b.len == 2: ident(\"strm\"\
    ) else: b[1]\n          checkBody.add(newNimNode(nnkWhenStmt).add(\n         \
    \   newNimNode(nnkElifBranch).add(ident\"DO_CHECK\").add(\n              newBlockStmt(newEmptyNode(),\
    \ \n                newStmtList().add(\n                  quote do:\n        \
    \            var `strmName` = newStringStream(resultOutput)\n                ).add(checkStmt)\n\
    \          ))))\n        elif b[0] == ident\"Naive\":\n          hasNaive = true\n\
    \          naiveBody.add b[1]\n        elif b[0] == ident\"Test\":\n         \
    \ hasTest = true\n          testBody.add b[1]\n        elif b[0] == ident\"Generate\"\
    :\n          hasGenerate = true\n          generateBody.add b[1]\n        else:\n\
    \          mainBody.add b\n      else:\n        mainBody.add b\n    mainBody =\
    \ newStmtList().add(mainBodyHeader()).add(mainBody)\n    #if hasCheck:\n    #\
    \  mainBody.add(checkBody)\n    result = newStmtList()\n    let procName = head[0]\n\
    \    var discardablePragma = newNimNode(nnkPragma).add(ident(\"discardable\"))\n\
    \    var mainParams = params\n    mainParams[0] = ident\"string\"\n#    var identDefsSub\
    \ = newNimNode(nnkIdentDefs).add(ident\"output_stdout\").add(newNimNode(nnkBracketExpr).add(ident\"\
    static\").add(ident\"bool\")).add(ident\"true\")\n    var identDefs = newNimNode(nnkIdentDefs).add(ident\"\
    output_stdout\").add(newNimNode(nnkBracketExpr).add(ident\"static\").add(ident\"\
    bool\")).add(ident\"true\")\n    proc copy(a:seq[NimNode]):seq[NimNode] = a.mapIt(it.copy)\n\
    #    var identDefs = newNimNode(nnkIdentDefs).add(ident\"output_stdout\").add(newNimNode(nnkBracketExpr).add(ident\"\
    static\").add(ident\"bool\")).add(newEmptyNode())\n    mainParams.add(identDefs)\n\
    \    #var mainProcDef = newNimNode(nnkProcDef).add(ident\"solve\").add(newEmptyNode()).add(newEmptyNode()).add(newNimNode(nnkFormalParams).add(mainParams.copy())).add(discardablePragma).add(newEmptyNode()).add(newEmptyNode())\n\
    \    #result.add(mainProcDef)\n    if hasCheck:\n      result.add(quote do:\n\
    \        type CheckResult {.inject.} = ref object of Exception\n          output,\
    \ err:string\n        template check(b:untyped) =\n          if not b:\n     \
    \       raise CheckResult(err: b.astToStr, output: resultOutput)\n      )\n  \
    \  if hasNaive:\n      var naiveProcDef = newNimNode(nnkProcDef).add(newNimNode(nnkPostFix).add(ident\"\
    *\").add(ident\"solve_naive\")).add(newEmptyNode()).add(newEmptyNode()).add(newNimNode(nnkFormalParams).add(mainParams.copy())).add(discardablePragma).add(newEmptyNode()).add(newEmptyNode())\n\
    \      result.add(naiveProcDef)\n\n    var naiveParams = mainParams.copy()\n \
    \   #result.add newProc(name = ident(procName), params = mainParams.copy(), body\
    \ = mainBody, pragmas = discardablePragma)\n    \n    var mainProcImpl =\n   \
    \   newStmtList().add(parseStmt(\"mixin echo\")).add quote do:\n      proc solve():string\
    \ =\n        `mainBody`\n      var resultOutput {.inject.} = solve()\n    var\
    \ mainTemplateBody = newStmtList().add quote do:\n      `mainProcImpl`\n    if\
    \ hasCheck:\n      mainTemplateBody.add checkBody\n    mainTemplateBody.add quote\
    \ do:\n      resultOutput\n    var mainTemplate = quote do:\n      proc `procName`*():string\
    \ {.discardable.} =\n        `mainTemplateBody`\n    mainTemplate[3].add mainParams[1..^1].copy()\n\
    \    result.add mainTemplate\n\n    if hasNaive:\n      let naiveProcName = $procName\
    \ & \"naive\"\n      naiveBody = mainBodyHeader().add(newBlockStmt(newEmptyNode(),\
    \ naiveBody))\n      result.add newProc(name = ident(naiveProcName), params =\
    \ naiveParams, body = naiveBody, pragmas = discardablePragma)\n      var test_body\
    \ = newStmtList()\n      var var_names = newSeq[string]()\n      for procName\
    \ in [$procName, $procName & \"_naive\"]:\n        let var_name = \"v\" & procName\n\
    \        var_names.add(var_name)\n        var l = newNimNode(nnkCall).add(ident(procName))\n\
    \        for c in callparams: l.add(c)\n        l.add(ident\"false\")\n      \
    \  test_body.add(\n          newNimNode(nnkLetSection).add(\n            newNimNode(nnkIdentDefs).add(ident(var_name)).add(newEmptyNode()).add(l)\n\
    \          ))\n      var test_params = params\n      var vars = \"\"\n      for\
    \ i in 1..<params.len:\n        let p = params[i][0]\n        vars &= &\"  {p.repr}\
    \ = {{{p.repr}}}\\\\n\"\n      test_params[0] = ident\"bool\"\n\n      var identDefs\
    \ = newNimNode(nnkIdentDefs).add(ident\"error\").add(ident\"float\").add(ident(\"\
    NaN\"))\n      test_params.add identDefs\n      test_body.add parseStmt(&\"if\
    \ not compare_answer_string(vsolve, vsolve_naive, error): echo &\\\"test failed\
    \ for\\\\n{vars}\\\", \\\"[solve]\\\\n\\\", vsolve, \\\"[solve_naive]\\\\n\\\"\
    , vsolve_naive;doAssert false\")\n      result.add newProc(name = newNimNode(nnkPostFix).add(ident(\"\
    *\")).add(ident\"test\"), params = test_params, body = test_body, pragmas = discardablePragma)\n\
    \    elif hasCheck:\n      var test_body_sub = newStmtList()\n      var var_names\
    \ = newSeq[string]()\n      for procName in [$procName]:\n        let var_name\
    \ = \"v\" & procName\n        var_names.add(var_name)\n        var l = newNimNode(nnkCall).add(ident(procName))\n\
    \        for c in callparams: l.add(c)\n        l.add(ident\"false\")\n      \
    \  test_body_sub.add(\n          newNimNode(nnkLetSection).add(\n            newNimNode(nnkIdentDefs).add(ident(var_name)).add(newEmptyNode()).add(l)\n\
    \          ))\n      var test_params = params\n      var vars = \"\"\n      for\
    \ i in 1..<params.len:\n        let p = params[i][0]\n        vars &= &\"  {p.repr}\
    \ = {{{p.repr}}}\\\\n\"\n      test_params[0] = ident\"bool\"\n      var test_body\
    \ = newStmtList()\n      var d = &\"try:\\n  {test_body_sub.repr.strip}\\nexcept\
    \ CheckResult as e:\\n  echo &\\\"check failed for\\\\n{vars}\\\", \\\"[failed\
    \ statement]\\\\n\\\", e.err.strip, \\\"\\\\n[output]\\\\n\\\", e.output;doAssert\
    \ false\"\n      test_body.add parseStmt(d)\n      result.add newProc(name = newNimNode(nnkPostFix).add(ident(\"\
    *\")).add(ident\"test\"), params = test_params, body = test_body, pragmas = discardablePragma)\n\
    \n    if hasGenerate:\n      discard\n    if hasTest:\n      discard\n    #echo\
    \ result.repr\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/other/solve_proc.nim
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
  timestamp: '2022-08-08 21:23:55+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/other/solve_proc.nim
layout: document
redirect_from:
- /library/atcoder/extra/other/solve_proc.nim
- /library/atcoder/extra/other/solve_proc.nim.html
title: atcoder/extra/other/solve_proc.nim
---
