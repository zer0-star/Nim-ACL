when not declared ATCODER_INTERNAL_SUGAR_HPP:
  const ATCODER_INTERNAL_SUGAR_HPP* = 1
  import std/macros, std/typetraits
  
  proc checkPragma(ex, prag: var NimNode) =
  #  since (1, 3):
    block:
      if ex.kind == nnkPragmaExpr:
        prag = ex[1]
        if ex[0].kind == nnkPar and ex[0].len == 1:
          ex = ex[0][0]
        else:
          ex = ex[0]
  
  proc createProcType(p, b: NimNode): NimNode {.compileTime.} =
    result = newNimNode(nnkProcTy)
    var
      formalParams = newNimNode(nnkFormalParams).add(b)
      p = p
      prag = newEmptyNode()
  
    checkPragma(p, prag)
  
    case p.kind
    of nnkPar, nnkTupleConstr:
      for i in 0 ..< p.len:
        let ident = p[i]
        var identDefs = newNimNode(nnkIdentDefs)
        case ident.kind
        of nnkExprColonExpr:
          identDefs.add ident[0]
          identDefs.add ident[1]
        else:
          identDefs.add newIdentNode("i" & $i)
          identDefs.add(ident)
        identDefs.add newEmptyNode()
        formalParams.add identDefs
    else:
      var identDefs = newNimNode(nnkIdentDefs)
      identDefs.add newIdentNode("i0")
      identDefs.add(p)
      identDefs.add newEmptyNode()
      formalParams.add identDefs
  
    result.add formalParams
    result.add prag
  
  macro `=>`*(p, b: untyped): untyped =
    ## Syntax sugar for anonymous procedures.
    ## It also supports pragmas.

    var
      params = @[ident"auto"]
      name = newEmptyNode()
      kind = nnkLambda
      pragma = newEmptyNode()
      p = p
  
    checkPragma(p, pragma)
  
    if p.kind == nnkInfix and p[0].kind == nnkIdent and p[0].eqIdent"->":
      params[0] = p[2]
      p = p[1]
  
    checkPragma(p, pragma) # check again after -> transform
#    since (1, 3):
    block:
