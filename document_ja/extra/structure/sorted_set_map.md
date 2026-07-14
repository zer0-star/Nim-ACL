# Sorted Set / Map

`SortedSet`、`SortedMultiSet`、`SortedMap`、`SortedMultiMap`は、
比較関数が定める順序を保つ連想コンテナです。

```nim
import atcoder/extra/structure/sorted_set_map
```

## 初期化

```nim
var sortedSet = initSortedSet[int]()
var sortedMultiSet = initSortedMultiSet[int]()

var sortedMap = initSortedMap[int, string]()
var sortedMultiMap = initSortedMultiMap[int, string]()
```

すべてのコンテナは常に部分木サイズを保持します。
追加のmode指定なしで、比較順による順位アクセス、iteratorの`index`、
iterator間の`distance`を利用できます。

過去のコードとのソース互換性のため`countable`引数も受理されますが、
公開仕様上はその値によらず順序統計が常に利用できます。
新しいコードでは指定しません。

## 基本操作

```nim
var s = initSortedSet[int]()

s.insert(30)
s.insert(10)
s.insert(20)

doAssert 20 in s
doAssert s.len == 3

s.erase(20)
doAssert 20 notin s
```

Mapでは`[]`がkeyによるvalueアクセスです。

```nim
var m = initSortedMap[int, string]()

m[20] = "twenty"
m[10] = "ten"

doAssert m[10] == "ten"
```

## 比較順による順位アクセス

順位は0-basedです。`container{index}`は、比較順で`index`番目を指す
iteratorを返します。

```nim
var s = initSortedSet[int]()

s.insert(30)
s.insert(10)
s.insert(20)

let first = s{0}
let second = s{1}
let third = s{2}

doAssert *first == 10
doAssert *second == 20
doAssert *third == 30
```

明示的な既存APIとして`kth_element(index)`も利用できます。

```nim
doAssert s.kth_element(1) == s{1}
```

前提条件は次です。

```text
0 <= index < container.len
```

Mapでは`[]`と`{}`の意味が異なります。

```nim
var m = initSortedMap[int, string]()

m[30] = "thirty"
m[10] = "ten"
m[20] = "twenty"

doAssert m[20] == "twenty"  # key 20のvalue

let it = m{1}               # 比較順で1番目のpair
doAssert *it == (20, "twenty")
```

`MultiSet`と`MultiMap`では、重複する要素もそれぞれ1個として順位を持ちます。

## `for`による反復

Set系は比較順に要素を返します。

```nim
var s = initSortedSet[int]()

s.insert(3)
s.insert(1)
s.insert(2)

for value in s:
  echo value
```

`items`を明示しても同じです。

```nim
for value in s.items:
  echo value
```

Map系はkeyとvalueを比較順に返します。

```nim
var m = initSortedMap[int, string]()

m[2] = "two"
m[1] = "one"

for key, value in m:
  echo key, ": ", value

for key, value in m.pairs:
  echo key, ": ", value
```

## iteratorの直接操作

### `begin`と`end`

```nim
var it = s.begin()

while it != s.end():
  echo *it
  it.inc
```

`end()`は終端iteratorです。`end()`をdereferenceしてはいけません。

### `find`

```nim
let it = s.find(2)

if it != s.end():
  doAssert *it == 2
```

### `lower_bound`と`upper_bound`

```nim
let first = s.lower_bound(2)
let last = s.upper_bound(2)
```

- `lower_bound(value)`は、`value`以上となる最初の位置を返します。
- `upper_bound(value)`は、`value`より大きくなる最初の位置を返します。

比較の意味はコンテナの比較関数に従います。

### `inc`と`dec`

```nim
var it = s.begin()
it.inc

var last = s.end()
last.dec
```

- `it.inc`は次の要素へ進みます。
- `it.dec`は前の要素へ戻ります。

### `index`

```nim
let it = s.find(2)

doAssert it.index == 1
doAssert s{it.index} == it
```

`index`は比較順における0-based順位です。

### `distance`

```nim
let first = s.lower_bound(1)
let last = s.upper_bound(2)

doAssert s.distance(first, last) == 2
doAssert distance(first, last) == 2
```

`distance(first, last)`は、iteratorの順位の差を返します。

## 計算量

| 操作 | 計算量 |
|---|---:|
| `insert`、`erase` | `O(log n)` |
| `find`、`lower_bound`、`upper_bound` | `O(log n)` |
| `{index}`、`kth_element(index)` | `O(log n)` |
| `iterator.index` | `O(log n)` |
| `distance` | `O(log n)` |
| 全要素の反復 | `O(n)` |
| `len` | `O(1)` |

## 互換性

`countable`を指定する古いconstructor呼び出しは引き続き受理されます。


この指定でも順序統計は利用できます。ただし新しいコードでは、
引数を省略した通常のconstructorを使用してください。

`kth_element`と`{index}`は現在の公開APIです。
`[]`／`{}`の割り当てや明示的な順位アクセス名については、
この文書更新では変更していません。
