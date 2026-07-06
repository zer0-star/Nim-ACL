# fft

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/math/fft

## 公開 API

    const ATCODER_FFT_HPP* = 1
    proc initComplex*[S,T](x:S, y:T):Complex =
    proc `+`*(a,b:Complex):Complex = initComplex(a.x + b.x, a.y + b.y)
    proc `-`*(a,b:Complex):Complex = initComplex(a.x - b.x, a.y - b.y)
    proc `*`*(a,b:Complex):Complex = initComplex(a.x * b.x - a.y * b.y, a.x * b.y + a.y * b.x)
    proc conj*(a:Complex):Complex = initComplex(a.x, -a.y)
    proc initSeqComplex*(n:int):SeqComplex = SeqComplex(real: newSeqWith(n, Real(0)), imag: newSeqWith(n, Real(0)))
    proc setLen*(self: var SeqComplex, n:int) =
    proc swap*(self: var SeqComplex, i, j:int) =
    type FastFourierTransform* = object of RootObj
    proc getC*(self: SeqComplex, i:int):Complex = (self.real[i], self.imag[i])
    proc `[]`*(self: SeqComplex, i:int):Complex = self.getC(i)
    proc `[]=`*(self: var SeqComplex, i:int, x:Complex) =
    proc initFastFourierTransform*():FastFourierTransform =
    proc ensureBase*(self:var FastFourierTransform; nbase:int) =
    let angle = arccos(Real(-1)) * Real(2) / Real(1 shl (self.base + 1))
    let angle_i = angle * Real(2 * i + 1 - (1 shl self.base))
    let z = a[i + j + k] * self.rts[j + k]
    var fft_t* = initFastFourierTransform()
    proc fft*[T:SomeFloat or Real](a:seq[T]):SeqComplex =
    proc ifft*(a:SeqComplex, T:typedesc[SomeFloat or Real]):auto =
    proc inplace_partial_dot*(a:var SeqComplex, b:SeqComplex, p:Slice[int], T:typedesc[SomeFloat or Real]):auto =
    proc dot*(a, b:SeqComplex, T:typedesc[SomeFloat or Real]):auto =
    proc multiply*[T:SomeFloat or Real](a, b:seq[T]):seq[T] =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
