when not declared ATCODER_SOLVEPROC_HPP:
  const ATCODER_SOLVEPROC_HPP* = 1
  import std/macros, std/strformat
  proc mainBodyHeader():NimNode =
    result = newStmtList()
    result.add parseStmt "result = \"\""
    result.add parseStmt "var resultPointer = result.addr"
#    let macro_def = "(for s in {x.repr}: (result &= $s;(when output_stdout: stdout.write $s)));(result &= \"\\n\";when output_stdout: stdout.write \"\\n\")"
    let d = &"proc echo(x:varargs[string, `$`]) = (for s in x: (resultPointer[] &= $s; when output_stdout: stdout.write $s)); (resultPointer[] &= \"\\n\"; when output_stdout: stdout.write \"\\n\")"
    result.add parseStmt(d)

  macro solveProc*(head, body:untyped):untyped =
    var params = @[ident"auto"]
    var callparams:seq[NimNode]
    for i in 1..<head.len:
      var identDefs = newNimNode(nnkIdentDefs)
      identDefs.add(head[i][0])
      callparams.add(head[i][0])
      identDefs.add(head[i][1])
      identDefs.add(newEmptyNode())
      params.add(identDefs)
#    var mainBody, naiveBody = mainBodyHeader()
    var mainBody, checkBody, naiveBody, testBody, generateBody = newStmtList()
    var hasNaive, hasCheck, hasTest, hasGenerate = false
    for b in body:
      if b.kind == nnkCall:
        case $b[0]:
          of "Check":
            hasCheck = true
            checkBody.add b[1]
          of "Naive":
            hasNaive = true
            naiveBody.add b[1]
          of "Test":
            hasTest = true
            testBody.add b[1]
          of "Generate":
            hasGenerate = true
            generateBody.add b[1]
          else:
            mainBody.add(b)
      else:
        mainBody.add(b)
    mainBody = newStmtList().add newBlockStmt(newEmptyNode(), newStmtList().add(mainBodyHeader()).add(mainBody))
    if hasCheck:
      mainBody.add(checkBody)
    result = newStmtList()
    let procName = $head[0]
    var discardablePragma = newNimNode(nnkPragma).add(ident("discardable"))
    var mainParams = params
    mainParams[0] = ident"string"
    var identDefs = newNimNode(nnkIdentDefs)
    identDefs.add(ident"output_stdout")
    identDefs.add(newNimNode(nnkBracketExpr).add(ident"static").add(ident"bool"))
    identDefs.add(ident"false")
    mainParams.add(identDefs)
    var mainProcDef = newNimNode(nnkProcDef).add(ident"solve").add(newEmptyNode()).add(newEmptyNode()).add(newNimNode(nnkFormalParams).add(mainParams)).add(discardablePragma).add(newEmptyNode()).add(newEmptyNode())
    result.add(mainProcDef)
    if hasNaive:
      var naiveProcDef = newNimNode(nnkProcDef).add(ident"solve_naive").add(newEmptyNode()).add(newEmptyNode()).add(newNimNode(nnkFormalParams).add(mainParams)).add(discardablePragma).add(newEmptyNode()).add(newEmptyNode())
      result.add(naiveProcDef)


    var naiveParams = mainParams
    result.add newProc(name = ident(procName), params = mainParams, body = mainBody, pragmas = discardablePragma)
    echo mainParams.repr
    if hasNaive:
      let naiveProcName = procName & "naive"
      naiveBody = mainBodyHeader().add(newBlockStmt(newEmptyNode(), naiveBody))
      result.add newProc(name = ident(naiveProcName), params = naiveParams, body = naiveBody, pragmas = discardablePragma)
      var b = newNimNode(nnkInfix)
      var l = newNimNode(nnkCall).add(ident(procName))
      for c in callparams: l.add(c)
      var r = newNimNode(nnkCall).add(ident(procName & "_naive"))
      for c in callparams: r.add(c)
      var test_params = params
      test_params[0] = ident"bool"
      b.add(ident("=="))
      b.add(l)
      b.add(r)
      result.add newProc(name = ident"test", params = test_params, body = b, pragmas = discardablePragma)
    if hasGenerate:
      discard
    if hasTest:
      discard
    echo result.repr
