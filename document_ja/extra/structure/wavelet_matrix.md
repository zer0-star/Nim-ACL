# wavelet_matrix

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/structure/wavelet_matrix

## 公開 API

    const ATCODER_WAVELET_MATRIX_HPP* = 1
    type WaveletMatrix*[T;MAXLOG:static[int]] = object
    proc initWaveletMatrix*[T](v:seq[T], MAXLOG:static[int]):WaveletMatrix[T, MAXLOG] =
    proc succ*(self:WaveletMatrix, f:bool or int, p:Slice[int], level:int):(int,int) =
    proc access*(self:WaveletMatrix, k:int):self.T =
    proc `[]`*(self:WaveletMatrix, k:int):self.T =
    proc rank*(self:WaveletMatrix, x:self.T, r:int):int =
    proc kth_smallest*(self:WaveletMatrix, p:Slice[int], k:int):self.T =
    proc kth_largest*(self:WaveletMatrix, p:Slice[int], k:int):self.T =
    proc range_freq*(self:WaveletMatrix, p:Slice[int], upper:self.T):int =
    proc range_freq*(self:WaveletMatrix, p:Slice[int], lower, upper:self.T):int =
    proc prev_value*(self:WaveletMatrix, p:Slice[int], upper:self.T):self.T =
    proc next_value*(self:WaveletMatrix, p:Slice[int], lower:self.T):self.T =
    type CompressedWaveletMatrix*[T;MAXLOG:static[int]] = object
    proc get*(self:CompressedWaveletMatrix, x:self.T):int =
    proc initCompressedWaveletMatrix*[T](v:seq[T], MAXLOG:static[int]):CompressedWaveletMatrix[T, MAXLOG] =
    proc access*(self:CompressedWaveletMatrix, k:int):self.T = self.ys[self.mat.access(k)]
    proc `[]`*(self:CompressedWaveletMatrix, k:int):self.T = return self.access(k)
    proc rank*(self:CompressedWaveletMatrix, x:self.T, r:int):int =
    proc kth_smallest*(self:CompressedWaveletMatrix, p:Slice[int], k:int):self.T =
    proc kth_largest*(self:CompressedWaveletMatrix, p:Slice[int], k:int):self.T =
    proc range_freq*(self:CompressedWaveletMatrix, p:Slice[int], upper:self.T):int =
    proc range_freq*(self:CompressedWaveletMatrix, p:Slice[int], lower, upper:self.T):int =
    proc prev_value*(self:CompressedWaveletMatrix, p:Slice[int], upper:self.T):self.T =
    proc next_value*(self:CompressedWaveletMatrix, p:Slice[int], lower:self.T):self.T =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
