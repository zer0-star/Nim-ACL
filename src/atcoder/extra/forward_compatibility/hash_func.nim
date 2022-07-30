when not declared ATCODER_HASH_FUNC_HPP:
  const ATCODER_HASH_FUNC_HPP* = 1
  import hashes

  proc hash*(a:int):Hash {.inline.} = 
    proc hiXorLoFallback64(a, b: uint64): uint64 {.inline.} =
      let # Fall back in 64-bit arithmetic
        aH = a shr 32
        aL = a and 0xFFFFFFFF'u64
        bH = b shr 32
        bL = b and 0xFFFFFFFF'u64
        rHH = aH * bH
        rHL = aH * bL
        rLH = aL * bH
        rLL = aL * bL
        t = rLL + (rHL shl 32)
      var c = if t < rLL: 1'u64 else: 0'u64
      let lo = t + (rLH shl 32)
      c += (if lo < t: 1'u64 else: 0'u64)
      let hi = rHH + (rHL shr 32) + (rLH shr 32) + c
      return hi xor lo
    proc hiXorLo(a, b: uint64): uint64 {.inline.} =
      # XOR of the high & low 8 bytes of the full 16 byte product.
      when nimvm:
        result = hiXorLoFallback64(a, b) # `result =` is necessary here.
      else:
        when Hash.sizeof < 8:
          result = hiXorLoFallback64(a, b)
        elif defined(gcc) or defined(llvm_gcc) or defined(clang):
          {.emit: """__uint128_t r = `a`; r *= `b`; `result` = (r >> 64) ^ r;""".}
        elif defined(windows) and not defined(tcc):
          proc umul128(a, b: uint64, c: ptr uint64): uint64 {.importc: "_umul128", header: "intrin.h".}
          var b = b
          let c = umul128(a, b, addr b)
          result = c xor b
        else:
          result = hiXorLoFallback64(a, b)
    proc hashWangYi1(x: int64|uint64|Hash): Hash {.inline.} =
      ## Wang Yi's hash_v1 for 64-bit ints (see https://github.com/rurban/smhasher for
      ## more details). This passed all scrambling tests in Spring 2019 and is simple.
      ##
      ## **Note:** It's ok to define `proc(x: int16): Hash = hashWangYi1(Hash(x))`.
      const P0  = 0xa0761d6478bd642f'u64
      const P1  = 0xe7037ed1a0b428db'u64
      const P58 = 0xeb44accab455d165'u64 xor 8'u64
      template h(x): untyped = hiXorLo(hiXorLo(P0, uint64(x) xor P1), P58)
      when nimvm:
        when defined(js): # Nim int64<->JS Number & VM match => JS gets 32-bit hash
          result = cast[Hash](h(x)) and cast[Hash](0xFFFFFFFF)
        else:
          result = cast[Hash](h(x))
      else:
        when defined(js):
          if hasJsBigInt():
            result = hashWangYiJS(big(x))
          else:
            result = cast[Hash](x) and cast[Hash](0xFFFFFFFF)
        else:
          result = cast[Hash](h(x))
    hashWangYi1(a)
