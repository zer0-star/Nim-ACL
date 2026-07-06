
# PartiallyPersistentDSU

部分永続 Union-Find です。

時刻 `t` を指定して、その時点での連結成分の代表元、連結判定、連結成分サイズを取得できます。

`merge(t, x, y)` により時刻 `t` で辺を追加し、過去の時刻に対する `leader(t, x)`, `same(t, x, y)`, `size(t, x)` を問い合わせられます。

## import

    import atcoder/extra/structure/partially_persistent_dsu

## コンストラクタ

    var uf = initPartiallyPersistentDSU(n:int)

長さ `n` の部分永続 Union-Find を作ります。

初期状態では、各頂点はそれぞれ単独の連結成分です。

@{keyword.constraints}

- `0 <= n`

@{keyword.complexity}

- $O(n)$

## merge

    uf.merge(t:int, x:int, y:int):bool

時刻 `t` で `x` と `y` の属する集合を併合します。

すでに同じ集合に属している場合は `false` を返します。異なる集合だった場合は併合して `true` を返します。

時刻 `t` は merge 回数である必要はなく、任意の整数時刻を使えます。ただし、部分永続 Union-Find として履歴を一方向に追加するため、`merge` に渡す時刻は単調非減少である必要があります。

@{keyword.constraints}

- `0 <= x < n`
- `0 <= y < n`
- `merge` に渡す `t` は単調非減少

@{keyword.complexity}

- $O(\log n)$ 程度

## leader

    uf.leader(t:int, x:int):int

時刻 `t` における `x` の代表元を返します。

@{keyword.constraints}

- `0 <= x < n`

@{keyword.complexity}

- $O(\log n)$ 程度

## same

    uf.same(t:int, x:int, y:int):bool

時刻 `t` において `x` と `y` が同じ連結成分に属するかを返します。

@{keyword.constraints}

- `0 <= x < n`
- `0 <= y < n`

@{keyword.complexity}

- $O(\log n)$ 程度

## size

    uf.size(t:int, x:int):int

時刻 `t` における、`x` が属する連結成分の大きさを返します。

@{keyword.constraints}

- `0 <= x < n`

@{keyword.complexity}

- $O(\log n)$

## 使用例

    import atcoder/extra/structure/partially_persistent_dsu

    var uf = initPartiallyPersistentDSU(5)

    doAssert uf.size(-100, 0) == 1

    discard uf.merge(10, 0, 1)
    discard uf.merge(20, 1, 2)
    discard uf.merge(20, 3, 4)

    doAssert uf.same(10, 0, 1)
    doAssert uf.size(10, 0) == 2

    doAssert uf.same(20, 0, 2)
    doAssert uf.size(20, 2) == 3

    doAssert not uf.same(20, 0, 4)

    discard uf.merge(100, 2, 4)

    doAssert not uf.same(99, 0, 4)
    doAssert uf.same(100, 0, 4)
    doAssert uf.size(100, 0) == 5

## 注意

これは完全永続ではなく部分永続 Union-Find です。

過去の状態に対して新しい分岐を作る用途には向きません。履歴を追加する `merge` は、時刻の単調非減少順に呼んでください。
