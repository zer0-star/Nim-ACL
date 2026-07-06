# suffix_automaton

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/string/suffix_automaton

## 公開 API

    const ATCODER_SUFFIX_AUTOMATION_HPP* = 1
    type SuffixAutomatonNode*[C] = ref object
    proc copy*[C](nd:SuffixAutomatonNode[C]):SuffixAutomatonNode[C] =
    type SuffixAutomaton*[Node] = object
    proc extend*[Node](self:var SuffixAutomaton[Node], c:Node.C) =
    proc initSuffixautomaton*[C]():auto =
    proc initSuffixautomaton*[C](s:string):auto =
    proc toposort*[Node](self: SuffixAutomaton[Node]):seq[int] =
    proc `[]`*[Node](self: SuffixAutomaton[Node], i:int):auto = self.nodes[i]
    iterator pairs*[C](self: SuffixAutomatonNode[C]):(C, int) =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
