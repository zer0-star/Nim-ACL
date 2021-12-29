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
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.1/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.1/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_INTERACTIVE_HPP:\n  const ATCODER_INTERACTIVE_HPP*\
    \ = 1\n  import std/macros, std/strformat\n\n  macro solveInteractive*(head, body:untyped)\
    \ =\n    var solveProcBody = newStmtList()\n    solveProcBody.add parseStmt(\"\
    when DEBUG: (var outputString:string;var fd_pipe: array[2, cint];discard pipe(fd_pipe);discard\
    \ close(cint(0));discard dup2(fd_pipe[0], cint(0));discard close(fd_pipe[0]);fd_pipe[0]\
    \ = cint(0))\")\n    solveProcBody.add parseStmt \"when DEBUG:\\n  proc addStdin(s:string)\
    \ = (var s = s.cstring; discard(write(fd_pipe[1], s, s.len + 1)))\"\n    solveProcBody.add\
    \ parseStmt \"when DEBUG:\\n  proc judgeEcho(x:varargs[string, `$`]) = (addStdin(x.join()\
    \ & \\\"\\\\n\\\");echo \\\" \\\".repeat(20), x.join())\"\n    solveProcBody.add\
    \ parseStmt \"proc askEcho(x:varargs[string, `$`]) = (let s = x.join() & \\\"\\\
    \\n\\\"; when DEBUG: outputString.add(s);stdout.write s;flushFile(stdout);)\"\n\
    \n    proc dfs(body:NimNode):NimNode =\n      result = newStmtList()\n      for\
    \ a in body:\n        if a.kind == nnkIdent: result.add a\n        elif a.kind\
    \ == nnkCall:\n          if $a[0] == \"Judge\":\n            var tmp = newStmtList()\n\
    \            if a.len == 2:\n              tmp.add(a[1])\n            elif a.len\
    \ == 3:\n              tmp.add(parseStmt(fmt\"var {a[1].repr} = newStringStream(outputString)\"\
    ))\n              tmp.add(a[2])\n              tmp.add(parseStmt(\"outputString\
    \ = \\\"\\\"\"))\n            else:\n              doAssert false\n          \
    \  result.add(newNimNode(nnkWhenStmt).add(\n              newNimNode(nnkElifBranch).add(ident\"\
    DEBUG\").add(tmp)\n            ))\n          else: result.add(a)\n        elif\
    \ a.kind == nnkProcDef:\n          a[6] = dfs(a[6])\n          result.add(a)\n\
    \        elif a.kind == nnkBlockStmt:\n          a[1] = dfs(a[1])\n          result.add(a)\n\
    \        elif a.kind == nnkIfStmt:\n          for i in 0..<a.len:\n          \
    \  a[i][^1] = dfs(a[i][^1])\n          result.add(a)\n        else:\n        \
    \  result.add(a)\n    solveProcBody.add dfs(body)\n    result = newStmtList()\n\
    \    result.add parseStmt(\"when DEBUG: import posix, strutils, streams\")\n \
    \   var procDef = newStmtList()\n    var params = @[ident\"auto\"]\n    for i\
    \ in 1..<head.len:\n      var identDefs = newNimNode(nnkIdentDefs)\n      identDefs.add(head[i][0]).add(head[i][1]).add(newEmptyNode())\n\
    \      params.add identDefs\n    procDef.add newNimNode(nnkWhenStmt).add(\n  \
    \    newNimNode(nnkElifBranch).add(ident\"DEBUG\").add(\n        newProc(name\
    \ = head[0], params = params, body = solveProcBody))).add(\n      newNimNode(nnkElse).add(\n\
    \        newProc(name = head[0], params = @[ident\"auto\"], body = solveProcBody))\n\
    \      )\n    result.add procDef\n#    echo result.repr\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/other/interactive.nim
  requiredBy: []
  timestamp: '2021-07-15 21:51:07+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/other/interactive.nim
layout: document
redirect_from:
- /library/atcoder/extra/other/interactive.nim
- /library/atcoder/extra/other/interactive.nim.html
title: atcoder/extra/other/interactive.nim
---
