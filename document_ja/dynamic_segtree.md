# dynamic_segtree

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/dynamic_segtree

## 公開 API

    const ATCODER_DYNAMIC_SEGTREE_HPP* = 1
    type segtree*[S] = object
    proc initSegTree*[S](v:seq[S], op:(S,S)->S, e:()->S):auto =
    proc initSegTree*[S](n:int, op:(S,S)->S, e:()->S):auto =
    proc set*[ST:segtree](self:var ST, p:int, x:ST.S) {.inline.} =
    proc get*[ST:segtree](self:ST, p:int):ST.S {.inline.} =
    proc prod*[ST:segtree](self:ST, p:Slice[int]):ST.S {.inline.} =
    proc all_prod*[ST:segtree](self:ST):ST.S = self.d[1]
    proc max_right*[ST:segtree](self:ST, l:int, f:proc(s:ST.S):bool):int =
    proc min_left*[ST:segtree](self:ST, r:int, f:proc(s:ST.S):bool):int =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
