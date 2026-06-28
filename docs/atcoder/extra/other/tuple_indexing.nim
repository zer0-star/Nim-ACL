import std/macros

proc stripPtr(t: NimNode): NimNode =
  if t.kind in {nnkPtrTy, nnkRefTy}:
    t[0]
  else:
    t

proc elementType(t: NimNode): NimNode =
  case $t[0]
  of "array":
    t[2]          # array[N, T]
  of "seq":
    t[1]          # seq[T]
  of "string":
    ident("char") # string の要素型
  else:
    t

proc isIndexableType(t: NimNode): bool =
  let u = stripPtr(t)

  if u.kind == nnkBracketExpr:
    let head = $u[0]
    return head in ["seq", "array", "openArray", "UncheckedArray"]

  $u == "string"

macro `[]`*(a: typed, p: untyped): untyped =
  # 構文が tuple でなければ何もしない
  if p.kind notin {nnkTupleConstr, nnkPar}:
    return nil   # ← 重要

  # 要素が1個なら通常インデックス扱い
  if p.len == 1:
    return nil

  # ここから tuple index 展開
  let aType = a.getTypeInst
  if not isIndexableType(aType):
    error("tuple indexing only allowed for seq/array/string", a)

  var curExpr: NimNode = a
  var shapeType = aType

  for i in 0..<p.len:
    let idx = p[i]

    let nextExpr = newCall(
      newDotExpr(ident("system"), ident("[]")),
      curExpr, idx
    )

    if not compiles(nextExpr):
      error("index type mismatch", idx)

    curExpr = nextExpr
    shapeType = elementType(shapeType)

  result = curExpr

#macro `[]`*(a: typed, p: tuple): untyped =
#  let aType = a.getTypeInst
#
#  if not isIndexableType(aType):
#    error("tuple indexing only allowed for seq/array/string/openArray/ptr", a)
#
#  let pTypeImpl = p.getTypeImpl
#  if pTypeImpl.kind != nnkTupleTy:
#    error("index must be tuple", p)
#
#  let n = pTypeImpl.len
#
#  var curExpr: NimNode = a
#  var shapeType = aType
#
#  for i in 0..<n:
#    if not isIndexableType(shapeType):
#      error("Too many indices", p)
#
#    let idx = newCall(
#      newDotExpr(ident("system"), ident("[]")),
#      p, newLit(i)
#    )
#
#    let nextExpr = newCall(
#      newDotExpr(ident("system"), ident("[]")),
#      curExpr, idx
#    )
#
#    if not compiles(nextExpr):
#      error("index type mismatch", idx)
#
#    curExpr = nextExpr
#    shapeType = elementType(shapeType)
#
#  result = curExpr

macro `[]=`*(a: typed, p: tuple, value: typed): untyped =
  let aType = a.getTypeInst

  if not isIndexableType(aType):
    error("tuple assignment only allowed for seq/array/openArray/ptr", a)

  let pTypeImpl = p.getTypeImpl
  if pTypeImpl.kind != nnkTupleTy:
    error("index must be tuple", p)

  let n = pTypeImpl.len

  var curExpr: NimNode = a
  var shapeType = aType

  for i in 0..<n:
    let idx = newCall(
      newDotExpr(ident("system"), ident("[]")),
      p, newLit(i)
    )

    if i == n-1:
      let setExpr = newCall(
        newDotExpr(ident("system"), ident("[]=")),
        curExpr, idx, value
      )

      if not compiles(setExpr):
        error("assignment type mismatch", value)

      result = setExpr
      return
    else:
      let nextExpr = newCall(
        newDotExpr(ident("system"), ident("[]")),
        curExpr, idx
      )

      if not compiles(nextExpr):
        error("index type mismatch", idx)

      curExpr = nextExpr
      shapeType = elementType(shapeType)
