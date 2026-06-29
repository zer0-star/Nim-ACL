# SparseTable

Sparse Table です。

静的な列に対して、区間の最小値・最大値・GCD などを高速に取得できます。

この実装は、重なり合う2区間の値を合成して答える一般的な Sparse Table です。そのため、演算 `op` は結合的であるだけでなく、`min`, `max`, `gcd` のような冪等演算である必要があります。

## コンストラクタ

    var st = initSparseTable[T](v:seq[T], op:proc(a, b:T):T, e:proc():T)

列 `v` から Sparse Table を構築します。

`op` は区間値を合成する二項演算、`e` は空区間に対する値です。

@{keyword.constraints}

- `op` は結合的
- `op(x, x) = x` を満たす冪等演算
- `e()` は空区間に対して返したい値

@{keyword.complexity}

- $O(n \log n)$

## prod

    st.prod(p:RangeType):T

区間 `p` の値を返します。

`p` には `l..<r`, `l..r` などの range を渡せます。内部では `halfOpenEndpoints` により半開区間として扱われます。

空区間の場合は `e()` を返します。

@{keyword.constraints}

- `0 <= l <= r <= n`

@{keyword.complexity}

- $O(1)$

## get

    st[p]:T

`st.prod(p)` と同じです。

@{keyword.complexity}

- $O(1)$

## 使用例

    import atcoder/extra/structure/sparse_table

    proc mn(a, b:int):int = min(a, b)
    proc inf():int = int.high

    let st = initSparseTable[int](@[5, 2, 7, 1, 3], mn, inf)

    doAssert st[0..<5] == 1
    doAssert st[0..<3] == 2
    doAssert st[2..<3] == 7
    doAssert st[2..<2] == int.high

## 注意

この Sparse Table は任意のモノイド用ではありません。

たとえば区間和や文字列結合のように、重なった区間を二重に数えると値が変わる演算には使えません。任意のモノイドで静的区間クエリをしたい場合は Disjoint Sparse Table などが必要です。
