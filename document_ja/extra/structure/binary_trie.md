# BinaryTrie

`BinaryTrie` は、整数を二進表記した bit 列として Trie に入れる data structure です。

通常の `Trie` は文字列の prefix を扱いますが、`BinaryTrie` は整数の上位 bit から分岐します。これにより、集合に含まれる値 `y` のうち、`x xor y` を最大化・最小化する値を高速に探せます。

## 使いどころ

次のような問題でよく使います。

- 動的な multiset に整数を追加・削除しながら、`x xor y` の最大値を答える
- 整数集合に対する XOR 最小値・最大値 query
- bit ごとの貪欲法で処理する XOR 問題
- `0 <= a_i < 2^30` のような非負整数列の XOR minimization

Codeforces 706D “Vasiliy's Multiset” や Library Checker の `Set Xor-Min` 型の問題が代表例です。

## 考え方

各整数を `maxLog` bit 目から 0 bit 目まで見て、0/1 の枝に降りていきます。

`maxXor(x)` では、上位 bit から見て、できるだけ `x` と反対の bit を持つ枝を選びます。上位 bit の方が値への影響が大きいため、この貪欲法で最大 XOR が得られます。

`minXor(x)` では逆に、できるだけ `x` と同じ bit を持つ枝を選びます。

各 node には、その node 以下にある要素数 `count` を持たせます。これにより、重複要素を扱えるうえ、削除後に空になった枝を避けて query できます。

## import

~~~nim
import atcoder/extra/structure/binary_trie
~~~

## 型

~~~nim
type BinaryTrie[T: SomeInteger]
~~~

`T` は整数型です。通常は `int`, `int64`, `uint64` などを使います。

## コンストラクタ

~~~nim
proc initBinaryTrie[T: SomeInteger](maxLog: int = 60): BinaryTrie[T]
~~~

`maxLog` は見る最大 bit index です。

例えば `0 <= x < 2^30` の値だけを扱うなら、`maxLog = 29` または余裕を見て `maxLog = 30` とします。

## 操作

~~~nim
proc len[T](tr: BinaryTrie[T]): int
proc empty[T](tr: BinaryTrie[T]): bool

proc insert[T](tr: var BinaryTrie[T], x: T)
proc add[T](tr: var BinaryTrie[T], x: T, c: int)
proc erase[T](tr: var BinaryTrie[T], x: T, c: int = 1)

proc count[T](tr: BinaryTrie[T], x: T): int
proc contains[T](tr: BinaryTrie[T], x: T): bool

proc minXor[T](tr: BinaryTrie[T], x: T): T
proc maxXor[T](tr: BinaryTrie[T], x: T): T

proc minElementXor[T](tr: BinaryTrie[T], x: T): T
proc maxElementXor[T](tr: BinaryTrie[T], x: T): T
~~~

- `insert(x)` は `x` を 1 個追加します。
- `add(x, c)` は `x` を `c` 個追加します。
- `erase(x, c)` は `x` を `c` 個削除します。
- `count(x)` は `x` の個数を返します。
- `x in tr` で存在判定できます。
- `minXor(x)` は `x xor y` の最小値を返します。
- `maxXor(x)` は `x xor y` の最大値を返します。
- `minElementXor(x)` は `x xor y` を最小化する要素 `y` を返します。
- `maxElementXor(x)` は `x xor y` を最大化する要素 `y` を返します。

## 使用例

~~~nim
var tr = initBinaryTrie[int](maxLog = 30)

tr.insert(0)
tr.insert(5)
tr.insert(7)
tr.insert(5)

doAssert tr.len == 4
doAssert 5 in tr
doAssert tr.count(5) == 2

doAssert tr.minXor(2) == 2  # 2 xor 0
doAssert tr.maxXor(2) == 7  # 2 xor 5

tr.erase(5)

doAssert tr.count(5) == 1
~~~

## 制約

この実装は、`0 <= x < 2^(maxLog + 1)` の非負整数を主な対象にしています。

負の整数を入れた場合は `uint64` 表現に基づいて bit を見ます。通常の競プロ用途では、非負整数で使うことを推奨します。

## 計算量

`B = maxLog + 1` とすると、

- `insert`: `O(B)`
- `erase`: `O(B)`
- `count`: `O(B)`
- `minXor`, `maxXor`: `O(B)`
- memory: `O(B * distinct values)`

です。

## 関連資料・他言語ライブラリ

- Library Checker: `Set Xor-Min`
- Nyaan Library: Binary Trie
- ei1333 Library: Binary Trie
- Codeforces 706D: Vasiliy's Multiset
