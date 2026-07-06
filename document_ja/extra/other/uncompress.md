# uncompress

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/other/uncompress

## 公開 API

    const ATCODER_UNCOMPRESS_HPP* = 1
    proc inflate*(strm: var ZStream, flush: cint): cint{.cdecl, dynlib: libz, importc: "inflate".}
    proc inflateEnd*(strm: var ZStream): cint{.cdecl, dynlib: libz, importc: "inflateEnd".}
    proc inflateInit2u*(strm: var ZStream, windowBits: cint, version: cstring, streamSize: cint): cint{.cdecl, dynlib: libz, importc: "inflateInit2_".}
    proc uncompress*(sourceBuf: cstring, sourceLen: Natural): string =
    let n = if d.len == 0: sourceLen*2 else: d.len*2
    proc uncompress*(sourceBuf: string):string = uncompress(sourceBuf, sourceBuf.len)

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
