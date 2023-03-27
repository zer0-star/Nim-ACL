when not declared ATCODER_SOLVEPROC_HPP:
  const ATCODER_SOLVEPROC_HPP* = 1
  import std/macros, std/strformat, std/algorithm, std/sequtils, std/streams
  import std/strutils
  import math

  proc compare_answer_string*(s, t:string, error:float = NaN):bool =
    if error.classify == fcNaN:
      return s == t
    else:
      var
        s = s.split("\n")
        t = t.split("\n")
      if s.len != t.len: return false
      for i in 0 ..< s.len:
        var s = s[i].split()
        var t = t[i].split()
        if s.len != t.len: return false
        for j in 0 ..< s.len:
          if s[j].len == 0:
            if t[j].len != 0: return false
          elif t[j].len == 0:
            return false
          else:
            var fs = s[j].parseFloat
            var ft = t[j].parseFloat
            if abs(fs - ft) > error and abs(fs - ft) > min(abs(ft), abs(fs)) * error: return false
      return true
    doAssert false

  proc mainBodyHeader():NimNode =
#    let macro_def = "(for s in {x.repr}: (result &= $s;(when output_stdout: stdout.write $s)));(result &= \"\\n\";when output_stdout: stdout.write \"\\n\")"
    result = newStmtList()
    result.add quote("@@") do:
      mixin echo
      result = ""
      var resultPointer = result.addr
      proc echo(x:varargs[string, `$`]) =
        for s in x:
          resultPointer[] &= $s
          when output_stdout: stdout.write $s
        resultPointer[] &= "\n"
        when output_stdout:
          stdout.write "\n"
          # flushFile(stdout)

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
          var checkStmt = if b.len == 2: b[1] else: b[2]
          var strmName = if b.len == 2: ident("strm") else: b[1]
          checkBody.add(newNimNode(nnkWhenStmt).add(
            newNimNode(nnkElifBranch).add(ident"DO_CHECK").add(
              newBlockStmt(newEmptyNode(), 
                newStmtList().add(
                  quote do:
                    var `strmName` = newStringStream(resultOutput)
                ).add(checkStmt)
          ))))
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
    mainBody = newStmtList().add(mainBodyHeader()).add(mainBody)
    #if hasCheck:
    #  mainBody.add(checkBody)
    result = newStmtList()
    let procName = head[0]
    var discardablePragma = newNimNode(nnkPragma).add(ident("discardable"))
    var mainParams = params
    mainParams[0] = ident"string"
#    var identDefsSub = newNimNode(nnkIdentDefs).add(ident"output_stdout").add(newNimNode(nnkBracketExpr).add(ident"static").add(ident"bool")).add(ident"true")
    var identDefs = newNimNode(nnkIdentDefs).add(ident"output_stdout").add(newNimNode(nnkBracketExpr).add(ident"static").add(ident"bool")).add(ident"true")
    proc copy(a:seq[NimNode]):seq[NimNode] = a.mapIt(it.copy)
#    var identDefs = newNimNode(nnkIdentDefs).add(ident"output_stdout").add(newNimNode(nnkBracketExpr).add(ident"static").add(ident"bool")).add(newEmptyNode())
    mainParams.add(identDefs)
    #var mainProcDef = newNimNode(nnkProcDef).add(ident"solve").add(newEmptyNode()).add(newEmptyNode()).add(newNimNode(nnkFormalParams).add(mainParams.copy())).add(discardablePragma).add(newEmptyNode()).add(newEmptyNode())
    #result.add(mainProcDef)
    if hasCheck:
      result.add(quote do:
        type CheckResult {.inject.} = ref object of Exception
          output, err:string
        template check(b:untyped) =
          if not b:
            raise CheckResult(err: b.astToStr, output: resultOutput)
      )
    if hasNaive:
      var naiveProcDef = newNimNode(nnkProcDef).add(newNimNode(nnkPostFix).add(ident"*").add(ident"solve_naive")).add(newEmptyNode()).add(newEmptyNode()).add(newNimNode(nnkFormalParams).add(mainParams.copy())).add(discardablePragma).add(newEmptyNode()).add(newEmptyNode())
      result.add(naiveProcDef)

    var naiveParams = mainParams.copy()
    #result.add newProc(name = ident(procName), params = mainParams.copy(), body = mainBody, pragmas = discardablePragma)
    
    var mainProcImpl =
      newStmtList().add(parseStmt("mixin echo")).add quote do:
      proc solve():string =
        `mainBody`
      var resultOutput {.inject.} = solve()
    var mainTemplateBody = newStmtList().add quote do:
      `mainProcImpl`
    if hasCheck:
      mainTemplateBody.add checkBody
    mainTemplateBody.add quote do:
      resultOutput
    var mainTemplate = quote do:
      proc `procName`*():string {.discardable.} =
        `mainTemplateBody`
    mainTemplate[3].add mainParams[1..^1].copy()
    result.add mainTemplate

    if hasNaive:
      let naiveProcName = $procName & "naive"
      naiveBody = mainBodyHeader().add(newBlockStmt(newEmptyNode(), naiveBody))
      result.add newProc(name = ident(naiveProcName), params = naiveParams, body = naiveBody, pragmas = discardablePragma)
      var test_body = newStmtList()
      var var_names = newSeq[string]()
      for procName in [$procName, $procName & "_naive"]:
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

      var identDefs = newNimNode(nnkIdentDefs).add(ident"error").add(ident"float").add(ident("NaN"))
      test_params.add identDefs
      test_body.add parseStmt(&"if not compare_answer_string(vsolve, vsolve_naive, error): echo &\"test failed for\\n{vars}\", \"[solve]\\n\", vsolve, \"[solve_naive]\\n\", vsolve_naive;doAssert false")
      result.add newProc(name = newNimNode(nnkPostFix).add(ident("*")).add(ident"test"), params = test_params, body = test_body, pragmas = discardablePragma)
    elif hasCheck:
      var test_body_sub = newStmtList()
      var var_names = newSeq[string]()
      for procName in [$procName]:
        let var_name = "v" & procName
        var_names.add(var_name)
        var l = newNimNode(nnkCall).add(ident(procName))
        for c in callparams: l.add(c)
        l.add(ident"false")
        test_body_sub.add(
          newNimNode(nnkLetSection).add(
            newNimNode(nnkIdentDefs).add(ident(var_name)).add(newEmptyNode()).add(l)
          ))
      var test_params = params
      var vars = ""
      for i in 1..<params.len:
        let p = params[i][0]
        vars &= &"  {p.repr} = {{{p.repr}}}\\n"
      test_params[0] = ident"bool"
      var test_body = newStmtList()
      var d = &"try:\n  {test_body_sub.repr.strip}\nexcept CheckResult as errObj:\n  echo &\"check failed for\\n{vars}\", \"[failed statement]\\n\", errObj.err.strip, \"\\n[output]\\n\", errObj.output;doAssert false"
      test_body.add parseStmt(d)
      result.add newProc(name = newNimNode(nnkPostFix).add(ident("*")).add(ident"test"), params = test_params, body = test_body, pragmas = discardablePragma)

    if hasGenerate:
      discard
    if hasTest:
      discard
    #echo result.repr
