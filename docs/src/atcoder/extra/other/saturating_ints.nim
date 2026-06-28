when not declared ATCODER_SATURATING_INTS_HPP:
  const ATCODER_SATURATING_INTS_HPP* = 1
  # saturating_ints.nim
  
  func satAddSigned[T: SomeSignedInt](a, b: T): T {.inline.} =
    let hi = high(T)
    let lo = low(T)
    let z = T(0)
  
    if b > z:
      if a > hi - b:
        return hi
    elif b < z:
      if a < lo - b:
        return lo
  
    result = a + b
  
  
  func satSubSigned[T: SomeSignedInt](a, b: T): T {.inline.} =
    let hi = high(T)
    let lo = low(T)
    let z = T(0)
  
    if b > z:
      if a < lo + b:
        return lo
    elif b < z:
      if a > hi + b:
        return hi
  
    result = a - b
  
  
  func satMulSigned[T: SomeSignedInt](a, b: T): T {.inline.} =
    let hi = high(T)
    let lo = low(T)
    let z = T(0)
    let one = T(1)
    let negOne = T(-1)
  
    if a == z or b == z:
      return z
  
    if a == one:
      return b
    if b == one:
      return a
  
    # -low(T) は表現不能なので、-1 ケースを先に処理する。
    if a == negOne:
      if b == lo:
        return hi
      return -b
  
    if b == negOne:
      if a == lo:
        return hi
      return -a
  
    if a > z:
      if b > z:
        # 正 * 正: 上方向へ飽和
        if a > hi div b:
          return hi
      else:
        # 正 * 負: 下方向へ飽和
        if b < lo div a:
          return lo
    else:
      if b > z:
        # 負 * 正: 下方向へ飽和
        if a < lo div b:
          return lo
      else:
        # 負 * 負: 上方向へ飽和
        if a < hi div b:
          return hi
  
    result = a * b
  
  
  func satAddUnsigned[T: SomeUnsignedInt](a, b: T): T {.inline.} =
    let hi = high(T)
  
    if a > hi - b:
      return hi
  
    result = a + b
  
  
  func satSubUnsigned[T: SomeUnsignedInt](a, b: T): T {.inline.} =
    if a < b:
      return T(0)
  
    result = a - b
  
  
  func satMulUnsigned[T: SomeUnsignedInt](a, b: T): T {.inline.} =
    let hi = high(T)
    let z = T(0)
  
    if a == z or b == z:
      return z
  
    # a * b が hi を超えるかどうかを、実際に掛ける前に見る。
    if a > hi div b:
      return hi
  
    result = a * b
  
  
  func satAdd*[A, B: SomeInteger](a: A; b: B): A {.inline.} =
    when not (A is B):
      {.error: "satAdd requires both operands to have exactly the same integer type".}
    elif A is SomeSignedInt:
      result = satAddSigned[A](a, A(b))
    else:
      result = satAddUnsigned[A](a, A(b))
  
  
  func satSub*[A, B: SomeInteger](a: A; b: B): A {.inline.} =
    when not (A is B):
      {.error: "satSub requires both operands to have exactly the same integer type".}
    elif A is SomeSignedInt:
      result = satSubSigned[A](a, A(b))
    else:
      result = satSubUnsigned[A](a, A(b))
  
  
  func satMul*[A, B: SomeInteger](a: A; b: B): A {.inline.} =
    when not (A is B):
      {.error: "satMul requires both operands to have exactly the same integer type".}
    elif A is SomeSignedInt:
      result = satMulSigned[A](a, A(b))
    else:
      result = satMulUnsigned[A](a, A(b))
  
  
  func `+|`*[A, B: SomeInteger](a: A; b: B): A {.inline.} =
    satAdd(a, b)
  
  
  func `-|`*[A, B: SomeInteger](a: A; b: B): A {.inline.} =
    satSub(a, b)
  
  
  func `*|`*[A, B: SomeInteger](a: A; b: B): A {.inline.} =
    satMul(a, b)
  
