# suffix_array_utils

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/string/suffix_array_utils

## 公開 API

    const ATCODER_SUFFIX_ARRAY_UTILS* = 1
    proc lt_substr*(self: SuffixArray, t:string, si = 0, ti = 0):bool =
    proc initSuffixArray*(s:string):SuffixArray =
    proc `[]`*(self:SuffixArray, k:int):int =
    proc size*(self:SuffixArray):int =
    proc lowerBound*(self:SuffixArray, t:string):int =
    proc lowerUpperBound*(self:SuffixArray, t:string):(int,int) =
    proc output*(self:SuffixArray):void =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
