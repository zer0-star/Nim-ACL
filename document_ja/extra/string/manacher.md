# Manacher

`Manacher` は、文字列中のすべての回文半径を線形時間で求めるアルゴリズムです。

各位置を中心とする最長回文の半径を前計算しておくことで、任意の substring が回文かどうかを `O(1)` で判定できます。

## 使いどころ

次のような問題でよく使います。

- 最長回文 substring を求める
- 回文 substring の個数を数える
- `s[l ..< r]` が回文かを多数回判定する
- 回文を使う DP の高速化
- 文字列の左右対称性を利用する問題

## 考え方

素朴には、各中心から左右に伸ばして回文を調べると `O(n^2)` かかります。

Manacher では、すでに見つけた回文区間 `[l, r]` を使って、次の中心の回文半径を再利用します。

今見ている位置 `i` が既存の回文区間内にあるとき、左右対称な位置 `l + r - i` の回文半径を参考にできます。  
そこから、まだ未確定の外側だけを比較して伸ばします。

各文字は全体で高々定数回しか新しく比較されないため、合計 `O(n)` になります。

## odd radius と even radius

この module では、奇数長回文と偶数長回文を分けて扱います。

```nim
odd[i] = r
```

は、`i` を中心とする奇数長回文

```text
s[i-r+1 .. i+r-1]
```

が存在することを表します。回文長は `2*r - 1` です。

```nim
even[i] = r
```

は、`i-1` と `i` の間を中心とする偶数長回文

```text
s[i-r .. i+r-1]
```

が存在することを表します。回文長は `2*r` です。

## import

~~~nim
import atcoder/extra/string/manacher
~~~

## 型

~~~nim
type Manacher[T]
~~~

`string` に対しては `Manacher[char]` が作られます。  
また、`seq[int]` などの一般の sequence に対しても使えます。

## コンストラクタ

~~~nim
proc initManacher[T](s: openArray[T]): Manacher[T]
proc initManacher(s: string): Manacher[char]
~~~

## 半径だけを求める関数

~~~nim
proc manacherOdd[T](s: openArray[T]): seq[int]
proc manacherOdd(s: string): seq[int]

proc manacherEven[T](s: openArray[T]): seq[int]
proc manacherEven(s: string): seq[int]

proc palindromeRadii[T](s: openArray[T]): tuple[odd, even: seq[int]]
proc palindromeRadii(s: string): tuple[odd, even: seq[int]]
~~~

## 操作

~~~nim
proc len[T](m: Manacher[T]): int

proc isPalindrome[T](m: Manacher[T], l, r: int): bool
proc longestPalindromeRange[T](m: Manacher[T]): tuple[l, r: int]
proc longestPalindromeLength[T](m: Manacher[T]): int

proc countPalindromicSubstrings[T](m: Manacher[T]): int
proc countPalindromes[T](m: Manacher[T]): int
~~~

- `isPalindrome(l, r)` は `s[l ..< r]` が回文かを返します。
- `longestPalindromeRange()` は最長回文 substring の半開区間 `[l, r)` を返します。
- `longestPalindromeLength()` は最長回文 substring の長さを返します。
- `countPalindromicSubstrings()` は回文 substring の個数を返します。

## 使用例

<!-- nim-line-numbers -->
~~~nim
let m = initManacher("ababa")

doAssert m.odd == @[1, 2, 3, 2, 1]
doAssert m.even == @[0, 0, 0, 0, 0]

doAssert m.isPalindrome(0, 5)
doAssert m.isPalindrome(1, 4)
doAssert not m.isPalindrome(0, 4)

doAssert m.longestPalindromeLength == 5
doAssert m.longestPalindromeRange == (l: 0, r: 5)

doAssert m.countPalindromicSubstrings == 9
~~~

偶数長回文も扱えます。

<!-- nim-line-numbers -->
~~~nim
let m = initManacher("abba")

doAssert m.odd == @[1, 1, 1, 1]
doAssert m.even == @[0, 0, 2, 0]

doAssert m.isPalindrome(0, 4)
doAssert m.longestPalindromeLength == 4
~~~

## Nim らしい使い方

`Manacher` は `string` だけでなく、比較可能な sequence にも使えます。

~~~nim
let m = initManacher(@[1, 2, 1, 2, 1])

doAssert m.isPalindrome(0, 5)
doAssert m.longestPalindromeLength == 5
~~~

また、UFCS により自然に読めます。

~~~nim
if m.isPalindrome(l, r):
  echo "palindrome"
~~~

## 計算量

文字列長を `n` とすると、

- 構築: `O(n)`
- `isPalindrome`: `O(1)`
- `longestPalindromeLength`: `O(n)`
- `longestPalindromeRange`: `O(n)`
- `countPalindromicSubstrings`: `O(n)`
- memory: `O(n)`

です。

## 注意

- 区間はすべて半開区間 `[l, r)` です。
- `odd` と `even` の半径の意味が異なるので注意してください。
- `countPalindromicSubstrings` は全回文 substring 数を返すため、最悪 `O(n^2)` 個になります。戻り値型は `int` です。

## 関連資料・他言語ライブラリ

- cp-algorithms: Manacher's Algorithm
- Library Checker: palindrome / string 系問題
- Nyaan Library: Manacher
- ei1333 Library: Manacher
