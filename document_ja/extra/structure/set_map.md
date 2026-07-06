# set_map

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/structure/set_map

## 公開 API

    const ATCODER_EXTRA_STRUCTURE_SET_MAP_HPP* = 1
    type SortedTree*[Tree, Node, multi, K, V; p:static[tuple]] = object
    proc init*[Tree:SetOrMap](self: var Tree) =
    proc empty*[Tree:SetOrMap](self:Tree):bool = self.tree.empty()
    proc len*[Tree:SetOrMap](self:Tree):int = self.tree.len()
    proc len*[Tree:SetOrMap](self:Tree):int = self.tree.root.cnt - 1
    proc empty*[Tree:SetOrMap](self:Tree):bool = self.len == 0
    proc len*[Tree:SetOrMap](self:Tree):int = self.tree.len() - 1
    proc empty*[Tree:SetOrMap](self:Tree):bool = self.len() == 0
    proc check_tree*(self:SetOrMap) = self.tree.check_tree()
    proc write*(self:SetOrMap) = self.tree.write()
    template SortedSet*(K:typedesc, countable:static[bool] = false, comp:static[proc(a, b:K):bool] = nil):typedesc =
    template SortedMultiSet*(K:typedesc, countable:static[bool] = false, comp:static[proc(a, b:K):bool] = nil):typedesc =
    template SortedMap*(K:typedesc; V:typedesc[not void], countable:static[bool] = false, comp:static[proc(a, b:K):bool] = nil):typedesc =
    template SortedMultiMap*(K:typedesc; V:typedesc[not void], countable: static[bool] = false, comp:static[proc(a, b:K):bool] = nil):typedesc =
    proc default*[T:SetOrMap](self:typedesc[T]):T =
    template initSortedSet*[K](countable:static[bool] = false, comp:static[proc(a, b:K):bool] = nil):auto =
    template initSortedSet*[K](a:openArray[K], countable:static[bool] = false, comp:static[proc(a, b:K):bool] = nil):auto =
    template initSortedMultiSet*[K](countable:static[bool] = false, comp:static[proc(a, b:K):bool] = nil):auto =
    template initSortedMultiSet*[K](a:openArray[K], countable:static[bool] = false, comp:static[proc(a, b:K):bool] = nil):auto =
    template initSortedMap*[K; V:not void](countable:static[bool] = false, comp:static[proc(a, b:K):bool] = nil):auto =
    template initSortedMap*[K; V:not void](a:openArray[(K, V)], countable:static[bool] = false, comp:static[proc(a, b:K):bool] = nil):auto =
    template initSortedMultiMap*[K; V:not void](countable:static[bool] = false, comp:static[proc(a, b:K):bool] = nil):auto =
    template initSortedMultiMap*[K; V:not void](a:openArray[(K, V)], countable:static[bool] = false, comp:static[proc(a, b:K):bool] = nil):auto =
    proc `$`*(self: SetOrMap): string =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
