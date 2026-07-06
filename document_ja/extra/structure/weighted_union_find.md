# WeightedUnionFind

重み付き Union-Find です。

通常の Union-Find と同じように集合を併合しながら、各頂点にポテンシャル（重み）を持たせ、同じ連結成分内の2頂点 `x`, `y` について

$$
\mathrm{weight}(y) - \mathrm{weight}(x)
$$

を求められます。

差分制約、座標差、距離差、累積値の整合性判定などに使えます。

## コンストラクタ

    var uf = initWeightedUnionFind[T](n:int)

長さ `n` の重み付き Union-Find を作ります。

型 `T` は重みの型です。`int`, `float`, `modint` など、加算・減算・符号反転ができる型を想定しています。

@{keyword.constraints}

- `0 <= n`
- `T` は `+`, `-`, `+=`, `-=`, `* -1` が使える型

@{keyword.complexity}

- $O(n)$

## unionSet

    uf.unionSet(x:int, y:int, w:T):bool

制約

$$
\mathrm{weight}(y) - \mathrm{weight}(x) = w
$$

を追加し、`x` と `y` が属する集合を併合します。

すでに `x` と `y` が同じ集合に属している場合は併合せず、`false` を返します。異なる集合だった場合は併合し、`true` を返します。

@{keyword.constraints}

- `0 <= x < n`
- `0 <= y < n`

@{keyword.complexity}

- ならし $O(\alpha(n))$

## same

    uf.same(x:int, y:int):bool

`x` と `y` が同じ集合に属しているかを返します。

@{keyword.constraints}

- `0 <= x < n`
- `0 <= y < n`

@{keyword.complexity}

- ならし $O(\alpha(n))$

## diff

    uf.diff(x:int, y:int):T

`x` と `y` が同じ集合に属しているとき、

$$
\mathrm{weight}(y) - \mathrm{weight}(x)
$$

を返します。

`x` と `y` が異なる集合に属している場合の値は意味を持ちません。必要なら先に `same(x, y)` を確認してください。

@{keyword.constraints}

- `0 <= x < n`
- `0 <= y < n`
- `x` と `y` は同じ集合に属している

@{keyword.complexity}

- ならし $O(\alpha(n))$

## weight

    uf.weight(x:int):T

頂点 `x` の現在のポテンシャルを返します。

ポテンシャルの絶対値そのものには任意性があります。通常は `diff(x, y)` による差分を使います。

@{keyword.constraints}

- `0 <= x < n`

@{keyword.complexity}

- ならし $O(\alpha(n))$

## root

    uf.root(x:int):int

`x` が属する集合の代表元を返します。

@{keyword.constraints}

- `0 <= x < n`

@{keyword.complexity}

- ならし $O(\alpha(n))$

## size

    uf.size(x:int):int

`x` が属する集合の大きさを返します。

@{keyword.constraints}

- `0 <= x < n`

@{keyword.complexity}

- ならし $O(\alpha(n))$

## groups

    uf.groups():seq[seq[int]]

現在の連結成分を列挙します。

返り値は、各連結成分に属する頂点番号の列です。

@{keyword.complexity}

- $O(n \alpha(n))$

## 使用例

    import atcoder/extra/structure/weighted_union_find

    var uf = initWeightedUnionFind[int](5)

    discard uf.unionSet(0, 1, 2)
    discard uf.unionSet(1, 2, 3)

    doAssert uf.same(0, 2)
    doAssert uf.diff(0, 1) == 2
    doAssert uf.diff(0, 2) == 5
    doAssert uf.diff(2, 0) == -5

    discard uf.unionSet(3, 4, -10)

    doAssert uf.diff(3, 4) == -10
    doAssert uf.size(0) == 3
    doAssert uf.size(3) == 2

## 注意

`unionSet(x, y, w)` の `w` は

$$
\mathrm{weight}(y) - \mathrm{weight}(x)
$$

を意味します。

逆向きの制約を追加したい場合は、`unionSet(y, x, -w)` とします。

同じ集合内にすでに存在する制約と矛盾するかどうかを判定したい場合は、先に `same(x, y)` を確認してから `diff(x, y)` と比較します。

    if uf.same(x, y):
      if uf.diff(x, y) != w:
        echo "inconsistent"
    else:
      discard uf.unionSet(x, y, w)
