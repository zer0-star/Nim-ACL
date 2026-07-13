# Itertools

## 概要

`itertools`はpermutation、combination、Cartesian productを
遅延列挙するutilityです。結果全体を先に構築しないため、
巨大な探索空間でも途中で`break`できます。

## import

```nim
import atcoder/extra/other/itertools
```

`chaemon_header`を`include`したコードからも利用できます。

## permutations

```nim
for value in permutations(@['a', 'b', 'c']):
  echo value

for value in permutations(@['a', 'b', 'c'], 2):
  echo value
```

入力位置に基づく辞書式順序で列挙します。
同じ値でも位置が異なれば別のpermutationです。

## combinations

```nim
for value in combinations(@[1, 2, 3, 4], 2):
  echo value
```

入力位置を昇順に選びます。

## product

```nim
for value in product(@[0, 1], repeat = 3):
  echo value
```

同じpoolを繰り返し、右端の座標が最も速く進みます。
`std/algorithm.product(openArray[seq[T]])`とも共存します。

## cartesianProduct

```nim
let pools = @[
  @["A", "K"],
  @["Q", "J"],
]

for value in cartesianProduct(pools):
  echo value
```

## Cartesian power

```nim
for digits in cartesianPower(0 .. 3, 5):
  discard digits

for digits in (0 .. 3) ^ 5:
  discard digits

for word in @['x', 'y'] ^ 3:
  discard word
```

## 境界条件

- `permutations(pool, 0)`と`combinations(pool, 0)`は空列を1件返します。
- `r < 0`または`r > pool.len`では0件です。
- `product(pool, repeat = 0)`は空列を1件返します。
- `repeat < 0`では0件です。
- poolが0個の`cartesianProduct`は空列を1件返します。
- 1つでも空のpoolがあれば0件です。
- 値の重複は除去しません。

重複除去版を追加する場合は、
`distinctPermutations`などの別APIにします。

## 遅延評価

```nim
var visited = 0

for value in product(@[0, 1], repeat = 40):
  visited.inc

  if visited == 3:
    break

doAssert visited == 3
```

## 計算量

| API | 1件あたり | 補助領域 |
|---|---:|---:|
| `permutations` | `O(r)` | `O(n + r)` |
| `combinations` | `O(r)` | `O(r)` |
| `product` | `O(repeat)` | `O(repeat)` |
| `cartesianProduct` | `O(次元数)` | `O(次元数)` |

## 旧APIとの互換性

```nim
import atcoder/extra/other/algorithmutils

permutation(pool)
combination(pool, r)
```

## 検証

- full・partial permutation
- combination
- 入力位置ベースの重複
- repeated productと複数poolの直積
- `(0 .. 3) ^ 5`
- 空積・空pool・無効値
- 早期`break`
- `std/algorithm.product`との共存
- modint累乗・`BackwardsIndex`との共存
- refc / ORC
