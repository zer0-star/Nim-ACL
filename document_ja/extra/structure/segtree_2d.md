
# SegTree2D

二次元セグメント木です。

あらかじめ現れる点 `(x, y)` をすべて与えておき、その点に対する加算と、矩形範囲の集約値取得を行います。

座標は圧縮されるため、座標値そのものは大きくても構いません。

## import

    import atcoder/extra/structure/segtree_2d

## コンストラクタ

    var st = initSegTree2D[S](points, op, e)

`points` に現れる点だけを対象にした二次元セグメント木を構築します。

`op` は値を合成する演算、`e` は単位元です。

@{keyword.constraints}

- `points` は更新または取得する可能性のある点をすべて含む
- `op` は結合的
- `e()` は `op` の単位元

@{keyword.complexity}

- 構築 $O(n \log n)$

## add

    st.add(x:int, y:int, v:S):void

点 `(x, y)` に値 `v` を加算、より正確には現在値に `op(current, v)` を適用します。

@{keyword.constraints}

- `(x, y)` はコンストラクタに渡した `points` に含まれる

@{keyword.complexity}

- $O(\log^2 n)$

## get

    st.get(x:int, y:int):S
    st[x, y]:S

点 `(x, y)` の現在値を返します。

@{keyword.constraints}

- `(x, y)` はコンストラクタに渡した `points` に含まれる

@{keyword.complexity}

- $O(\log n)$

## prod

    st.prod(xp, yp):S
    st[xp, yp]:S

矩形範囲 `xp × yp` に含まれる点の値を集約して返します。

`xp`, `yp` には `Slice[int]` または `int` を渡せます。`int` を渡した場合は一点だけを表します。

@{keyword.complexity}

- $O(\log^2 n)$

## 使用例

    import atcoder/extra/structure/segtree_2d

    proc op(a, b:int):int = a + b
    proc e():int = 0

    var st = initSegTree2D[int](@[
      (x: 0, y: 0),
      (x: 0, y: 1),
      (x: 1, y: 0),
      (x: 2, y: 2),
    ], op, e)

    st.add(0, 0, 5)
    st.add(0, 0, 7)
    st.add(0, 1, 3)
    st.add(1, 0, 11)
    st.add(2, 2, 13)

    doAssert st.get(0, 0) == 12
    doAssert st.prod(0..2, 0..2) == 39

## 注意

コンストラクタに渡していない点には更新できません。

矩形クエリは、座標値の範囲で指定します。内部の圧縮 index ではなく、元の `x`, `y` の値を使います。
