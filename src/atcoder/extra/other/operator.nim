when not declared ATCODER_OPERATOR_HPP:
  const ATCODER_OPERATOR_HPP* = 1
  import macros, tables

  macro getOperator*(head:typedesc, body: untyped):untyped =
    result = newStmtList()
    var
      T = head
      t = initTable[string, NimNode]()
      s = newStmtList()
      nameStrs = ["zero", "unit", "add", "subt", "mult", "divide", "isZero"]
    for s in nameStrs:
      t[s] = quote do:
        0
    var
      hasZero, hasUnit, hasAdd, hasSubt, hasMult, hasDiv, hasIsZero = 0
    proc getnameStr(name:NimNode):string =
      var nameStr = $name
      case nameStr:
        of "zero":
          hasZero = 1
          return "zero"
        of "unit":
          hasUnit = 1
          return "unit"
        of "add", "+", "plus":
          hasAdd = 1
          return "add"
        of "subt", "-", "minus":
          hasSubt = 1
          return "subt"
        of "mult", "*", "multiply", "product":
          hasMult = 1
          return "mult"
        of "div", "divide", "/":
          hasDiv = 1
          return "divide"
        of "isZero", "iszero":
          hasIsZero = 1
          return "isZero"
        else:
          doAssert false, "Undefined Operator"

    for l in body:
      var
        name, body, params:NimNode
      params = newNimNode(nnkFormalParams).add T
      if l.kind == nnkAsgn:
        name = l[0][0]
        body = l[1]
        for i, l in l[0]:
          if i == 0: continue # name
          if l.kind == nnkExprColonExpr:
            params.add newIdentDefs(l[0], T)
          else:
            params.add newIdentDefs(l, T)
      else:
        for i,l in l[3]:
          if i == 0:
            continue
          else:
            params.add l
        name = l[0]
        body = l[6]
      var nameStr = getnameStr(name)
      if nameStr == "isZero":
        params[0] = ident("bool")
      name = ident(nameStr)
      var p = newNimNode(nnkLambda).add(
        newEmptyNode(),
        newEmptyNode(), 
        newEmptyNode(), 
        params, 
        newEmptyNode(), 
        newEmptyNode(), 
        body)
      t[nameStr] = p
    var
      zeroOp = t["zero"]
      unitOp = t["unit"]
      addOp = t["add"]
      subtOp = t["subt"]
      multOp = t["mult"]
      divOp = t["divide"]
      isZeroOp = t["isZero"]
    s.add quote do:
      (hasZero: `hasZero`, zeroOp: `zeroOp`, 
      hasUnit: `hasUnit`, unitOp: `unitOp`, 
      hasAdd: `hasAdd`, addOp: `addOp`, 
      hasSubt: `hasSubt`, subtOp:`subtOp`, 
      hasMult: `hasMult`, multOp:`multOp`, 
      hasDiv: `hasDiv`, divOp:`divOp`, 
      hasIsZero: `hasIsZero`, isZeroOp:`isZeroOp`)
    result.add newBlockStmt(s)
    return
  
  type OperatorType*[hZ, Z, hU, U, hA, A, hS, S, hM, M, hD, D, hIZ, IZ] = tuple[
    hasZero: hZ, zeroOp: Z, 
    hasUnit: hU, unitOp: U, 
    hasAdd: hA, addOp: A, 
    hasSubt: hS, subtOp: S, 
    hasMult: hM, multOp: M, 
    hasDiv: hD, divOp: D, 
    hasIsZero: hIZ, isZeroOp:IZ
  ]
  
  template zero*(p: OperatorType):auto =
    static:
      doAssert p[0] == 1, "no zero function"
    p[1]()
  template unit*(p: OperatorType):auto =
    static:
      doAssert p[2] == 1, "no unit function"
    p[3]()
  template add*[T](p: OperatorType, a, b:T):T =
    static:
      doAssert p[4] == 1, "no add function"
    p[5](a, b)
  template subt*[T](p: OperatorType, a, b:T):T =
    static:
      doAssert p[6] == 1, "no subt function"
    p[7](a, b)
  template mult*[T](p: OperatorType, a, b:T):T =
    static:
      doAssert p[8] == 1, "no mult function"
    p[9](a, b)
  template `div`*[T](p: OperatorType, a, b:T):T =
    static:
      doAssert p[10] == 1, "no div function"
    p[11](a, b)
  template isZero*[T](p: OperatorType, a:T):bool =
    static:
      doAssert p[12] == 1, "no isZero function"
    p[13](a)


  template getDefaultOperator*(T:typedesc):tuple =
    getOperator(T):
      proc zero() = T(0)
      proc unit() = T(1)
      proc add(a, b:T):T = a + b
      proc subt(a, b:T):T = a - b
      proc mult(a, b:T):T = a * b
      proc divide(a, b:T):T = T(a / b)
      proc isZero(a:T):bool =
        when T is SomeFloat:
          a < 0.0000001
        else:
          a == T(0)
