# Segtree

[モノイド](https://ja.wikipedia.org/wiki/%E3%83%A2%E3%83%8E%E3%82%A4%E3%83%89) $(S, \cdot: S \times S \to S, e \in S)$、つまり

- 結合律: $(a \cdot b) \cdot c$ = $a \cdot (b \cdot c)$ for all $a, b, c \in S$
- 単位元の存在: $a \cdot e$ = $e \cdot a$ = $a$ for all $a \in S$

を満たす代数構造に対し使用できるデータ構造です。

長さ $N$ の $S$ の配列に対し、

- 要素の $1$ 点変更
- 区間の要素の総積の取得

を $O(\log N)$ で行うことが出来ます。詳細な要件は [Appendix](./appendix.html) を参照してください。

また、このライブラリはオラクルとして`op, e`の2種類を使用しますが、これらが定数時間で動くものと仮定したときの計算量を記述します。オラクル内部の計算量が $O(f(n))$ である場合はすべての計算量が $O(f(n))$ 倍となります。

## コンストラクタ

```nim
(1) var seg = initSegTree[S](n:int, op:(S,S)->S, e:()->S):segtree[S]
    var seg = SegTreeType(S, op:(S,S)->S, e:()->S).init(n)
    var seg = SegTree.getType(S, op:(S,S)->S, e:()->S).init(n)
(2) var seg = initSegTree[S](v:seq[S], op:(S,S)->S, e:()->S):segtree[S]
    var seg = SegTreeType(S, op:(S,S)->S, e:()->S).init(v)
    var seg = SegTree.getType(S, op:(S,S)->S, e:()->S).init(v)
```

- 型 `S`
- 二項演算 `op(a:S, b:S):S`
- 単位元 `e():S`

を定義する必要があります。例として、Range Min Queryならば

```nim
proc op(a:int, b:int):int =
    return min(a, b)

proc e():int =
    return 10^9

var seg = initSegTree[int](10, seg, e)
```

のようになります。

- (1): 長さ `n` の数列 `a` を作ります。初期値は全部`e()`です。
- (2): 長さ `n = v.len` の数列 `a` を作ります。`v` の内容が初期値となります。

詳しくは、使用例や [こちら](https://atcoder.jp/contests/practice2/editorial) も参照してください。

**@{keyword.constraints}**

- $0 \leq n \leq 10^8$

**@{keyword.complexity}**

- $O(n)$

## タイプだけ設定
```nim
  type st_type = SegTreeType[S](op:(S,S)->S, e:()->S)
```

コンストラクタは呼ばずにタイプだけ設定できます。`st_type.init(v:seq[int])`といった具合にタイプからコンストラクタを呼び出したり、`var v:seq[st_type]`といった具合にsegtreeの配列を宣言するのにお使いください。

(背景)Nimはいろいろと癖のある言語でsegtreeのobject構造体はマニアック(笑)な構造をしているので直にタイプを呼ぶのは推奨されません。上記のSegTreeTypeのテンプレートをお使いください。


## set

```nim
seg.set(p:int, x:S):void
seg[p:int] = x:S
```

`a[p]` に `x` を代入します。

**@{keyword.constraints}**

- $0 \leq p < n$

**@{keyword.complexity}**

- $O(\log n)$

## get

```nim
seg.get(p:int):S
seg[p:int]:S
```

`a[p]` を返します。

**@{keyword.constraints}**

- $0 \leq p < n$

**@{keyword.complexity}**

- $O(1)$

## prod

```nim
seg.prod(l..<r):S
seg[l..<r]:S
```

`op(a[l], ..., a[r - 1])` を、モノイドの性質を満たしていると仮定して計算します。$l = r$ のときは `e()` を返します。

**@{keyword.constraints}**

- $0 \leq l \leq r \leq n$

**@{keyword.complexity}**

- $O(\log n)$

## all_prod

```nim
seg.all_prod():S
```

`op(a[0], ..., a[n - 1])` を計算します。$n = 0$ のときは `e()` を返します。

**@{keyword.complexity}**

- $O(1)$

## max_right

```nim
(1) seg.max_right<f>(l:int):int
(2💻) seg.max_right[F](l:int, f:F):int
```

- (1): 関数 `bool f(S x)` を定義する必要があります。segtreeの上で二分探索をします。  
- (2): `S`を引数にとり`bool`を返す関数オブジェクトを渡して使用します。  

以下の条件を両方満たす `r` を(いずれか一つ)返します。

- `r = l` もしくは `f(op(a[l], a[l + 1], ..., a[r - 1])) = true`
- `r = n` もしくは `f(op(a[l], a[l + 1], ..., a[r])) = false`

`f`が単調だとすれば、`f(op(a[l], a[l + 1], ..., a[r - 1])) = true` となる最大の `r`、と解釈することが可能です。

**@{keyword.constraints}**

- `f`を同じ引数で呼んだ時、返り値は等しい(=副作用はない)
- `f(e()) = true`
- $0 \leq l \leq n$

**@{keyword.complexity}**

- $O(\log n)$

## min_left

```nim
(1) seg.min_left[f](r:int):int
(2💻) seg.min_left[F](r:int, f:F):int
```

- (1): 関数 `bool f(S x)` を定義する必要があります。segtreeの上で二分探索をします。  
- (2): `S`を引数にとり`bool`を返す関数オブジェクトを渡して使用します。  

以下の条件を両方満たす `l` を(いずれか一つ)返します。

- `l = r` もしくは `f(op(a[l], a[l + 1], ..., a[r - 1])) = true`
- `l = 0` もしくは `f(op(a[l - 1], a[l], ..., a[r - 1])) = false`

`f`が単調だとすれば、`f(op(a[l], a[l + 1], ..., a[r - 1])) = true` となる最小の `l`、と解釈することが可能です。

**@{keyword.constraints}**

- `f`を同じ引数で呼んだ時、返り値は等しい(=副作用はない)
- `f(e()) = true`
- $0 \leq r \leq n$

**@{keyword.complexity}**

- $O(\log n)$

## @{keyword.examples}

@{example.segtree_practice}
