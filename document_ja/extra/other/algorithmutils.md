# Algorithm utilities

## 概要

`algorithmutils`は旧来の総合algorithm utilityです。
singularな`permutation`・`combination`は互換APIとして維持し、
canonicalな実装を`itertools`へ委譲します。

## import

```nim
import atcoder/extra/other/algorithmutils
```

## permutationとcombination

```nim
for value in permutation(@[1, 2, 3]):
  discard value

for value in combination(@[1, 2, 3], 2):
  discard value
```

## nth_element

```nim
var values = @[5, 1, 4, 2, 3]

values.nth_element(2)

doAssert values[2] == 3
```

custom comparatorと部分区間版も利用できます。

```nim
values.nth_element(nth, comparator)
values.nth_element(first, nth, last)
values.nth_element(first, nth, last, comparator)
```

## copyとreverse

```nim
copy(source, slice, destination, destinationStart)
reverse(sequence, slice)
```

## setUnion

昇順の2列の和集合を返します。

## 境界条件

- `combination(pool, r)`は`r < 0`または`r > len`で0件です。
- `combination(pool, 0)`は空列を1件返します。
- iteratorは入力位置を区別します。
- `nth_element`の`last`はexclusiveです。
- `setUnion`の入力は昇順である必要があります。

## 計算量

| API | 計算量 |
|---|---:|
| `permutation` | 出力件数 × `O(n)` |
| `combination` | 出力件数 × `O(r)` |
| `nth_element` | 平均的に線形時間 |
| `setUnion` | `O(len(u) + len(v))` |

## 関連

- `atcoder/extra/other/itertools`
- `std/algorithm`

## 検証

- singular iterator互換性
- 非`int`要素型
- 無効な`r`
- default・custom comparator
- 部分区間`nth_element`
- 既存direct importer
- refc / ORC
