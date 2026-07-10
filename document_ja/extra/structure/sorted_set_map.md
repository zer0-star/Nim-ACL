# sorted_set_map

`sorted_set_map` は、順序付き集合・順序付き写像を提供します。

Nim 標準の `sets` / `tables` は hash-based ですが、この module は C++ の `std::set` / `std::map` に近い、key の順序に基づく container です。

通常の順序付き set / map はこちらを推奨します。内部 backend は RedBlackTree です。RBST / SplayTree など低レベル木 backend との関係は [Tree backends](./tree_backends.html) も参照してください。

## import

~~~nim
import atcoder/extra/structure/sorted_set_map
~~~

## 型

~~~nim
type SortedSet(K, countable = false, comp = nil)
type SortedMultiSet(K, countable = false, comp = nil)
type SortedMap(K, V, countable = false, comp = nil)
type SortedMultiMap(K, V, countable = false, comp = nil)
~~~

- `SortedSet`: 重複なし集合
- `SortedMultiSet`: 重複あり集合
- `SortedMap`: key-value map
- `SortedMultiMap`: 重複 key を許す map
- `countable = true`: index access や順位取得を使う場合に指定します。
- `comp`: 比較関数です。省略時は昇順です。

## コンストラクタ

~~~nim
proc initSortedSet[K](countable = false, comp = nil): auto
proc initSortedSet[K](a: openArray[K], countable = false, comp = nil): auto

proc initSortedMultiSet[K](countable = false, comp = nil): auto
proc initSortedMultiSet[K](a: openArray[K], countable = false, comp = nil): auto

proc initSortedMap[K, V](countable = false, comp = nil): auto
proc initSortedMap[K, V](a: openArray[(K, V)], countable = false, comp = nil): auto

proc initSortedMultiMap[K, V](countable = false, comp = nil): auto
proc initSortedMultiMap[K, V](a: openArray[(K, V)], countable = false, comp = nil): auto
~~~

## 共通操作

~~~nim
proc empty(s): bool
proc len(s): int

proc insert(s: var SortedSet, key)
proc insert(s: var SortedMap, item)

proc erase(s: var SortedSet, key)
proc erase(s: var SortedMap, key)

proc contains(s, key): bool
proc find(s, key): iterator
proc lower_bound(s, key): iterator
proc upper_bound(s, key): iterator
proc begin(s): iterator
proc end(s): iterator
~~~

`key in s` / `key notin s` も使えます。

## SortedSet の使用例

<!-- nim-line-numbers -->
~~~nim
var s = initSortedSet[int](countable = true)

s.insert(3)
s.insert(1)
s.insert(4)
s.insert(1)

doAssert s.len == 3
doAssert 1 in s
doAssert 2 notin s

doAssert *s{0} == 1
doAssert *s{1} == 3
doAssert *s{2} == 4

s.erase(3)

doAssert 3 notin s
doAssert s.len == 2
~~~

## SortedMap の使用例

<!-- nim-line-numbers -->
~~~nim
var mp = initSortedMap[string, int](countable = true)

mp["three"] = 3
mp["one"] = 100
mp["one"] = 1
mp["four"] = 4

doAssert "one" in mp
doAssert "two" notin mp
doAssert mp["one"] == 1
doAssert mp["four"] == 4

var xs: seq[(string, int)] = @[]
for k, v in mp:
  xs.add((k, v))

doAssert xs == @[("four", 4), ("one", 1), ("three", 3)]
~~~

## MultiSet / MultiMap

`SortedMultiSet` と `SortedMultiMap` は重複 key を許します。

~~~nim
var s = initSortedMultiSet[int](countable = true)

s.insert(2)
s.insert(1)
s.insert(2)
s.insert(3)

doAssert 2 in s

s.erase(2)

doAssert 2 notin s
~~~

現在の `erase(key)` は、その key に等しい要素をまとめて削除します。

## custom comparator

`comp` を指定すると、順序を変えられます。

~~~nim
proc desc(a, b: int): bool = a > b

var s = initSortedSet[int](countable = true, desc)

s.insert(3)
s.insert(1)
s.insert(4)

doAssert *s{0} == 4
doAssert *s{1} == 3
doAssert *s{2} == 1
~~~

## 注意

- 通常は `sorted_set_map` を直接使うのを推奨します。
- `set_map` は互換用 alias です。
- 低レベル backend を直接使う必要がある場合は [Tree backends](./tree_backends.html) を参照してください。

## 計算量

要素数を `n` とすると、主な操作はおおよそ次の通りです。

- `insert`: `O(log n)`
- `erase`: `O(log n)`
- `find`, `lower_bound`, `upper_bound`: `O(log n)`
- index access `{i}`: `O(log n)`
