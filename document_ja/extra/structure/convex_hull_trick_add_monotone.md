
# ConvexHullTrickAddMonotone

傾き単調追加 Convex Hull Trick です。

一次関数 `f(x) = ax + b` を追加し、指定した `x` における最小値または最大値を求めます。

追加する直線の傾き `a` が単調である場合に使えます。

## import

    import atcoder/extra/structure/convex_hull_trick_add_monotone

## コンストラクタ

    var cht = initConvexHullTrickAddMonotone[T](isMin:bool)

`isMin = true` の場合は最小値、`isMin = false` の場合は最大値を求める CHT を作ります。

## add

    cht.add(a:T, b:T):void

直線 `f(x) = ax + b` を追加します。

追加する直線の傾き `a` は、単調非減少または単調非増加である必要があります。

@{keyword.complexity}

- ならし $O(1)$

## query

    cht.query(x:T):T

`x` における最小値または最大値を返します。

@{keyword.complexity}

- $O(\log n)$

## query_monotone_inc / query_monotone_dec

    cht.query_monotone_inc(x:T):T
    cht.query_monotone_dec(x:T):T

クエリの `x` が単調に増加する場合は `query_monotone_inc`、単調に減少する場合は `query_monotone_dec` を使えます。

@{keyword.complexity}

- ならし $O(1)$

## 使用例

    import atcoder/extra/structure/convex_hull_trick_add_monotone

    var cht = initConvexHullTrickAddMonotone[int](true)

    cht.add(0, 5)
    cht.add(1, 1)
    cht.add(2, 0)

    doAssert cht.query(0) == 0
    doAssert cht.query(3) == 5

## 注意

直線追加時の傾きが単調でない場合、このデータ構造は使えません。

`query_monotone_inc` / `query_monotone_dec` は内部の候補直線を削除しながら進むため、同じ CHT に対して通常の `query` と混ぜて使う場合は注意してください。
