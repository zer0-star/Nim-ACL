when not declared ATCODER_BITUTILS_HPP:
  const ATCODER_BITUTILS_HPP* = 1
  import bitops

  proc `<<`*[B:SomeInteger](b:B, n:SomeInteger):B = b shl n
  proc `>>`*[B:SomeInteger](b:B, n:SomeInteger):B = b shr n

  proc seqToBits*[B:SomeInteger](v:varargs[int]): B =
    result = 0
    for x in v: result = (result or (B(1) shl B(x)))

  proc `[]`*[B:SomeInteger](b:B,n:int):bool = (if b.testBit(n): 1 else: 0)
  proc `[]`*[B:SomeInteger](b:B,s:Slice[int]):int = (b shr s.a) mod (B(1) shl (s.b - s.a + 1))
  
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

  proc `@`*[B:SomeInteger](b:B): seq[int] =
    result = newSeq[int]()
    for i in 0..<(8 * sizeof(B)):
      if b[i]: result.add(i)
  proc `@^`*(v:openArray[int]): int =
    result = 0
    for i in v:
      result[i] = 1

  proc toBitStr*[B:SomeInteger](b:B, n = -1):string =
    let n = if n == -1: sizeof(B) * 8 else: n
    result = ""
    for i in countdown(n-1,0):result.add if b[i]: '1' else: '0'
  proc allSetBits*[B:SomeInteger](n:int):B =
    if n == 64:
      return not uint64(0)
    else:
      return (B(1) shl B(n)) - B(1)
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
    for b in subsets[B](@b):
      yield b
