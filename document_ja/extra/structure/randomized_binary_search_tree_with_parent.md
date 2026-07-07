# randomized_binary_search_tree_with_parent

> 使い方の概要と RedBlackTree / RBST / SplayTree の比較は [Tree backends](./tree_backends.html) も参照してください。

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/structure/randomized_binary_search_tree_with_parent

## 公開 API

    const ATCODER_EXTRA_STRUCTURE_RANDOMIZED_BINARY_SEARCH_TREE_WITH_PARENT_HPP* = 1
    type RBSTNode*[D, L, useSum] = ref object
    type RBSTType*[D,L,Node,useP, useSum;p:static[tuple]] = object of RootObj
    type RandomizedBinarySearchTree*[D] = RBSTType[D,void,RBSTNode[D,void,RBST_FALSE],RBST_FALSE,RBST_FALSE,()]
    type LazyRandomizedBinarySearchTree*[D,L,useP,useSum] = RBSTType[D,L,RBSTNode[D,L,useSum],useP,useSum,()]
    type SomeRBST* = RBSTType or RandomizedBinarySearchTree or LazyRandomizedBinarySearchTree
    proc hasSum*[RBST:SomeRBST](t:typedesc[RBST]):bool {.compileTime.} =
    proc hasLazy*[RBST:SomeRBST](t:typedesc[RBST]):bool {.compileTime.} =
    proc initNode*[RBST:SomeRBST](self:RBST, k:RBST.D, p:RBST.L, id:int, cnt:int):auto =
    proc initNode*[RBST:SomeRBST](self:RBST, k:RBST.D, id:int, cnt:int):auto =
    proc alloc*[RBST:SomeRBST](self: var RBST, key:RBST.D, cnt = 1):RBST.Node =
    proc init*[RBST:SomeRBST](self: var RBST, root: RBST.Node = nil, seed = 2019) =
    proc initRandomizedBinarySearchTree*[D](seed = 2019):auto =
    proc initRandomizedBinarySearchTree*[D](f:static[(D,D)->D], D0:D, seed = 2019):auto =
    proc initRandomizedBinarySearchTree*[D, L](f:static[(D,D)->D], g:static[(L,D)->D], h:static[(L,L)->L], D0:D, L0:L, seed = 2019):auto =
    proc initRandomizedBinarySearchTree*[D, L](f:static[(D,D)->D], g:static[(L,D)->D], h:static[(L,L)->L], p:static[(L,Slice[int])->L],D0:D,L0:L,seed = 2019):auto =
    template clone*[D,L,useSum](t:RBSTNode[D, L, useSum]):auto = t
    proc test*[RBST:SomeRBST](self: var RBST, n, s:int):bool =
    proc sum*[RBST:SomeRBST](self: RBST, t:RBST.Node):auto = t.sum
    proc len*[RBST:SomeRBST](self: RBST, t:RBST.Node):int = t.cnt
    proc len*[RBST:SomeRBST](self: RBST):int = self.len(self.root)
    proc update*[RBST:SomeRBST](self: RBST, t:RBST.Node):RBST.Node {.inline.} =
    proc propagate*[RBST:SomeRBST](self: var RBST, t:RBST.Node):auto =
    proc merge*[RBST:SomeRBST](self: var RBST, l, r:RBST.Node):auto =
    proc split*[RBST:SomeRBST](self:var RBST, t:RBST.Node, k:int):(RBST.Node, RBST.Node) =
    proc split*[RBST:SomeRBST](self:var RBST, t:RBST.Node, p:RBST.Node):(RBST.Node, RBST.Node) =
    proc build*[RBST:SomeRBST](self: var RBST, s:Slice[int], v:seq[RBST.D]):auto =
    proc build*[RBST:SomeRBST](self: var RBST, v:seq[RBST.D]) =
    proc to_vec*[RBST:SomeRBST](self: RBST, r:RBST.Node, v:var seq[RBST.D]) =
    proc to_vec*[RBST:SomeRBST](self: RBST, r:RBST.Node):auto =
    proc to_string*[RBST:SomeRBST](self: RBST, r:RBST.Node):string =
    proc write_tree*[RBST:SomeRBST](self: var RBST, r:RBST.Node, h = 0) =
    proc write_tree*[RBST:SomeRBST](self: var RBST) =
    proc insert_index*[RBST:SomeRBST](self: var RBST, t:var RBST.Node, k:int, v:RBST.D) =
    proc insert*[RBST:SomeRBST](self: var RBST, t:var RBST.Node, p:RBST.Node, v:RBST.D):RBST.Node {.discardable.} =
    proc erase_index*[RBST:SomeRBST](self: var RBST, t:var RBST.Node, k:int) =
    proc erase*[RBST:SomeRBST](self: var RBST, t:var RBST.Node, p:RBST.Node):RBST.Node {.discardable.} =
    proc prod*[RBST:SomeRBST](self: var RBST, t:var RBST.Node, p:Slice[int]):auto =
    proc apply*[RBST:SomeRBST](self:var RBST, t:var RBST.Node, s:Slice[int], p:RBST.L) =
    proc set*[RBST:SomeRBST](self: var RBST, t:var RBST.Node, k:int, x:RBST.D) =
    proc empty*[RBST:SomeRBST](self: var RBST, t:RBST.Node):bool = self.len == 0
    proc insert_index*[RBST:SomeRBST](self: var RBST, k:int, v:RBST.D):RBST.Node {.discardable.} =
    proc insert*[RBST:SomeRBST](self: var RBST, p:RBST.Node, v:RBST.D):RBST.Node {.discardable.} =
    proc erase_index*[RBST:SomeRBST](self: var RBST, k:int):RBST.Node {.discardable.} =
    proc erase*[RBST:SomeRBST](self: var RBST, p:RBST.Node):RBST.Node {.discardable.} =
    proc prod*[RBST:SomeRBST](self: var RBST, p:Slice[int]):auto = self.prod(self.root, p)
    proc `[]`*[RBST:SomeRBST](self: var RBST, p:Slice[int]):auto = self.prod(self.root, p)
    proc apply*[RBST:SomeRBST](self:var RBST, s:Slice[int], p:RBST.L) = self.apply(self.root, s, p)
    proc set*[RBST:SomeRBST](self: var RBST, k:int, x:RBST.D) = self.set(self.root, k, x)
    proc `[]=`*[RBST:RBSTType](self: var RBST, k:int, x:RBST.D) = self.set(self.root, k, x)
    proc empty*[RBST:SomeRBST](self: var RBST):bool = self.empty(self.root)
    proc check_tree*[RBST:SomeRBST](self: RBST, t:RBST.Node):int =
    proc check_tree*[RBST:SomeRBST](self: RBST):int {.discardable.} =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
