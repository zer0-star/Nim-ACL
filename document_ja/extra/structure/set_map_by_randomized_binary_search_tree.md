# set_map_by_randomized_binary_search_tree

> これは RBST backend による古い順序付き set / map 実装です。新規コードでは通常 [sorted_set_map](./sorted_set_map.html) を推奨します。RBST 自体を直接使う場合は [Tree backends](./tree_backends.html) を参照してください。

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/structure/set_map_by_randomized_binary_search_tree

## 公開 API

    const ATCODER_EXTRA_STRUCTURE_SET_MAP_BY_RANDOMIZED_BINARY_SEARCH_TREE_HPP* = 1
    type SortedMultiSet*[K, T] = object
    type SortedSet*[K, T] = object
    type SortedMultiMap*[K, T] = object
    type SortedMap*[K, T] = object
    template getType*(T:typedesc[anySet], K):typedesc =
    template getType*(T:typedesc[anyMap], K, V):typedesc =
    proc init*(T:typedesc[SetOrMap]):T =
    proc Begin*[T:SetOrMap](self: T):auto =
    proc initSortedMultiSet*[K]():auto = SortedMultiSet.getType(K).init()
    proc initSortedSet*[K]():auto = SortedSet.getType(K).init()
    proc initSortedMultiMap*[K, V]():auto = SortedMultiMap.getType(K, V).init()
    proc initSortedMap*[K, V]():auto = SortedMap.getType(K, V).init()
    proc getKey*[T:SetOrMap; Node:RBSTNode](self: T, t:Node):auto =
    proc `*`*[Node:RBSTNode](it:Node):auto = it.key
    proc lower_bound_index*[T:SetOrMap; Node:RBSTNode](self: var T, t:var Node, x:T.K):int {.inline.}=
    proc lower_bound_index*[T:SetOrMap](self:var T, x:T.K):int =
    proc upper_bound_index*[T:SetOrMap; Node:RBSTNode](self: var T, t:var Node, x:T.K):int =
    proc upper_bound_index*[T:SetOrMap](self: var T, x:T.K):int =
    proc lower_bound*[T:SetOrMap; Node:RBSTNode](self: var T, t:var Node, x:T.K):Node {.inline.}=
    proc lower_bound*[T:SetOrMap](self:var T, x:T.K):auto =
    proc upper_bound*[T:SetOrMap; Node:RBSTNode](self: var T, t:var Node, x:T.K):Node =
    proc upper_bound*[T:SetOrMap](self: var T, x:T.K):auto =
    proc findNode*[T:SetOrMap, Node:RBSTNode](self: var T, t:var Node, x:T.K):auto {.inline.}=
    proc findNode*[T:SetOrMap](self:var T, x:T.K):auto =
    proc contains*[T:SetOrMap](self: var T, x:T.K):bool =
    proc kth_element*[T:SetOrMap; Node:RBSTNode](self: var T, t:Node, k:int):T.T =
    proc kth_element*[T:SetOrMap](self: var T, k:int):T.T =
    proc `{}`*[T:SetOrMap](self: var T, k:int):T.T =
    proc insert*[T:SortedMultiSet](self: var T, x:T.K) =
    proc insert*[T:SortedMultiMap](self: var T, x:T.T) =
    proc count*[T:SetOrMap](self: var T, x:T.K):int =
    proc erase*[T:SetOrMap](self: var T, x:T.K) =
    proc erase*[T:SetOrMap](self: var T, t:RBSTNode) =
    proc find*[T:SetOrMap](self:var T, x:T.K):int =
    proc insert*[T:SortedSet](self: var T, x:T.K) =
    proc insert*[T:SortedMap](self: var T, x:T.T) =
    proc `[]`*[K, V](self: var SortedMap[K, tuple[K:K, V:V]], x:K):auto =
    proc `[]=`*[K, V](self: var SortedMap[K, tuple[K:K, V:V]], x:K, v:V) =
    proc len*(self:SetOrMap):int = self.rbst.len()
    proc empty*(self:var SetOrMap):bool = self.rbst.empty()
    proc check_tree*(self:SetOrMap) =
    proc `$`*(self: SetOrMap):string = self.rbst.to_string(self.rbst.root)

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
