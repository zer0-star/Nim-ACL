# trie

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/structure/trie

## 公開 API

    const ATCODER_EXTRA_STRUCTURE_TRIE_HPP* = 1
    type TrieNode*[char_size:static[int]] = object
    proc initTrieNode*[char_size:static[int]]():TrieNode[char_size] =
    type Trie*[char_size, margin:static[int]] = object of RootObj
    proc initTrie*[char_size, margin:static[int]]():Trie[char_size, margin] =
    proc update_direct*(self:var Trie, node, id:int) =
    proc update_child*(self: var Trie, node, child, id:int) =
    proc add*(self: var Trie, str:string, str_index, node_index, id:int) =
    proc add*(self: var Trie, str:string, id:int) =
    proc add*(self: var Trie, str:string) =
    proc query*(self: Trie, str:string, f:proc(a:int):void, str_index, node_index:int) =
    proc query*(self: Trie, str:string, f:proc(a:int):void) =
    proc count*(self: Trie):int =
    proc len*(self: Trie):int =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
