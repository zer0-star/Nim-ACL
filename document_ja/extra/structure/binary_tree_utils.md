# binary_tree_utils

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/structure/binary_tree_utils

## 公開 API

    const ATCODER_BINARY_TREE_UTILS_HPP* = 1
    type SomeSortedTree* = concept x, type T
    type SomeSortedSet* = concept x, type T
    type SomeSortedMap* = concept x, type T
    type SomeSortedMultiSet* = concept x, type T
    type SomeSortedMultiMap* = concept x, type T
    type hasSplay* = concept x, type T
    proc begin*[T:SomeSortedTree](self: T):T.Node = self.tree.begin()
    proc getKey*[T:SomeSortedTree](self: T, t:T.Node):auto =
    template calc_comp*[T:SomeSortedTree](self:T, x, y:T.K):bool =
    proc lower_bound*[T:SomeSortedTree](self: var T, t:var T.Node, x:T.K):T.Node =
    proc lower_bound*[T:SomeSortedTree](self:var T, x:T.K):T.Node =
    proc upper_bound*[T:SomeSortedTree](self: var T, t:var T.Node, x:T.K):T.Node =
    proc upper_bound*[T:SomeSortedTree](self: var T, x:T.K):T.Node =
    proc find*[T:SomeSortedTree](self:var T, x:T.K):T.Node =
    proc contains*[T:SomeSortedTree](self: var T, x:T.K):bool =
    proc insert*[T:SomeSortedMultiSet](self: var T, x:T.K):T.Node =
    proc insert*[T:SomeSortedMultiMap](self: var T, x:(T.K, T.V)):T.Node =
    proc insert*[T:SomeSortedSet](self: var T, x:T.K):T.Node =
    proc insert*[T:SomeSortedMap](self: var T, x:(T.K, T.V)):T.Node =
    proc incl*[T:SomeSortedSet | SomeSortedMultiSet](self:var T, x:T.K):T.Node =
    proc incl*[T:SomeSortedMap | SomeSortedMultiMap](self:var T, x:(T.K, T.V)):T.Node =
    template getAddr*[T:SomeSortedMap](self:var T, x:T.K):auto =
    template `[]`*[T:SomeSortedMap](self: var T, x:T.K):auto =
    proc `[]=`*[T:SomeSortedMap](self: var T, x:T.K, v:T.V) =
    proc erase*[T:SomeSortedSet or SomeSortedMap](self: var T, x:T.K):T.Node =
    proc erase*[T:SomeSortedMultiSet or SomeSortedMultiMap](self: var T, lb, ub:T.Node):T.Node =
    proc erase*[T:SomeSortedMultiSet or SomeSortedMultiMap](self: var T, x:T.K):T.Node =
    proc erase*[T:SomeSortedTree](self: var T, t:T.Node):T.Node = self.tree.erase(t)
    proc excl*[T:SomeSortedTree](self: var T, x:T.K):T.Node = self.erase(x)
    proc excl*[T:SomeSortedTree](self: var T, t:T.Node):T.Node = self.erase(t)
    proc kth_element*[T:SomeSortedTree](self: var T, t:T.Node, k:int):T.Node =
    proc kth_element*[T:SomeSortedTree](self: var T, k:int):T.Node =
    proc `{}`*[T:SomeSortedTree](self: var T, k:int):T.Node =
    proc index*[T:SomeSortedTree](self:T, t:T.Node):int =
    proc distance*[T:SomeSortedTree](self:T, t1, t2:T.Node):int =
    iterator items*[T:SomeSortedSet or SomeSortedMultiSet](self:T):T.K =
    iterator pairs*[T:SomeSortedMap or SomeSortedMultiMap](self:T):(T.K, T.V) =
    proc `end`*[Tree:SomeSortedTree](self:Tree):Tree.Node = self.End

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
