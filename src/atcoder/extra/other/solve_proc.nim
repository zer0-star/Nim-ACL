when not declared ATCODER_SOLVEPROC_HPP:
  const ATCODER_SOLVEPROC_HPP* = 1
  import std/macros, std/strformat, std/algorithm
  proc mainBodyHeader():NimNode =
    result = newStmtList()
    result.add parseStmt "result = \"\""
    result.add parseStmt "var resultPointer = result.addr"
#    let macro_def = "(for s in {x.repr}: (result &= $s;(when output_stdout: stdout.write $s)));(result &= \"\\n\";when output_stdout: stdout.write \"\\n\")"
    let d = &"proc echo(x:varargs[string, `$`]) = (for s in x: (resultPointer[] &= $s; when output_stdout: stdout.write $s)); (resultPointer[] &= \"\\n\"; when output_stdout: stdout.write \"\\n\")"
    result.add parseStmt(d)

  macro solveProc*(head, body:untyped):untyped =
    var prev_type:NimNode
    var params:seq[NimNode]
    for i in countdown(head.len - 1, 1):
      var identDefs = newNimNode(nnkIdentDefs)
      if head[i].kind == nnkExprColonExpr:
        identDefs.add(head[i][0])
        prev_type = head[i][1]
      elif head[i].kind == nnkIdent:
        identDefs.add(head[i])
      identDefs.add(prev_type)
      identDefs.add(newEmptyNode())
      params.add(identDefs)
    params.add(ident"auto")
    params.reverse()
    var callparams:seq[NimNode]
    for i in 1..<params.len:
      callparams.add(params[i][0])
#    var mainBody, naiveBody = mainBodyHeader()
    var mainBody, checkBody, naiveBody, testBody, generateBody = newStmtList()
    var hasNaive, hasCheck, hasTest, hasGenerate = false
    for b in body:
      if b.kind == nnkCall:
        if b[0] == ident"Check":
          hasCheck = true
          checkBody.add b[1]
        elif b[0] == ident"Naive":
          hasNaive = true
          naiveBody.add b[1]
        elif b[0] == ident"Test":
          hasTest = true
          testBody.add b[1]
        elif b[0] == ident"Generate":
          hasGenerate = true
          generateBody.add b[1]
        else:
          mainBody.add b
      else:
        mainBody.add b
    mainBody = newStmtList().add newBlockStmt(newEmptyNode(), newStmtList().add(mainBodyHeader()).add(mainBody))
    if hasCheck:
      mainBody.add(checkBody)
    result = newStmtList()
    let procName = $head[0]
    var discardablePragma = newNimNode(nnkPragma).add(ident("discardable"))
    var mainParams = params
    mainParams[0] = ident"string"
#    var identDefsSub = newNimNode(nnkIdentDefs).add(ident"output_stdout").add(newNimNode(nnkBracketExpr).add(ident"static").add(ident"bool")).add(ident"true")
    var identDefs = newNimNode(nnkIdentDefs).add(ident"output_stdout").add(newNimNode(nnkBracketExpr).add(ident"static").add(ident"bool")).add(ident"true")
#    var identDefs = newNimNode(nnkIdentDefs).add(ident"output_stdout").add(newNimNode(nnkBracketExpr).add(ident"static").add(ident"bool")).add(newEmptyNode())
    mainParams.add(identDefs)
    var mainProcDef = newNimNode(nnkProcDef).add(ident"solve").add(newEmptyNode()).add(newEmptyNode()).add(newNimNode(nnkFormalParams).add(mainParams)).add(discardablePragma).add(newEmptyNode()).add(newEmptyNode())
    result.add(mainProcDef)
    if hasNaive:
      var naiveProcDef = newNimNode(nnkProcDef).add(ident"solve_naive").add(newEmptyNode()).add(newEmptyNode()).add(newNimNode(nnkFormalParams).add(mainParams)).add(discardablePragma).add(newEmptyNode()).add(newEmptyNode())
      result.add(naiveProcDef)

    var naiveParams = mainParams
    result.add newProc(name = ident(procName), params = mainParams, body = mainBody, pragmas = discardablePragma)
    if hasNaive:
      let naiveProcName = procName & "naive"
      naiveBody = mainBodyHeader().add(newBlockStmt(newEmptyNode(), naiveBody))
      result.add newProc(name = ident(naiveProcName), params = naiveParams, body = naiveBody, pragmas = discardablePragma)
      var test_body = newStmtList()
      var var_names = newSeq[string]()
      for procName in [procName, procName & "_naive"]:
        let var_name = "v" & procName
        var_names.add(var_name)
        var l = newNimNode(nnkCall).add(ident(procName))
        for c in callparams: l.add(c)
        l.add(ident"false")
        test_body.add(
          newNimNode(nnkLetSection).add(
            newNimNode(nnkIdentDefs).add(ident(var_name)).add(newEmptyNode()).add(l)
          ))
      var test_params = params
      var vars = ""
      for i in 1..<params.len:
        let p = params[i][0]
        vars &= &"  {p.repr} = {{{p.repr}}}\\n"
      test_params[0] = ident"bool"
      test_body.add parseStmt(&"if vsolve != vsolve_naive: echo &\"test failed for\\n{vars}\", \"[solve]\\n\", vsolve, \"[solve_naive]\\n\", vsolve_naive;doAssert false")
      result.add newProc(name = ident"test", params = test_params, body = test_body, pragmas = discardablePragma)
    if hasGenerate:
      discard
    if hasTest:
      discard
