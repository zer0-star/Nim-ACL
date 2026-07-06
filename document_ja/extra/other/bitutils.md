# bitutils

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/other/bitutils

## 公開 API

    const ATCODER_BITUTILS_HPP* = 1
    proc `<<`*[B:SomeInteger](b:B, n:SomeInteger):B = b shl n
    proc `>>`*[B:SomeInteger](b:B, n:SomeInteger):B = b shr n
    proc seqToBits*[B:SomeInteger](v:varargs[int]): B =
    proc `[]`*[B:SomeInteger](b:B,n:int):int = (if b.testBit(n): 1 else: 0)
    proc `[]`*[B:SomeInteger](b:B,s:Slice[int]):int = (b shr s.a) mod (B(1) shl (s.b - s.a + 1))
    proc `[]=`*[B:SomeInteger](b:var B,n:int,t:int) =
    proc `and`*[B:SomeInteger](b:B, v:openArray[int]):B = b and seqToBits[B](v)
    proc `or`*[B:SomeInteger](b:B, v:openArray[int]):B = b or seqToBits[B](v)
    proc `xor`*[B:SomeInteger](b:B, v:openArray[int]):B = b xor seqToBits[B](v)
    proc `&`*[B:SomeInteger](a:B, b:openarray[int]):auto = a and b
    proc `|`*[B:SomeInteger](a:B, b:openarray[int]):auto = a or b
    proc `&`*(a:SomeInteger, b:SomeInteger):auto = a and b
    proc `|`*(a:SomeInteger, b:SomeInteger):auto = a or b
    iterator iterBits*[B:SomeInteger](b:B):int =
    proc bitsToSeq*[B:SomeInteger](b:B):seq[int] =
    proc `@`*[B:SomeInteger](b:B): seq[int] = bitsToSeq(b)
    proc `@^`*(v:openArray[int]): int =
    proc toBitStr*[B:SomeInteger](b:B, n = -1):string =
    let n = if n == -1: sizeof(B) * 8 else: n
    proc allSetBits*[B:SomeInteger](n:int):B =
    iterator subsets*(v:seq[int], B:typedesc[SomeInteger] = int):B =
    iterator subsets*[B:SomeInteger](b:B):B =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
