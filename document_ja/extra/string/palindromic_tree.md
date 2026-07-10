# PalindromicTree / Eertree

`PalindromicTree` は、文字列に含まれる異なる回文 substring を状態として管理する data structure です。`Eertree` とも呼ばれます。

Manacher が各中心の回文半径を求めるのに対し、Palindromic Tree は「異なる回文そのもの」と suffix relation を管理します。

## 使いどころ

- 異なる回文 substring の個数
- 各回文の出現回数
- 文字を末尾に追加しながら回文を管理する
- 回文 suffix を使う DP
- 最長回文 substring

## 考え方

各 node は1つの異なる回文を表します。

文字 `c` を追加すると、現在の最長 suffix palindrome から suffix link をたどり、両端に `c` を追加できる回文を探します。新しい回文なら node を1つ追加します。

2つの特別な root を持ちます。

- 長さ `-1` の仮想回文
- 長さ `0` の空回文

## import

~~~nim
import atcoder/extra/string/palindromic_tree
~~~

## 構築

~~~nim
proc initPalindromicTree(): PalindromicTree
proc initPalindromicTree(s: string): PalindromicTree
proc add(pt: var PalindromicTree, ch: char): int
proc add(pt: var PalindromicTree, s: string)
proc buildOccurrences(pt: var PalindromicTree)
~~~

## 操作

~~~nim
proc distinctPalindromeCount(pt: PalindromicTree): int
proc totalPalindromeOccurrences(pt: PalindromicTree): int
proc palindrome(pt: PalindromicTree, node: int): string
proc palindromes(pt: PalindromicTree): seq[string]
proc longestPalindromeRange(pt: PalindromicTree): tuple[l, r: int]
proc longestPalindromeLength(pt: PalindromicTree): int
~~~

## 使用例

<!-- nim-line-numbers -->
~~~nim
let pt = initPalindromicTree("ababa")

doAssert pt.distinctPalindromeCount == 5
doAssert pt.totalPalindromeOccurrences == 9
doAssert pt.longestPalindromeLength == 5

for p in pt.palindromes:
  echo p
~~~

## Manacher との使い分け

- 回文判定や中心ごとの半径が欲しい: `Manacher`
- 異なる回文・出現回数・suffix relation が欲しい: `PalindromicTree`

## 計算量

- 構築: `O(n)` 期待時間
- node 数: 異なる回文数 + 2、高々 `n+2`
- memory: `O(n)`

## 関連資料・他言語ライブラリ

- [cp-algorithms: Palindromic Tree](https://cp-algorithms.com/string/eertree.html)
- Nyaan Library: Palindromic Tree
- ei1333 Library: Palindromic Tree
