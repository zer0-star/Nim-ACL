# segtree_2d

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/structure/segtree_2d

## 公開 API

    const ATCODER_EXTRA_STRUCTURE_SEGTREE_2D_HPP* = 1
    type SegTree2D*[S; SegTree] = object
    proc initSegTree2D*[S](v: seq[tuple[x, y:int]], op: static[proc(a, b:S):S], e: static[proc():S]):auto =
    proc add*[ST:SegTree2D](self: var ST, x, y:int, v:ST.S) =
    proc get*[ST:SegTree2D](self: var ST, x, y:int):ST.S =
    proc `[]`*[ST:SegTree2D](self: var ST, x, y:int):ST.S = self.get(x, y)
    proc prod*[ST:SegTree2D](self: var ST, xp, yp: Slice[int] or int):ST.S =
    proc `[]`*[ST:SegTree2D](self: var ST, xp, yp: Slice[int] or int):ST.S = self.prod(xp, yp)

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