#      if p.kind == nnkCall:
      if p.kind in {nnkCall, nnkObjConstr}:
        # foo(x, y) => x + y
        kind = nnkProcDef
        name = p[0]
        let newP = newNimNode(nnkPar)
        for i in 1..<p.len:
          newP.add(p[i])
        p = newP
  
    case p.kind
    of nnkPar, nnkTupleConstr:
      var untypedBeforeColon = 0
      for i, c in p:
        var identDefs = newNimNode(nnkIdentDefs)
        case c.kind
        of nnkExprColonExpr:
          let t = c[1]
  #        since (1, 3):
          block:
            # + 1 here because of return type in params
            for j in (i - untypedBeforeColon + 1) .. i:
              params[j][1] = t
          untypedBeforeColon = 0
          identDefs.add(c[0])
          identDefs.add(t)
          identDefs.add(newEmptyNode())
        of nnkIdent:
          identDefs.add(c)
          identDefs.add(newIdentNode("auto"))
          identDefs.add(newEmptyNode())
          inc untypedBeforeColon
        of nnkInfix:
          if c[0].kind == nnkIdent and c[0].eqIdent"->":
            var procTy = createProcType(c[1], c[2])
            params[0] = procTy[0][0]
            for i in 1 ..< procTy[0].len:
              params.add(procTy[0][i])
          else:
            error("Expected proc type (->) got (" & c[0].strVal & ").", c)
          break
        else:
          error("Incorrect procedure parameter list.", c)
        params.add(identDefs)
    of nnkIdent:
      var identDefs = newNimNode(nnkIdentDefs)
      identDefs.add(p)
      identDefs.add(ident"auto")
      identDefs.add(newEmptyNode())
      params.add(identDefs)
    else:
      error("Incorrect procedure parameter list.", p)
    result = newProc(body = b, params = params,
                     pragmas = pragma, name = name,
                     procType = kind)

  macro `->`*(p, b: untyped): untyped =
    result = createProcType(p, b)
  
  macro dump*(x: untyped): untyped =
    let s = x.toStrLit
    let r = quote do:
      debugEcho `s`, " = ", `x`
    return r
  
  # TODO: consider exporting this in macros.nim
  proc freshIdentNodes(ast: NimNode): NimNode =
    # Replace NimIdent and NimSym by a fresh ident node
    # see also https://github.com/nim-lang/Nim/pull/8531#issuecomment-410436458
    proc inspect(node: NimNode): NimNode =
      case node.kind:
      of nnkIdent, nnkSym:
        result = ident($node)
      of nnkEmpty, nnkLiterals:
        result = node
      else:
        result = node.kind.newTree()
        for child in node:
          result.add inspect(child)
    result = inspect(ast)
  
  macro capture*(locals: varargs[typed], body: untyped): untyped =
    var params = @[newIdentNode("auto")]
    let locals = if locals.len == 1 and locals[0].kind == nnkBracket: locals[0]
                 else: locals
    for arg in locals:
      if arg.strVal == "result":
        error("The variable name cannot be `result`!", arg)
      params.add(newIdentDefs(ident(arg.strVal), freshIdentNodes getTypeInst arg))
    result = newNimNode(nnkCall)
    result.add(newProc(newEmptyNode(), params, body, nnkProcDef))
    for arg in locals: result.add(arg)
  
  import atcoder/extra/other/internal_underscored_calls

  macro dup*[T](arg: T, calls: varargs[untyped]): T =
    result = newNimNode(nnkStmtListExpr, arg)
    let tmp = genSym(nskVar, "dupResult")
    result.add newVarStmt(tmp, arg)
    underscoredCalls(result, calls, tmp)
    result.add tmp
  
  
  proc transLastStmt(n, res, bracketExpr: NimNode): (NimNode, NimNode, NimNode) =
    # Looks for the last statement of the last statement, etc...
    case n.kind
    of nnkIfExpr, nnkIfStmt, nnkTryStmt, nnkCaseStmt:
      result[0] = copyNimTree(n)
      result[1] = copyNimTree(n)
      result[2] = copyNimTree(n)
      for i in ord(n.kind == nnkCaseStmt)..<n.len:
        (result[0][i], result[1][^1], result[2][^1]) = transLastStmt(n[i], res, bracketExpr)
    of nnkStmtList, nnkStmtListExpr, nnkBlockStmt, nnkBlockExpr, nnkWhileStmt,
        nnkForStmt, nnkElifBranch, nnkElse, nnkElifExpr, nnkOfBranch, nnkExceptBranch:
      result[0] = copyNimTree(n)
      result[1] = copyNimTree(n)
      result[2] = copyNimTree(n)
      if n.len >= 1:
        (result[0][^1], result[1][^1], result[2][^1]) = transLastStmt(n[^1], res, bracketExpr)
    of nnkTableConstr:
      result[1] = n[0][0]
      result[2] = n[0][1]
      if bracketExpr.len == 1:
        bracketExpr.add([newCall(bindSym"typeof", newEmptyNode()), newCall(
            bindSym"typeof", newEmptyNode())])
      template adder(res, k, v) = res[k] = v
      result[0] = getAst(adder(res, n[0][0], n[0][1]))
    of nnkCurly:
      result[2] = n[0]
      if bracketExpr.len == 1:
        bracketExpr.add(newCall(bindSym"typeof", newEmptyNode()))
      template adder(res, v) = res.incl(v)
      result[0] = getAst(adder(res, n[0]))
    else:
      result[2] = n
      if bracketExpr.len == 1:
        bracketExpr.add(newCall(bindSym"typeof", newEmptyNode()))
      template adder(res, v) = res.add(v)
      result[0] = getAst(adder(res, n))
  
  macro collect*(init, body: untyped): untyped =
    # analyse the body, find the deepest expression 'it' and replace it via
    # 'result.add it'
    let res = genSym(nskVar, "collectResult")
    expectKind init, {nnkCall, nnkIdent, nnkSym}
    let bracketExpr = newTree(nnkBracketExpr,
      if init.kind == nnkCall: init[0] else: init)
    let (resBody, keyType, valueType) = transLastStmt(body, res, bracketExpr)
    if bracketExpr.len == 3:
      bracketExpr[1][1] = keyType
      bracketExpr[2][1] = valueType
    else:
      bracketExpr[1][1] = valueType
    let call = newTree(nnkCall, bracketExpr)
    if init.kind == nnkCall:
      for i in 1 ..< init.len:
        call.add init[i]
    result = newTree(nnkStmtListExpr, newVarStmt(res, call), resBody, res)
