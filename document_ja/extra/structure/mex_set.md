# MexSet

`MexSet` は、整数 multiset の mex を動的に管理します。

mex は、集合に含まれない最小の非負整数です。

例えば、

```text
{0, 1, 3, 4}
```

の mex は `2` です。

## 使いどころ

- 数列の mex を更新しながら求める
- 値の追加・削除がある mex query
- game / Grundy number
- permutation や frequency 管理
- AtCoder ABC / Codeforces の mex 問題

## 考え方

`0 .. limit+1` のうち、現在存在しない値だけを `FastSet` に入れておきます。

- 初めて `x` が追加されたら missing set から削除
- 最後の `x` が削除されたら missing set に戻す
- missing set の最小値が mex

重複を扱うために各値の個数も保持します。

## import

~~~nim
import atcoder/extra/structure/mex_set
~~~

## API

~~~nim
proc initMexSet(limit: int): MexSet
proc initMexSet(limit: int, values: openArray[int]): MexSet

proc insert(s: var MexSet, x: int): bool
proc erase(s: var MexSet, x: int): bool

proc count(s: MexSet, x: int): int
proc contains(s: MexSet, x: int): bool
proc mex(s: MexSet): int
proc clear(s: var MexSet)
~~~

`limit` は、mex として扱いたい最大範囲を決めます。結果は `0 .. limit+1` です。

範囲外の値は mex に影響しないため無視されます。

## 使用例

~~~nim
var s = initMexSet(10)

s.incl(0)
s.incl(1)
s.incl(3)

doAssert s.mex == 2

s.incl(2)

doAssert s.mex == 4

s.excl(1)

doAssert s.mex == 1
~~~

multiset として重複も扱います。

~~~nim
discard s.insert(0)
discard s.insert(0)

doAssert s.count(0) == 2

discard s.erase(0)

doAssert s.count(0) == 1
~~~

## 計算量

`FastSet` の階層数を `L = O(log_64 limit)` とすると、

- insert / erase: `O(L)`
- mex: `O(L)`
- count / contains: `O(1)`
- memory: `O(limit)`

## 注意

`limit` は想定される mex 以上にしてください。

長さ `n` の配列の mex は高々 `n` なので、通常は `limit = n` で十分です。

## 関連資料

- AtCoder ABC の mex 問題
- Codeforces の dynamic mex 問題
- `FastSet`
