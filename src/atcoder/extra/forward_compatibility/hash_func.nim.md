---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: atcoder/extra/header/chaemon_header.nim
    title: atcoder/extra/header/chaemon_header.nim
  - icon: ':warning:'
    path: atcoder/extra/header/chaemon_header.nim
    title: atcoder/extra/header/chaemon_header.nim
  - icon: ':warning:'
    path: atcoder/extra/header/chaemon_header.nim
    title: atcoder/extra/header/chaemon_header.nim
  - icon: ':warning:'
    path: atcoder/extra/header/chaemon_header.nim
    title: atcoder/extra/header/chaemon_header.nim
  - icon: ':warning:'
    path: atcoder/extra/template/atcoder-tools_template.nim
    title: atcoder/extra/template/atcoder-tools_template.nim
  - icon: ':warning:'
    path: atcoder/extra/template/atcoder-tools_template.nim
    title: atcoder/extra/template/atcoder-tools_template.nim
  - icon: ':warning:'
    path: atcoder/extra/template/atcoder-tools_template.nim
    title: atcoder/extra/template/atcoder-tools_template.nim
  - icon: ':warning:'
    path: atcoder/extra/template/atcoder-tools_template.nim
    title: atcoder/extra/template/atcoder-tools_template.nim
  - icon: ':warning:'
    path: atcoder/extra/template/atcoder-tools_template_global.nim
    title: atcoder/extra/template/atcoder-tools_template_global.nim
  - icon: ':warning:'
    path: atcoder/extra/template/atcoder-tools_template_global.nim
    title: atcoder/extra/template/atcoder-tools_template_global.nim
  - icon: ':warning:'
    path: atcoder/extra/template/atcoder-tools_template_global.nim
    title: atcoder/extra/template/atcoder-tools_template_global.nim
  - icon: ':warning:'
    path: atcoder/extra/template/atcoder-tools_template_global.nim
    title: atcoder/extra/template/atcoder-tools_template_global.nim
  - icon: ':warning:'
    path: atcoder/extra/template/atcoder-tools_template_with_solve.nim
    title: atcoder/extra/template/atcoder-tools_template_with_solve.nim
  - icon: ':warning:'
    path: atcoder/extra/template/atcoder-tools_template_with_solve.nim
    title: atcoder/extra/template/atcoder-tools_template_with_solve.nim
  - icon: ':warning:'
    path: atcoder/extra/template/atcoder-tools_template_with_solve.nim
    title: atcoder/extra/template/atcoder-tools_template_with_solve.nim
  - icon: ':warning:'
    path: atcoder/extra/template/atcoder-tools_template_with_solve.nim
    title: atcoder/extra/template/atcoder-tools_template_with_solve.nim
  - icon: ':warning:'
    path: atcoder/extra/template/template.nim
    title: atcoder/extra/template/template.nim
  - icon: ':warning:'
    path: atcoder/extra/template/template.nim
    title: atcoder/extra/template/template.nim
  - icon: ':warning:'
    path: atcoder/extra/template/template.nim
    title: atcoder/extra/template/template.nim
  - icon: ':warning:'
    path: atcoder/extra/template/template.nim
    title: atcoder/extra/template/template.nim
  - icon: ':warning:'
    path: atcoder/extra/template/vim_template.nim
    title: atcoder/extra/template/vim_template.nim
  - icon: ':warning:'
    path: atcoder/extra/template/vim_template.nim
    title: atcoder/extra/template/vim_template.nim
  - icon: ':warning:'
    path: atcoder/extra/template/vim_template.nim
    title: atcoder/extra/template/vim_template.nim
  - icon: ':warning:'
    path: atcoder/extra/template/vim_template.nim
    title: atcoder/extra/template/vim_template.nim
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links:
    - https://github.com/rurban/smhasher
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.5/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.5/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_HASH_FUNC_HPP:\n  const ATCODER_HASH_FUNC_HPP*\
    \ = 1\n  import hashes\n\n  proc hash*(a:int):Hash {.inline.} = \n    proc hiXorLoFallback64(a,\
    \ b: uint64): uint64 {.inline.} =\n      let # Fall back in 64-bit arithmetic\n\
    \        aH = a shr 32\n        aL = a and 0xFFFFFFFF'u64\n        bH = b shr\
    \ 32\n        bL = b and 0xFFFFFFFF'u64\n        rHH = aH * bH\n        rHL =\
    \ aH * bL\n        rLH = aL * bH\n        rLL = aL * bL\n        t = rLL + (rHL\
    \ shl 32)\n      var c = if t < rLL: 1'u64 else: 0'u64\n      let lo = t + (rLH\
    \ shl 32)\n      c += (if lo < t: 1'u64 else: 0'u64)\n      let hi = rHH + (rHL\
    \ shr 32) + (rLH shr 32) + c\n      return hi xor lo\n    proc hiXorLo(a, b: uint64):\
    \ uint64 {.inline.} =\n      # XOR of the high & low 8 bytes of the full 16 byte\
    \ product.\n      when nimvm:\n        result = hiXorLoFallback64(a, b) # `result\
    \ =` is necessary here.\n      else:\n        when Hash.sizeof < 8:\n        \
    \  result = hiXorLoFallback64(a, b)\n        elif defined(gcc) or defined(llvm_gcc)\
    \ or defined(clang):\n          {.emit: \"\"\"__uint128_t r = `a`; r *= `b`; `result`\
    \ = (r >> 64) ^ r;\"\"\".}\n        elif defined(windows) and not defined(tcc):\n\
    \          proc umul128(a, b: uint64, c: ptr uint64): uint64 {.importc: \"_umul128\"\
    , header: \"intrin.h\".}\n          var b = b\n          let c = umul128(a, b,\
    \ addr b)\n          result = c xor b\n        else:\n          result = hiXorLoFallback64(a,\
    \ b)\n    proc hashWangYi1(x: int64|uint64|Hash): Hash {.inline.} =\n      ##\
    \ Wang Yi's hash_v1 for 64-bit ints (see https://github.com/rurban/smhasher for\n\
    \      ## more details). This passed all scrambling tests in Spring 2019 and is\
    \ simple.\n      ##\n      ## **Note:** It's ok to define `proc(x: int16): Hash\
    \ = hashWangYi1(Hash(x))`.\n      const P0  = 0xa0761d6478bd642f'u64\n      const\
    \ P1  = 0xe7037ed1a0b428db'u64\n      const P58 = 0xeb44accab455d165'u64 xor 8'u64\n\
    \      template h(x): untyped = hiXorLo(hiXorLo(P0, uint64(x) xor P1), P58)\n\
    \      when nimvm:\n        when defined(js): # Nim int64<->JS Number & VM match\
    \ => JS gets 32-bit hash\n          result = cast[Hash](h(x)) and cast[Hash](0xFFFFFFFF)\n\
    \        else:\n          result = cast[Hash](h(x))\n      else:\n        when\
    \ defined(js):\n          if hasJsBigInt():\n            result = hashWangYiJS(big(x))\n\
    \          else:\n            result = cast[Hash](x) and cast[Hash](0xFFFFFFFF)\n\
    \        else:\n          result = cast[Hash](h(x))\n    hashWangYi1(a)\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/forward_compatibility/hash_func.nim
  requiredBy:
  - atcoder/extra/header/chaemon_header.nim
  - atcoder/extra/header/chaemon_header.nim
  - atcoder/extra/template/vim_template.nim
  - atcoder/extra/template/vim_template.nim
  - atcoder/extra/template/atcoder-tools_template_with_solve.nim
  - atcoder/extra/template/atcoder-tools_template_with_solve.nim
  - atcoder/extra/template/atcoder-tools_template.nim
  - atcoder/extra/template/atcoder-tools_template.nim
  - atcoder/extra/template/atcoder-tools_template_global.nim
  - atcoder/extra/template/atcoder-tools_template_global.nim
  - atcoder/extra/template/template.nim
  - atcoder/extra/template/template.nim
  - atcoder/extra/header/chaemon_header.nim
  - atcoder/extra/header/chaemon_header.nim
  - atcoder/extra/template/vim_template.nim
  - atcoder/extra/template/vim_template.nim
  - atcoder/extra/template/atcoder-tools_template_with_solve.nim
  - atcoder/extra/template/atcoder-tools_template_with_solve.nim
  - atcoder/extra/template/atcoder-tools_template.nim
  - atcoder/extra/template/atcoder-tools_template.nim
  - atcoder/extra/template/atcoder-tools_template_global.nim
  - atcoder/extra/template/atcoder-tools_template_global.nim
  - atcoder/extra/template/template.nim
  - atcoder/extra/template/template.nim
  timestamp: '2022-07-30 23:50:20+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/forward_compatibility/hash_func.nim
layout: document
redirect_from:
- /library/atcoder/extra/forward_compatibility/hash_func.nim
- /library/atcoder/extra/forward_compatibility/hash_func.nim.html
title: atcoder/extra/forward_compatibility/hash_func.nim
---
