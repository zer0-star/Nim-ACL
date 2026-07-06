
# RadixHeap

整数キー用の Radix Heap です。

`key` が単調非減少に取り出される状況で使える優先度付きキューです。Dijkstra 法などで、辺重みが非負整数である場合に利用できます。

通常のヒープと同様に `(key, value)` を追加し、最小の `key` を持つ要素を取り出します。

## import

    import atcoder/extra/structure/radix_heap

## コンストラクタ

    var heap = initRadixHeap[key_t, val_t]()

空の Radix Heap を作ります。

`key_t` は整数型、`val_t` は格納する値の型です。`key_t` は signed / unsigned の両方を想定しています。

@{keyword.constraints}

- `key_t` は整数型

@{keyword.complexity}

- $O(1)$

## push

    heap.push(key:key_t, val:val_t):void

`(key, val)` を追加します。

Radix Heap の性質上、追加する `key` は、これまでに `pop` されたキーの最大値以上である必要があります。

@{keyword.constraints}

- `key >= last`
- `last` はこれまでに取り出されたキーの最大値

@{keyword.complexity}

- ならし $O(1)$

## pop

    heap.pop():(key_t, val_t)

最小の `key` を持つ要素を取り出します。

@{keyword.constraints}

- `heap` は空でない

@{keyword.complexity}

- ならし $O(\log C)$
- `C` はキーの値域

## empty

    heap.empty():bool

空かどうかを返します。

@{keyword.complexity}

- $O(1)$

## len

    heap.len():int

要素数を返します。

@{keyword.complexity}

- $O(1)$

## 使用例

    import atcoder/extra/structure/radix_heap

    var heap = initRadixHeap[int, string]()

    heap.push(-5, "a")
    heap.push(-2, "b")
    heap.push(0, "c")

    doAssert heap.pop() == (-5, "a")

    heap.push(-4, "d")

    doAssert heap.pop() == (-4, "d")
    doAssert heap.pop() == (-2, "b")
    doAssert heap.pop() == (0, "c")
    doAssert heap.empty()

## 注意

`push` するキーは、最後に `pop` されたキー以上である必要があります。

この条件を満たさない場合は Radix Heap の前提が壊れます。一般の優先度付きキューとして使いたい場合は通常の heap を使ってください。
