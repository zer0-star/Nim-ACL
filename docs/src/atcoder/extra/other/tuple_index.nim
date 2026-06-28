import macros

# ============================================================
# system 呼び出し（再帰防止）
# ============================================================

proc sysIndex(x, i: NimNode): NimNode =
  newCall(newDotExpr(ident("system"), ident("[]")), x, i)

proc sysAssign(x, i, v: NimNode): NimNode =
  newCall(newDotExpr(ident("system"), ident("[]=")), x, i, v)

# ============================================================
# 型判定（安定版）
# ============================================================

proc isArrayOrSeqType(t: NimNode): bool =
  t.kind == nnkBracketExpr and (
    $t[0] == "array" or
    $t[0] == "seq"
  )

proc isValidIndex(n: NimNode): bool =
  # int / enum / range は ord() が通る
  compiles(ord(n))

# ============================================================
# ネスト型を1段剥がす
# ============================================================

proc elementType(t: NimNode): NimNode =
  if $t[0] == "array":
    t[2]   # array[I, T]
  else:
    t[1]   # seq[T]

# ============================================================
# 読み取り
# ============================================================

macro `[]`(a: typed, p: tuple): untyped =
  let aType = a.getTypeInst

  static:
    doAssert(isArrayOrSeqType(aType),
      "a must be array or seq")

  var indices: seq[NimNode] = @[]

  for it in p:
    static:
      doAssert(isValidIndex(it),
        "tuple indices must be int, range, or enum")
    indices.add(it)

  if indices.len == 0:
    error("empty tuple not allowed")

  # ===== shape検査 =====
  var shapeType = aType

  for i in 0 ..< indices.len:
    static:
      doAssert(isArrayOrSeqType(shapeType),
        "Too many indices for array/seq shape")
    shapeType = elementType(shapeType)

  static:
    doAssert(not isArrayOrSeqType(shapeType),
      "Too few indices for array/seq shape")

  # ===== 展開 =====
  var expr = sysIndex(a, indices[0])
  for i in 1 ..< indices.len:
    expr = sysIndex(expr, indices[i])

  result = expr

# ============================================================
# 書き込み
# ============================================================

macro `[]=`(a: typed, p: tuple, value: typed): untyped =
  let aType = a.getTypeInst

  static:
    doAssert(isArrayOrSeqType(aType),
      "a must be array or seq")

  var indices: seq[NimNode] = @[]

  for it in p:
    static:
      doAssert(isValidIndex(it),
        "tuple indices must be int, range, or enum")
    indices.add(it)

  if indices.len == 0:
    error("empty tuple not allowed")

  # ===== shape検査 =====
  var shapeType = aType

  for i in 0 ..< indices.len:
    static:
      doAssert(isArrayOrSeqType(shapeType),
        "Too many indices for array/seq shape")
    shapeType = elementType(shapeType)

  static:
    doAssert(not isArrayOrSeqType(shapeType),
      "Too few indices for array/seq shape")

  # ===== 展開 =====
  var cur = a
  for i in 0 ..< indices.len-1:
    cur = sysIndex(cur, indices[i])

  result = sysAssign(cur, indices[^1], value)




