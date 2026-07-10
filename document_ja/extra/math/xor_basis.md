# XorBasis

`XorBasis` は、整数集合から XOR で作れる値の集合を「線形基底」として管理する data structure です。

整数を bit vector とみなすと、XOR は GF(2) 上の加算になります。  
そのため、通常の Gaussian elimination と同じように、独立な値だけを残しておけば、subset XOR に関する query を高速に処理できます。

## 使いどころ

次のような問題でよく使います。

- 集合の部分集合 XOR の最大値を求める
- `x xor y` を最大化・最小化する。ただし `y` は挿入済み値の XOR で作れる値
- ある値 `x` が、挿入済み値の XOR で作れるか判定する
- グラフの cycle XOR を使った最大 XOR path
- range query に対する XOR basis の merge

## 考え方

整数の各 bit を座標とみなします。  
例えば `13 = 1101_2` は、GF(2) 上の vector と考えられます。

`add(x)` では、上位 bit から見ていきます。

- その bit を代表する basis がまだ無ければ、`x` を新しい basis として追加する
- すでに basis があれば、`x xor basis` によってその上位 bit を消す

最後に `x = 0` になった場合、元の `x` は既存 basis の XOR で表せます。  
逆に 0 にならずに新しい pivot bit が見つかれば、独立な vector として追加できます。

これは GF(2) 上の掃き出し法と同じ考え方です。

## import

~~~nim
import atcoder/extra/math/xor_basis
~~~

## 型

~~~nim
type XorBasis[T: SomeInteger]
~~~

`T` は整数型です。通常は `int`, `int64`, `uint64` などを使います。

## コンストラクタ

~~~nim
proc initXorBasis[T: SomeInteger](maxLog: int = 60): XorBasis[T]
~~~

`maxLog` は見る最大 bit index です。

例えば `0 <= x < 2^60` なら `maxLog = 59` または余裕を見て `maxLog = 60` とします。

## 操作

~~~nim
proc rank[T](xb: XorBasis[T]): int
proc len[T](xb: XorBasis[T]): int
proc empty[T](xb: XorBasis[T]): bool

proc add[T](xb: var XorBasis[T], x: T): bool
proc addAll[T](xb: var XorBasis[T], xs: openArray[T])

proc reduce[T](xb: XorBasis[T], x: T): T
proc canRepresent[T](xb: XorBasis[T], x: T): bool
proc contains[T](xb: XorBasis[T], x: T): bool

proc maxXor[T](xb: XorBasis[T]): T
proc maxXor[T](xb: XorBasis[T], x: T): T
proc minXor[T](xb: XorBasis[T], x: T): T

proc basisSeq[T](xb: XorBasis[T]): seq[T]
proc merge[T](a, b: XorBasis[T]): XorBasis[T]
~~~

- `rank()` / `len()` は独立な basis の数を返します。
- `add(x)` は `x` を追加します。rank が増えたら `true` を返します。
- `reduce(x)` は basis で `x` を簡約した残りを返します。
- `canRepresent(x)` は `x` が作れるかを返します。
- `x in xb` でも表現可能性を判定できます。
- `maxXor()` は作れる値の最大値を返します。
- `maxXor(x)` は `x xor y` の最大値を返します。
- `minXor(x)` は `x xor y` の最小値を返します。
- `merge(a, b)` は 2 つの basis を合成します。

## 使用例

<!-- nim-line-numbers -->
~~~nim
var xb = initXorBasis[int](maxLog = 4)

doAssert xb.add(3) == true
doAssert xb.add(5) == true
doAssert xb.add(6) == false  # 6 = 3 xor 5

doAssert xb.rank == 2

doAssert 6 in xb
doAssert 1 notin xb

doAssert xb.maxXor() == 6
doAssert xb.maxXor(1) == 7
doAssert xb.minXor(7) == 1
~~~

## merge

basis は merge できます。

~~~nim
var a = initXorBasis[int](maxLog = 3)
var b = initXorBasis[int](maxLog = 3)

discard a.add(1)
discard a.add(2)

discard b.add(4)

let c = merge(a, b)

doAssert c.maxXor() == 7
doAssert 7 in c
~~~

## Nim らしい使い方

`contains` が定義されているので、表現可能性を `in` で書けます。

~~~nim
if x in xb:
  echo "x is representable"
~~~

また、`rank` は proc ですが、Nim の UFCS により `xb.rank` のように読めます。

~~~nim
doAssert xb.rank == xb.len
~~~

## 制約

この実装は、`0 <= x < 2^(maxLog + 1)` の非負整数を主な対象にしています。

負の整数を入れた場合は `uint64` 表現に基づいて bit を見ます。通常の競プロ用途では、非負整数で使うことを推奨します。

## 計算量

`B = maxLog + 1` とすると、

- `add`: `O(B)`
- `reduce`: `O(B)`
- `canRepresent`: `O(B)`
- `maxXor`, `minXor`: `O(B)`
- `merge`: `O(B^2)` 程度。ただし通常 `B <= 64` なので実用上軽いです。
- memory: `O(B)`

です。

## 関連資料・他言語ライブラリ

- cp-algorithms: Gaussian elimination / linear algebra over fields
- Library Checker: GF(2) linear algebra 系の問題
- Codeforces: subset XOR / maximum XOR basis 型の問題
- Nyaan Library: Binary Basis / XOR Basis 系 module
- ei1333 Library: Linear Basis 系 module
