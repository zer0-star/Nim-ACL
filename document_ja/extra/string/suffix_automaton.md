# SuffixAutomaton

`SuffixAutomaton` は、1つの文字列に含まれるすべての substring を受理する最小 DFA です。

文字列長を `n` とすると状態数は高々 `2n-1` で、substring の存在判定、出現回数、異なる substring 数、最長共通 substring などを高速に処理できます。

## 使いどころ

- pattern が元文字列の substring か判定する
- substring の出現回数を求める
- 異なる substring の個数を数える
- 2文字列の最長共通 substring を求める
- substring を状態として扱う DP

## 考え方

各状態は、元文字列中で同じ `end position` 集合を持つ substring の集合を表します。

`link` は、現在の状態が表す substring の最長 proper suffix に対応する状態です。文字を1つ追加するたびに状態と suffix link を更新し、必要な場合は状態を clone します。

状態 `v` が表す新しい substring 数は

```text
len[v] - len[link[v]]
```

なので、これを全状態について足すと異なる substring 数になります。

## import

~~~nim
import atcoder/extra/string/suffix_automaton
~~~

## 型と構築

~~~nim
type SuffixAutomaton
type SuffixAutomatonState

proc initSuffixAutomaton(): SuffixAutomaton
proc initSuffixAutomaton(s: string): SuffixAutomaton
proc extend(sam: var SuffixAutomaton, ch: char): int
proc add(sam: var SuffixAutomaton, s: string)
proc buildOccurrences(sam: var SuffixAutomaton)
~~~

空から構築する場合は、文字をすべて追加した後に `buildOccurrences()` を呼びます。

## 操作

~~~nim
proc stateFor(sam: SuffixAutomaton, pattern: string): int
proc contains(sam: SuffixAutomaton, pattern: string): bool
proc occurrenceCount(sam: SuffixAutomaton, pattern: string): int
proc distinctSubstringCount(sam: SuffixAutomaton): int64

proc longestCommonSubstring(
  sam: SuffixAutomaton,
  text: string
): tuple[length, l, r: int]
~~~

## 使用例

~~~nim
let sam = initSuffixAutomaton("ababa")

doAssert "aba" in sam
doAssert "abb" notin sam

doAssert sam.occurrenceCount("a") == 3
doAssert sam.occurrenceCount("aba") == 2
doAssert sam.distinctSubstringCount == 9

let lcs = sam.longestCommonSubstring("zzbabc")

doAssert lcs.length == 3
doAssert "zzbabc"[lcs.l ..< lcs.r] == "bab"
~~~

## 計算量

- 構築: `O(n)`
- substring 存在判定: `O(|pattern|)`
- 出現回数: `O(|pattern|)`
- 異なる substring 数: `O(states)`
- 最長共通 substring: `O(|text|)`
- 状態数: 高々 `2n-1`

## 関連資料・他言語ライブラリ

- [cp-algorithms: Suffix Automaton](https://cp-algorithms.com/string/suffix-automaton.html)
- Nyaan Library: Suffix Automaton
- ei1333 Library: Suffix Automaton
