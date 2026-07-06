# doubling_lowest_common_ancestor

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/tree/doubling_lowest_common_ancestor

## 公開 API

    const ATCODER_LOWEST_COMMON_ANCESTOR_DOUBLING* = 1
    type DoublingLowestCommonAncestor*[T] = object
    proc initDoublingLowestCommonAncestor*[G:GraphC](g:G, r = 0):DoublingLowestCommonAncestor[G.T] =
    proc ancestor*[T](self: DoublingLowestCommonAncestor[T], u:int, h:int):int =
    proc lca*[T](self: DoublingLowestCommonAncestor[T], u, v:int):int =
    proc dist*[T](self: DoublingLowestCommonAncestor[T], u, v:int):int =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
