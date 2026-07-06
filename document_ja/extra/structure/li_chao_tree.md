
# LiChaoTree

Li Chao Tree です。

一次関数 `f(x) = ax + b` を追加し、あらかじめ与えた座標 `x_i` 上での最小値を高速に問い合わせます。

この実装は座標圧縮型です。クエリで使う `x` 座標列を最初に渡しておき、`query(k)` ではその `k` 番目の座標における最小値を返します。

## import

    import atcoder/extra/structure/li_chao_tree

## コンストラクタ

    var cht = initLiChaoTree[T](xs:seq[T], inf_val:T)

座標列 `xs` 上でクエリを行う Li Chao Tree を構築します。

`inf_val` は十分大きい値です。

@{keyword.constraints}

- `xs.len > 0`
- `inf_val` は答えとして現れない十分大きい値

@{keyword.complexity}

- $O(n)$

## update

    cht.update(a:T, b:T):void
    cht.update(a:T, b:T, s:Slice[int]):void

直線 `f(x) = ax + b` を追加します。

`Slice[int]` を指定した場合は、座標 index の範囲 `s` にだけ線分として追加します。

@{keyword.complexity}

- 全体追加 $O(\log n)$
- 区間追加 $O(\log^2 n)$

## query

    cht.query(k:int):T

`xs[k]` における最小値を返します。

@{keyword.constraints}

- `0 <= k < xs.len`

@{keyword.complexity}

- $O(\log n)$

## 使用例

    import atcoder/extra/structure/li_chao_tree

    const INF = int.high div 4
    var cht = initLiChaoTree[int](@[0, 1, 2, 3, 4, 5], INF)

    cht.update(2, 3)    # 2x + 3
    cht.update(-1, 10)  # -x + 10
    cht.update(0, 7)    # 7

    for i in 0..5:
      let x = i
      let expected = min(min(2 * x + 3, -x + 10), 7)
      doAssert cht.query(i) == expected

## 注意

この実装は最小値クエリ用です。最大値を求めたい場合は、直線と答えの符号を反転して使います。

`query` の引数は座標値そのものではなく、コンストラクタに渡した `xs` の index です。
