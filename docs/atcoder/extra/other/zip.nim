when not declared ATCODER_ZIP_HPP:
  const ATCODER_ZIP_HPP* = 1
  import macros

  macro zip*(v:varargs[untyped]):untyped =
    result = newStmtList()
    var par = newPar()
    for i,a in v:
      var ts = newNimNode(nnkTypeSection)
      par.add(ident("T" & $i))
      ts.add(newNimNode(nnkTypeDef).add(
        ident("T" & $i),
        newEmptyNode(),
        newDotExpr(newNimNode(nnkBracketExpr).add(a, newIntLitNode(0)), ident("type"))
      ))
      result.add ts
    var varSection = newNimNode(nnkVarSection)
    varSection.add newIdentDefs(ident("a"), newEmptyNode(), newCall(
      newNimNode(nnkBracketExpr).add(
        ident("newSeq"), 
        par
      ), 
      ident("n")
    ))
    result.add newNimNode(nnkLetSection).add(newIdentDefs(ident("n"), newEmptyNode(), 
      newDotExpr(v[0] , ident("len"))
    ))
    result.add(varSection)
  
    var forStmt = newNimNode(nnkForStmt).add(ident("i")).add(
      newNimNode(nnkInfix).add(ident("..<")).add(newIntLitNode(0), ident("n"))
    )
    var fs = newStmtList()
    for j,a in v:
      fs.add newAssignment(
        newNimNode(nnkBracketExpr).add(
          newNimNode(nnkBracketExpr).add(
            ident("a"), 
            ident("i")
          ), 
          newIntLitNode(j)), 
        newNimNode(nnkBracketExpr).add(
          a, 
          ident("i")
        )
      )
    forStmt.add fs
    result.add(forStmt)
    result.add(ident("a"))
    result = newBlockStmt(newEmptyNode(), result)
  
  macro unzip*(n:int, p:tuple):untyped = 
    result = newStmtList()
    result.add(newNimNode(nnkLetSection).add(newIdentDefs(ident("n"), newEmptyNode(), n)))
    for i,a in p:
      var a = newPar(a)
      var t = newCall(
        newNimNode(nnkBracketExpr).add(
          ident("newSeq"), 
          newDotExpr(a, ident("type"))
        ), 
        ident("n")
      )
      var varSection = newNimNode(nnkVarSection).add(
        newIdentDefs(ident("a" & $i), newEmptyNode(), t), 
      )
      result.add(varSection)
    var forStmt = newNimNode(nnkForStmt).add(ident("i"))
    var rangeDef = newNimNode(nnkInfix).add(ident("..<")).add(newIntLitNode(0), ident("n"))
    forStmt.add(rangeDef)
    var fs = newStmtList()
    for i,a in p:
      fs.add newAssignment(
        newNimNode(nnkBracketExpr).add(
          ident("a" & $i), 
          ident("i")), 
        a
      )
    forStmt.add fs
    result.add(forStmt)
    var par = newPar()
    for i, a in p:
      par.add(ident("a" & $i))
    result.add(par)
    result = newBlockStmt(newEmptyNode(), result)

