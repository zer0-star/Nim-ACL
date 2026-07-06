# range_chmin_chmax_add_range_sum

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/structure/range_chmin_chmax_add_range_sum

## 公開 API

    const ATCODER_EXTRA_RANGE_CHMIN_CHMAX_ADD_RANGE_SUM_HPP* = 1
    proc initS*[CLS: RCCARS_Base](cls: typedesc[CLS]):CLS.S =
    proc initS*[CLS: RCCARS_Base](cls: typedesc[CLS], x:CLS.Num, sz: int):CLS.S =
    type RangeChminChmaxAddRangeSum*[Num; INF: static[Num]; S, F, base, ST] = object
    proc Chmin*[CLS: RCCARS_Base](cls: typedesc[CLS], x: CLS.Num): CLS.F = return CLS.initF(-CLS.INF, x, CLS.Num(0))
    proc Chmax*[CLS: RCCARS_Base](cls: typedesc[CLS], x: CLS.Num): CLS.F = return CLS.initF(x, CLS.INF, CLS.Num(0))
    proc Add*[CLS: RCCARS_Base](cls: typedesc[CLS], x: CLS.Num): CLS.F = return CLS.initF(-CLS.INF, CLS.INF, x)
    proc Gen*[CLS: RCCARS_Base](cls: typedesc[CLS], x: CLS.Num, sz = 1):CLS.S = CLS.initS(x, sz)
    proc initRangeChminChmaxAddRangeSum*[Num](v: int or seq[Num], INF: static[Num] = int.high div 2): auto =
    proc chmin*[CLS: RangeChminChmaxAddRangeSum](self: var CLS, p:Slice[int], x: CLS.Num) =
    proc chmax*[CLS: RangeChminChmaxAddRangeSum](self: var CLS, p:Slice[int], x: CLS.Num) =
    proc add*[CLS: RangeChminChmaxAddRangeSum](self: var CLS, p:Slice[int], x: CLS.Num) =
    proc `[]`*[CLS: RangeChminChmaxAddRangeSum](self: var CLS, p:Slice[int]): CLS.Num =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
