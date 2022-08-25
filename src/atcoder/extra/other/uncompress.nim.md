---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_UNCOMPRESS_HPP:\n  const ATCODER_UNCOMPRESS_HPP*\
    \ = 1\n  const libz = \"libz.so.1\"\n  type\n    Uint* = cuint\n    Ulong* = culong\n\
    \    Ulongf* = culong\n    Pulongf* = ptr Ulongf\n    Pbyte* = cstring\n    Pbytef*\
    \ = cstring\n    Allocfunc* = proc(p: pointer, items: Uint, size: Uint): pointer{.cdecl.}\n\
    \    FreeFunc* = proc(p, address: pointer){.cdecl.}\n    InternalState*{.final,\
    \ pure.} = object\n    ZStream*{.final, pure.} = object\n      nextIn*: Pbytef\n\
    \      availIn*: Uint\n      totalIn*: Ulong\n      nextOut*: Pbytef\n      availOut*:\
    \ Uint\n      totalOut*: Ulong\n      msg*: Pbytef\n      state*: ptr InternalState\n\
    \      zalloc*: Allocfunc\n      zfree*: FreeFunc\n      opaque*: pointer\n  \
    \    dataType*: cint\n      adler*: Ulong\n      reserved*: Ulong\n  const\n \
    \   ZLIB_VERSION = \"1.2.11\"\n    Z_NO_FLUSH = 0\n    Z_OK = 0\n    Z_STREAM_END\
    \ = 1\n    Z_BUF_ERROR = -5\n    Z_NO_COMPRESSION* = 0\n    MAX_WBITS = 15\n \
    \ proc inflate*(strm: var ZStream, flush: cint): cint{.cdecl, dynlib: libz, importc:\
    \ \"inflate\".}\n  proc inflateEnd*(strm: var ZStream): cint{.cdecl, dynlib: libz,\
    \ importc: \"inflateEnd\".}\n  proc inflateInit2u*(strm: var ZStream, windowBits:\
    \ cint, version: cstring, streamSize: cint): cint{.cdecl, dynlib: libz, importc:\
    \ \"inflateInit2_\".}\n  proc inflateInit2(strm: var ZStream, windowBits: cint):\
    \ cint = inflateInit2u(strm, windowBits, ZLIB_VERSION, sizeof(ZStream).cint)\n\
    \  proc uncompress*(sourceBuf: cstring, sourceLen: Natural): string =\n    assert\
    \ (not sourceBuf.isNil) and sourceLen >= 0\n    var z: ZStream\n    var d = \"\
    \"\n    var sbytes, wbytes = 0\n    z.availIn = 0\n    var wbits = MAX_WBITS +\
    \ 32\n    var status = inflateInit2(z, wbits.cint)\n    if status != Z_OK: assert\
    \ false\n    while true:\n      z.availIn = (sourceLen - sbytes).Uint\n      if\
    \ sourceLen-sbytes<=0: break\n      z.nextIn = sourceBuf[sbytes].unsafeaddr\n\
    \      while true:\n        if wbytes >= d.len:\n          let n = if d.len ==\
    \ 0: sourceLen*2 else: d.len*2\n          if n < d.len: discard inflateEnd(z);\
    \ assert false\n          d.setLen(n)\n        let space = d.len - wbytes\n  \
    \      z.availOut = space.Uint;z.nextOut = d[wbytes].addr;status = inflate(z,\
    \ Z_NO_FLUSH)\n        if status.int8 notin {Z_OK.int8, Z_STREAM_END.int8, Z_BUF_ERROR.int8}:discard\
    \ inflateEnd(z);assert false\n        wbytes += space - z.availOut.int\n     \
    \   if not (z.availOut == 0):break\n      if (status == Z_STREAM_END):break\n\
    \    discard inflateEnd(z)\n    if status != Z_STREAM_END:assert false\n    d.setLen(wbytes)\n\
    \    swap result, d\n  proc uncompress*(sourceBuf: string):string = uncompress(sourceBuf,\
    \ sourceBuf.len)\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/other/uncompress.nim
  requiredBy: []
  timestamp: '2022-08-25 23:07:59+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/other/uncompress.nim
layout: document
redirect_from:
- /library/atcoder/extra/other/uncompress.nim
- /library/atcoder/extra/other/uncompress.nim.html
title: atcoder/extra/other/uncompress.nim
---
