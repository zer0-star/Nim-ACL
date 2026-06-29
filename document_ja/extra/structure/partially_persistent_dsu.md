# PartiallyPersistentDSU

部分永続 Union-Find です。

時刻 `t` を指定して、その時点での連結成分の代表元やサイズを取得できます。

`merge(t, x, y)` により時刻 `t` で辺を追加し、過去の時刻に対する `leader(t, x)` や `size(t, x)` を問い合わせられます。

## コンストラクタ

    var uf = initPartiallyPersistentDSU(n:int)

長さ `n` の部分永続 Union-Find を作ります。

初期時刻では、各頂点はそれぞれ単独の連結成分です。

@{keyword.constraints}

- `0 <= n`

@{keyword.complexity}

- $O(n)$

## merge

    uf.merge(t:int, x:int, y:int):bool

時刻 `t` で `x` と `y` の属する集合を併合します。

すでに同じ集合に属している場合は `false` を返します。異なる集合だった場合は併合して `true` を返します。

@{keyword.constraints}

- `0 <= x < n`
- `0 <= y < n`
- `t` は時刻
- 通常は `merge` を呼ぶ時刻は単調増加にします

@{keyword.complexity}

- $O(\log n)$ 程度

## leader

    uf.leader(t:int, x:int):int

時刻 `t` における `x` の代表元を返します。

@{keyword.constraints}

- `0 <= x < n`

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

    var uf = initPartiallyPersistentDSU(4)

    doAssert uf.size(-1, 0) == 1

    discard uf.merge(0, 0, 1)
    discard uf.merge(1, 1, 2)

    doAssert uf.leader(0, 0) == uf.leader(0, 1)
    doAssert uf.size(0, 0) == 2

    doAssert uf.size(0, 2) == 1
    doAssert uf.size(1, 2) == 3

## 注意

`merge` に渡す時刻は、基本的に単調増加で使います。

完全永続ではなく部分永続なので、過去の状態に対して新たな分岐を作る用途には向きません。
