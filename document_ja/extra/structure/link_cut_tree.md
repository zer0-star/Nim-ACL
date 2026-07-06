# link_cut_tree

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/structure/link_cut_tree

## 公開 API

    const ATCODER_LINK_CUT_TREE_HPP* = 1
    type LinkCutTree*[ST:SplayTreeType] = object
    proc expose*[ST](self:LinkCutTree[ST], t:ST.Node):auto {.discardable.} =
    proc link*[ST](self:LinkCutTree[ST], child, parent:ST.Node) =
    proc cut*[ST](self:LinkCutTree[ST], child:ST.Node) =
    proc evert*[ST](self:LinkCutTree[ST], t:ST.Node) =
    proc lca*[ST](self:LinkCutTree[ST], u, v:ST.Node):auto =
    proc get_kth*[ST](self:LinkCutTree[ST], x:ST.Node, k:int):auto =
    proc get_root*[ST](self:LinkCutTree[ST], x:ST.Node):auto =
    proc initLinkCutTree*[T](f:static[proc(a, b:T):T], s:static[proc(a:T):T], M1:T):auto =
    proc initLinkCutTree*[T](f:static[proc(a, b:T):T], M1:T):auto =
    proc alloc*[ST](self:var LinkCutTree[ST], x:ST.D):ST.Node =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
