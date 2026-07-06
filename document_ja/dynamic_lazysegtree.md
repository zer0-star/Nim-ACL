# dynamic_lazysegtree

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/dynamic_lazysegtree

## 公開 API

    const ATCODER_DYNAMIC_LAZYSEGTREE_HPP* = 1
    type lazy_segtree*[S,F] = object
    proc update*[ST:lazy_segtree](self:var ST, k:int) = self.d[k] = self.op(self.d[2 * k], self.d[2 * k + 1])
    proc all_apply*[ST:lazy_segtree](self:var ST, k:int, f:ST.F) =
    proc push*[ST:lazy_segtree](self: var ST, k:int) =
    proc init_lazy_segtree*[S, F](v:seq[S], op:(S,S)->S,e:()->S,mapping:(F,S)->S,composition:(F,F)->F,id:()->F):auto =
    var d = newSeqWith(2 * size, e())
    proc init_lazy_segtree*[S, F](n:int, op:(S,S)->S,e:()->S,mapping:(F,S)->S,composition:(F,F)->F,id:()->F):auto =
    proc set*[ST:lazy_segtree](self: var ST, p:int, x:ST.S) =
    proc get*[ST:lazy_segtree](self: var ST, p:int):ST.S =
    proc prod*[ST:lazy_segtree](self:var ST, p:Slice[int]):ST.S =
    proc all_prod*[ST:lazy_segtree](self:ST):auto = self.d[1]
    proc apply*[ST:lazy_segtree](self: var ST, p:int, f:ST.F) =
    proc apply*[ST:lazy_segtree](self: var ST, p:Slice[int], f:ST.F) =
    proc max_right*[ST:lazysegtree](self:var ST, l:int, g:(ST.S)->bool):int =
    proc min_left*[ST:lazy_segtree](self: var ST, r:int, g:(ST.S)->bool):int =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
