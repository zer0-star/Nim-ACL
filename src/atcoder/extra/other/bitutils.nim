when not declared ATCODER_BITUTILS_HPP:
  const ATCODER_BITUTILS_HPP* = 1
  import std/bitops

  proc `<<`*[B:SomeInteger](b:B, n:SomeInteger):B = b shl n
  proc `>>`*[B:SomeInteger](b:B, n:SomeInteger):B = b shr n

  proc seqToBits*[B:SomeInteger](v:varargs[int]): B =
    result = 0
    for x in v: result = (result or (B(1) shl B(x)))

  proc `[]`*[B:SomeInteger](b:B,n:int):int = (if b.testBit(n): 1 else: 0)
  proc bitutilsLowMask[B:SomeInteger](n:int):B =
    const bitWidth = sizeof(B) * 8
    doAssert 0 <= n and n <= bitWidth

    when sizeof(B) == 1:
      type U = uint8
    elif sizeof(B) == 2:
      type U = uint16
    elif sizeof(B) == 4:
      type U = uint32
    elif sizeof(B) == 8:
      type U = uint64
    else:
      {.error: "unsupported integer width".}

    var mask: U

    if n == 0:
      mask = U(0)
    elif n == bitWidth:
      mask = high(U)
    else:
      mask = (U(1) shl n) - U(1)

    result = cast[B](mask)

  proc `[]`*[B:SomeInteger](b:B,s:Slice[int]):B =
    const bitWidth = sizeof(B) * 8
    doAssert 0 <= s.a and s.a <= s.b and s.b < bitWidth

    let width = s.b - s.a + 1

    if width == bitWidth:
      result = b
    else:
      result =
        (b shr s.a) and bitutilsLowMask[B](width)
  
  proc `[]=`*[B:SomeInteger](b:var B,n:int,t:int) =
    if t == 0: b.clearBit(n)
    elif t == 1: b.setBit(n)
    else: doAssert(false)
  proc `and`*[B:SomeInteger](b:B, v:openArray[int]):B = b and seqToBits[B](v)
  proc `or`*[B:SomeInteger](b:B, v:openArray[int]):B = b or seqToBits[B](v)
  proc `xor`*[B:SomeInteger](b:B, v:openArray[int]):B = b xor seqToBits[B](v)
  proc `&`*[B:SomeInteger](a:B, b:openarray[int]):auto = a and b
  proc `|`*[B:SomeInteger](a:B, b:openarray[int]):auto = a or b
  proc `&`*(a:SomeInteger, b:SomeInteger):auto = a and b
  proc `|`*(a:SomeInteger, b:SomeInteger):auto = a or b

  iterator iterBits*[B:SomeInteger](b:B):int =
    var b = b
    while b != B(0):
      let t = b.firstSetBit() - 1
      yield t
      b.flipBit(t)
  proc bitsToSeq*[B:SomeInteger](b:B):seq[int] =
    result = newSeqOfCap[int](b.popCount)
    for t in iterBits(b): result.add(t)
  proc `@`*[B:SomeInteger](b:B): seq[int] = bitsToSeq(b)
  proc `@^`*(v:openArray[int]): int =
    result = 0
    for i in v: result[i] = 1

  proc toBitStr*[B:SomeInteger](b:B, n = -1):string =
    let n = if n == -1: sizeof(B) * 8 else: n
    result = ""
    for i in countdown(n-1,0):result.add if b[i] == 1: '1' else: '0'
  proc allSetBits*[B:SomeInteger](n:int):B =
    result = bitutilsLowMask[B](n)
  iterator subsets*(v:seq[int], B:typedesc[SomeInteger] = int):B =
    var s = B(0)
    yield s
    while true:
      var found = false
      for i in v:
        if not s.testBit(i):
          found = true
          s.setBit(i)
          yield s
          break
        else:
          s[i] = 0
      if not found: break

  iterator subsets*[B:SomeInteger](b:B):B =
    for subset in subsets(@b, B):
      yield subset
