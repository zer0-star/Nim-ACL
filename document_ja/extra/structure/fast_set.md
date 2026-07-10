# FastSet

`FastSet` は、整数 universe `[0, n)` 上の集合を階層化 bitset で管理する data structure です。

通常の balanced tree と同じように、要素の追加・削除・存在判定に加えて、指定値以上の最小要素や指定値以下の最大要素を高速に取得できます。

## 使いどころ

- successor / predecessor query
- 未処理 index の集合
- 区間を飛ばしながら走査する問題
- `set<int>` より定数倍を小さくしたい場合
- Library Checker の Predecessor Problem 型

## 考え方

最下層の bitset で実際の値を管理し、その上の層では「下の層の word が空でないか」を bit で管理します。

同じ word 内に候補がなければ上の層へ移動し、非空 word を見つけたら下の層へ降ります。

## import

~~~nim
import atcoder/extra/structure/fast_set
~~~

## API

~~~nim
proc initFastSet(n: int): FastSet
proc initFastSet(n: int, values: openArray[int]): FastSet

proc insert(s: var FastSet, x: int): bool
proc erase(s: var FastSet, x: int): bool
proc contains(s: FastSet, x: int): bool

proc nextGE(s: FastSet, x: int): int
proc lowerBound(s: FastSet, x: int): int
proc upperBound(s: FastSet, x: int): int

proc prevLE(s: FastSet, x: int): int
proc prevLT(s: FastSet, x: int): int

proc minValue(s: FastSet): int
proc maxValue(s: FastSet): int
~~~

候補が存在しない場合は `-1` を返します。

## 使用例

~~~nim
var s = initFastSet(100)

s.incl(3)
s.incl(20)
s.incl(64)

doAssert 20 in s
doAssert s.nextGE(4) == 20
doAssert s.prevLE(63) == 20

s.excl(20)

doAssert s.nextGE(4) == 64

for x in s:
  echo x
~~~

## 計算量

階層数を `L = O(log_64 n)` とすると、

- `insert`, `erase`: `O(L)`
- `contains`: `O(1)`
- successor / predecessor: `O(L)`
- memory: `O(n / 64)`

## 関連資料・他言語ライブラリ

- [Library Checker: Predecessor Problem](https://judge.yosupo.jp/problem/predecessor_problem)
- Nyaan Library: Fast Set
- suisen-cp Library: Fast Set
