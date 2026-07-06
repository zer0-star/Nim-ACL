# red_black_tree

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/structure/red_black_tree

## 公開 API

    const ATCODER_RED_BLACK_TREE_HPP* = 1
    proc getleaf*[K](self: RedBlackTree[K]):RedBlackTreeNode[K] =
    proc newNode*[T:RedBlackTree](self: var T, parent: T.Node): T.Node =
    proc newNode*[T:RedBlackTree](self: var T, parent: T.Node, key: T.K): T.Node =
    proc init*[T:RedBlackTree](self:var T) =
    template update*[T:RedBlackTree](self:T, node: T.Node) =
    proc init*[T:RedBlackTree](self:var T, root: var T.Node) =
    proc isRoot*[K](nd: RedBlackTreeNode[K]):bool = nd.p.isNil
    proc write*[T:RedBlackTree](rbt: T, self: T.Node, h = 0) =
    proc write*[T:RedBlackTree](self: T) =
    proc checkTree*[T:RedBlackTree](self: T, node: T.Node = nil) =
    proc rotateLeft*[T:RedBlackTree](self: var T, parent: T.Node):T.Node {.discardable.} =
    proc rotateRight*[T:RedBlackTree](self: var T, parent: T.Node):T.Node {.discardable.} =
    proc insert*[T:RedBlackTree](self: var T, node:T.Node, next:T.Node): T.Node {.discardable.} =
    proc insert*[T:RedBlackTree](self: var T, next:T.Node, x:T.K): T.Node {.discardable.} =
    proc erase*[T:RedBlackTree](self: var T, node: T.Node):T.Node =
    proc expose*[T:RedBlackTree](self: var T, N:T.Node):(T.Node, T.Node, T.Node) =
    proc join*[T:RedBlackTree](self: var T, TL, k, TR:T.Node):T.Node =
    proc join*[T:RedBlackTree](self: var T, L, R: T.Node):T.Node =
    proc split3*(self:var RedBlackTree, N:self.Node):auto =
    proc split*(self:var RedBlackTree, N:self.Node):auto =
    proc insert_by_join*[T:RedBlackTree](self: var T, node, next:T.Node):T.Node = # nextの前にnodeを入れる
    proc insert_by_join*[T:RedBlackTree](self: var T, next:T.Node, key:T.K):T.Node = # nextの前にnodeを入れる
    proc len*[T:RedBlackTree](self: T): int =
    proc empty*[T:RedBlackTree](self: T): bool =
    iterator iterOrder*[T:RedBlackTree](self: T): auto =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
