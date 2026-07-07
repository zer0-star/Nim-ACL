# splay_tree

> 使い方の概要と RedBlackTree / RBST / SplayTree の比較は [Tree backends](./tree_backends.html) も参照してください。

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/structure/splay_tree

## 公開 API

    const ATCODER_SPLAY_TREE_HPP* = 1
    type SplayTreeNode*[D, L; hasRev, hasSum: static[bool]] = ref object
    type SplayTreeType*[D, L, Node; hasRev, hasSum: static[bool] ; p:static[tuple]] = object of RootObj
    type SplayTree*[D] = SplayTreeType[D, void, SplayTreeNode[D, void, false, false], false, false, ()]
    type SomeSplayTree* = SplayTreeType or SplayTree
    template calc_op*[ST:SomeSplayTree](self:ST or typedesc[ST], a, b:ST.D):auto =
    template calc_mapping*[ST:SomeSplayTree](self:ST or typedesc[ST], a:ST.L, b:ST.D, c:untyped):auto =
    template calc_composition*[ST:SomeSplayTree](self:ST or typedesc[ST], a, b:ST.L):auto =
    template calc_s*[ST:SomeSplayTree](self:ST or typedesc[ST], a:ST.D):auto =
    proc initNode*[ST:SomeSplayTree](self:var ST, key:ST.D):auto =
    proc initNode*[ST:SomeSplayTree](self:var ST):auto = ST.initNode(ST.D(0))
    proc init*[ST:SomeSplayTree](self: var ST, root: ST.Node = nil, leaf:ST.Node = nil) =
    proc init*[ST:SomeSplayTree](self: typedesc[ST], root: ST.Node = nil):ST =
    template getSplayTreeType*(D, L; hasRev, hasSum: static[bool]; p:static[tuple]):typedesc =
    proc initSplayTree*[D]():auto =
    proc initSplayTree*[D](f:static[proc(a, b:D):D], M1:D):auto =
    proc initReversibleSplayTree*[D](f:static[proc(a, b:D):D], s:static[proc(a:D):D], M1:D):auto =
    proc initReversibleSplayTree*[D](f:static[proc(a, b:D):D], M1:D):auto =
    proc initLazyReversibleSplayTree*[D, L](f:static[proc(a, b:D):D], g:static[proc(b:L, a:D):D], h:static[proc(a, b:L):L], s:static[proc(a:D):D], M1:D, OM0:L):auto =
    proc initLazyReversibleSplayTree*[D, L](f:static[proc(a, b:D):D], g:static[proc(b:L, a:D):D], h:static[proc(a, b:L):L], M1:D, OM0:L):auto =
    proc initLazySplayTree*[D, L](f:static[proc(a, b:D):D], g:static[proc(b:L, a:D):D], h:static[proc(a, b:L):L], pp:static[proc(a:L, c:int):L], M1:D, OM0:L):auto =
    proc initLazySplayTree*[D, L](f:static[proc(a, b:D):D], g:static[proc(b:L, a:D):D], h:static[proc(a, b:L):L], M1:D, OM0:L):auto =
    proc is_root*[T:SomeSplayTree](self:T, t:T.Node):bool =
    proc count*[T:SomeSplayTree](self:T, t:T.Node):int = t.cnt
    proc count*[T:SomeSplayTree](self:T):int = self.count(self.root)
    proc update*[T:SomeSplayTree](self:T, t:T.Node):auto {.discardable.} =
    proc propagate*[T:SomeSplayTree](self:T, t:T.Node, x:T.L) =
    proc toggle*[T:SomeSplayTree](self:T, t:T.Node) =
    proc push*[T:SomeSplayTree](self:T, t:T.Node) =
    proc rotr*[T:SomeSplayTree](self:T, t:T.Node) =
    proc rotl*[T:SomeSplayTree](self:T, t:T.Node) =
    proc splay*[T:SomeSplayTree](self:T, t:T.Node) =
    proc get_left*[T:SomeSplayTree](self:T, t:T.Node):T.Node =
    proc get_right*[T:SomeSplayTree](self:T, t:T.Node):T.Node =
    proc erase*[T:SomeSplayTree](self:T, root:T.Node, t:T.Node, return_right:static[bool] = true):T.Node =
    proc getNodeImpl*[T:SomeSplayTree](self:T, t:var T.Node, k:int):T.Node {.discardable.} =
    proc get_node*[T:SomeSplayTree](self: T, t:var T.Node, k:int):T.Node =
    proc split*[T:SomeSplayTree](self: T, t:T.Node):(T.Node, T.Node) =
    proc split_index*[T:SomeSplayTree](self: T, t:T.Node, k:int):(T.Node, T.Node) =
    proc merge*[T:SomeSplayTree](self:T, rest:varargs[T.Node]):T.Node =
    proc split_index3*[T:SomeSplayTree](self: T, t:T.Node, a, b:int):(T.Node, T.Node, T.Node) =
    proc reverse*[T:SomeSplayTree](self:var T, p: Slice[int]) =
    proc build_node*[T:SomeSplayTree](self:var T, l, r:int, v:seq[T.Node]):T.Node =
    proc build_node*[T:SomeSplayTree](self:var T, v:seq[T.Node]):T.Node =
    proc push_front_node*[T:SomeSplayTree](self:var T, t:var T.Node, z:T.Node) =
    proc push_back_node*[T:SomeSplayTree](self:var T, t:var T.Node, z:T.Node) =
    proc insert_node_index*[T:SomeSplayTree](self:var T, t:var T.Node, k:int, v:T.Node) =
    proc insert*[T:SomeSplayTree](self: var T, t:var T.Node, next:T.Node, v:T.D):T.Node =
    proc erase_index*[T:SomeSplayTree](self: T, t:var T.Node, k:int) =
    proc sum*[T:SomeSplayTree](self:T, t:T.Node):auto =
    proc alloc*[T:SomeSplayTree](self:var T, x:T.D):auto =
    proc prod*[T:SomeSplayTree](self:T, t:var T.Node, s:Slice[int]):T.D =
    proc build*[T:SomeSplayTree](self:var T, t:var T.Node, v:seq[T.D]) =
    proc set*[T:SomeSplayTree](self:var T, t:var T.Node, k:int, x:T.D) =
    proc push_front*[T:SomeSplayTree](self:var T, t:var T.Node, x:T.D) =
    proc push_back*[T:SomeSplayTree](self:var T, t:var T.Node, x:T.D) =
    proc insert_index*[T:SomeSplayTree](self:var T, t:var T.Node, k:int, x:T.D) =
    proc apply_all*[T:SomeSplayTree](self:T, t:var T.Node, pp:T.L) =
    proc apply*[T:SomeSplayTree](self:T, t:var T.Node, s:Slice[int], pp:T.L) =
    proc write_treeImpl*[T:SomeSplayTree](self:T, t:T.Node, h = 0) =
    proc write_tree*[T:SomeSplayTree](self:T, t:T.Node) =
    proc write_tree*[T:SomeSplayTree](self:T) =
    proc setImpl*[T:SomeSplayTree](self:T, t: T.Node, k:int, x:T.D):T.Node {.discardable.} =
    proc check_tree*[T:SomeSplayTree](self:T):void = discard
    proc erase_index*[T:SomeSplayTree](self:var T, t:T.Node) = self.erase_index(self.root, t)
    proc erase_index*[T:SomeSplayTree](self: var T, k:int) = self.erase_index(self.root, k)
    proc erase*[T:SomeSplayTree](self:var T, t:T.Node, return_right:static[bool] = true):T.Node =
    proc get_node*[T:SomeSplayTree](self:var T, k:int):T.Node =
    proc get*[T:SomeSplayTree](self:var T, k:int):T.D = self.get_node(k).key
    proc `[]`*[T:SomeSplayTree](self:var T, k:int):T.D = self.get_node(k).key
    proc set*[T:SomeSplayTree](self:var T, k:int, x:T.D) = self.set(self.root, k, x)
    proc `[]=`*[T:SomeSplayTree](self:var T, k:int, x:T.D) = self.set(self.root, k, x)
    proc push_front*[T:SomeSplayTree](self: var T, z:T.D) = self.push_front(self.root, z)
    proc push_back*[T:SomeSplayTree](self: var T, z:T.D) = self.push_back(self.root, z)
    proc insert_index*[T:SomeSplayTree](self:var T, k:int, x:T.D) = self.insert_index(self.root, k, x)
    proc insert*[T:SomeSplayTree](self: var T, next:T.Node, v:T.D):T.Node = self.insert(self.root, next, v)
    proc build*[T:SomeSplayTree](self:var T, v:seq[T.D]) = self.build(self.root, v)
    proc apply_all*[T:SomeSplayTree](self:var T, pp:T.L) = self.apply_all(self.root, pp)
    proc apply*[T:SomeSplayTree](self:var T, s:Slice[int], pp:T.L) = self.apply(self.root, s, pp)
    proc prod*[T:SomeSplayTree](self:var T, s:Slice[int]):T.D = self.prod(self.root, s)

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
