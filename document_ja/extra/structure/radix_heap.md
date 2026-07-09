# RadixHeap

`RadixHeap` は、整数 key 用の優先度付き queue です。

`pop` で取り出される key が単調非減少になる状況で使えます。非負整数重み Dijkstra などに向いています。

## import

~~~nim
import atcoder/extra/structure/radix_heap
~~~

## 型

~~~nim
type RadixHeap[key_t, val_t]
~~~

`key_t` は整数型です。

## コンストラクタ

~~~nim
proc initRadixHeap[key_t, val_t](): RadixHeap[key_t, val_t]
~~~

空の Radix Heap を返します。

## 操作

~~~nim
proc empty[key_t, val_t](h: RadixHeap[key_t, val_t]): bool
proc len[key_t, val_t](h: RadixHeap[key_t, val_t]): int

proc push[key_t, val_t](h: var RadixHeap[key_t, val_t], key: key_t, val: val_t)
proc pop[key_t, val_t](h: var RadixHeap[key_t, val_t]): (key_t, val_t)
~~~

- `push(h, key, val)` は `(key, val)` を追加します。
- `pop(h)` は最小 key の要素を返して削除します。

## 使用例

~~~nim
var h = initRadixHeap[int, string]()

h.push(0, "zero")
h.push(3, "three")
h.push(5, "five")

doAssert h.len == 3

let (k, v) = h.pop()

doAssert k == 0
doAssert v == "zero"
~~~

## 制約

`push` する key は、最後に `pop` した key 以上である必要があります。  
この条件を満たさない一般の priority queue としては使えません。

## 計算量

key の bit 幅を `B` とすると、おおよそ

- `push`: 償却 `O(1)`
- `pop`: 償却 `O(B)`

です。
