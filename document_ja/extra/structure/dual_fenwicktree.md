
# DualFenwickTree

Dual Fenwick Tree です。

通常の Fenwick Tree が「点加算・区間和取得」を扱うのに対し、Dual Fenwick Tree は「区間加算・点取得」を扱います。

長さ `n` の列 `a` に対して、区間に値 `x` を加算し、各点 `p` の現在値を取得できます。

## import

    import atcoder/extra/structure/dual_fenwicktree

## コンストラクタ

    var fw = initDualFenwickTree[T](n:int)

長さ `n` の Dual Fenwick Tree を作ります。

型 `T` は加算・減算ができる整数型を想定しています。

@{keyword.constraints}

- `0 <= n`

@{keyword.complexity}

- $O(n)$

## add

    fw.add(p:RangeType, x:T):void

区間 `p` に `x` を加算します。

`p` には `l..<r` と `l..r` のどちらも渡せます。内部では `halfOpenEndpoints` により半開区間 `l..<r` に変換して扱います。

@{keyword.constraints}

- `0 <= l <= r <= n`

@{keyword.complexity}

- $O(\log n)$

## 点取得

    fw[p]:T

点 `p` の現在値を返します。

@{keyword.constraints}

- `0 <= p < n`

@{keyword.complexity}

- $O(\log n)$

## 使用例

    import atcoder/extra/structure/dual_fenwicktree

    var fw = initDualFenwickTree[int](6)

    fw.add(1..<4, 10)
    fw.add(2..5, -3)
    fw.add(0..0, 7)
    fw.add(3..<6, 2)

    doAssert fw[0] == 7
    doAssert fw[1] == 10
    doAssert fw[2] == 7
    doAssert fw[3] == 9
    doAssert fw[4] == -1
    doAssert fw[5] == -1

## 注意

このライブラリは「区間更新・点取得」専用です。

区間和を取得したい場合は通常の `FenwickTree` や `LazySegTree` を使ってください。
