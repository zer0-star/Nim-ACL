# aho_corasick

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/string/aho_corasick

## 公開 API

    const ATCODER_AHO_CORASICK_HPP* = 1
    template getTrie*(char_sz, margin:static[int]):typedesc = Trie[char_sz, margin]
    proc initAhoCorasick*[char_sz, margin:static[int]](): AhoCorasick[char_sz, margin] =
    proc add*(self: var AhoCorasick, s:string) =
    proc build*(self: var AhoCorasick, heavy = true):void =
    proc match*(self: AhoCorasick, str: string, now = 0):Table[int,seq[int]] =
    proc move*(self: AhoCorasick, c:char, now = 0):(int,int) =
    proc move*(self: AhoCorasick, str:string, now = 0):(int,int) =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
