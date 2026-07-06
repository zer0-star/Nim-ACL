# li_chao_tree

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/structure/li_chao_tree

## 公開 API

    const ATCODER_LI_CHAO_TREE_HPP* = 1
    proc initLine*[T](a, b:T):Line[T] = Line[T](a:a, b:b)
    proc get*[T](self: Line[T], x:T):T =
    proc over*[T](self, b: Line[T], x: T):bool = self.get(x) < b.get(x)
    proc initLiChaoTree*[T](x: seq[T], inf_val:T):LiChaoTree[T] =
    proc disjoint*(x, y:Slice[int]):bool = x.b < y.a or y.b < x.a
    proc subset*(x, y:Slice[int]):bool = y.a <= x.a and x.b <= y.b
    proc update*[T](self: var LiChaoTree[T], x:ptr[Line], k:int, ks:Slice[int]) =
    proc update*[T](self: var LiChaoTree[T], a, b:T, s:Slice[int]) =
    proc update*[T](self: var LiChaoTree[T], a, b:T) =
    proc query*[T](self: var LiChaoTree[T], k:int):T =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
