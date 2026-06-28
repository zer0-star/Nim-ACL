when not declared ATCODER_UNCOMPRESS_HPP:
  const ATCODER_UNCOMPRESS_HPP* = 1
  const libz = "libz.so.1"
  type
    Uint* = cuint
    Ulong* = culong
    Ulongf* = culong
    Pulongf* = ptr Ulongf
    Pbyte* = cstring
    Pbytef* = cstring
    Allocfunc* = proc(p: pointer, items: Uint, size: Uint): pointer{.cdecl.}
    FreeFunc* = proc(p, address: pointer){.cdecl.}
    InternalState*{.final, pure.} = object
    ZStream*{.final, pure.} = object
      nextIn*: Pbytef
      availIn*: Uint
      totalIn*: Ulong
      nextOut*: Pbytef
      availOut*: Uint
      totalOut*: Ulong
      msg*: Pbytef
      state*: ptr InternalState
      zalloc*: Allocfunc
      zfree*: FreeFunc
      opaque*: pointer
      dataType*: cint
      adler*: Ulong
      reserved*: Ulong
  const
    ZLIB_VERSION = "1.2.11"
    Z_NO_FLUSH = 0
    Z_OK = 0
    Z_STREAM_END = 1
    Z_BUF_ERROR = -5
    Z_NO_COMPRESSION* = 0
    MAX_WBITS = 15
  proc inflate*(strm: var ZStream, flush: cint): cint{.cdecl, dynlib: libz, importc: "inflate".}
  proc inflateEnd*(strm: var ZStream): cint{.cdecl, dynlib: libz, importc: "inflateEnd".}
  proc inflateInit2u*(strm: var ZStream, windowBits: cint, version: cstring, streamSize: cint): cint{.cdecl, dynlib: libz, importc: "inflateInit2_".}
  proc inflateInit2(strm: var ZStream, windowBits: cint): cint = inflateInit2u(strm, windowBits, ZLIB_VERSION, sizeof(ZStream).cint)
  proc uncompress*(sourceBuf: cstring, sourceLen: Natural): string =
    assert (not sourceBuf.isNil) and sourceLen >= 0
    var z: ZStream
    var d = ""
    var sbytes, wbytes = 0
    z.availIn = 0
    var wbits = MAX_WBITS + 32
    var status = inflateInit2(z, wbits.cint)
    if status != Z_OK: assert false
    while true:
      z.availIn = (sourceLen - sbytes).Uint
      if sourceLen-sbytes<=0: break
      z.nextIn = sourceBuf[sbytes].unsafeaddr
      while true:
        if wbytes >= d.len:
          let n = if d.len == 0: sourceLen*2 else: d.len*2
          if n < d.len: discard inflateEnd(z); assert false
          d.setLen(n)
        let space = d.len - wbytes
        z.availOut = space.Uint;z.nextOut = d[wbytes].addr;status = inflate(z, Z_NO_FLUSH)
        if status.int8 notin {Z_OK.int8, Z_STREAM_END.int8, Z_BUF_ERROR.int8}:discard inflateEnd(z);assert false
        wbytes += space - z.availOut.int
        if not (z.availOut == 0):break
      if (status == Z_STREAM_END):break
    discard inflateEnd(z)
    if status != Z_STREAM_END:assert false
    d.setLen(wbytes)
    swap result, d
  proc uncompress*(sourceBuf: string):string = uncompress(sourceBuf, sourceBuf.len)
