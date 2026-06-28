# 全方位木DP

木に対して、全方位木DPを行います。全方位DPについては例えば[https://algo-logic.info/tree-dp/]をご覧ください。

## データ構造の作成

```nim
(1) var a = initRerooting[T, Weight](N:int, f:proc(a:T, c:int, w:Weight), merge:proc(a, b:T):T, mi:T, g:proc(a:T, v:int):T)
(2) var a = initRerooting[T](N:int, f:proc(a:T, c:int), merge:proc(a, b:T):T, mi:T, g:proc(a:T, v:int):T)
(3) var a = initRerooting[T, Weight](N:int, f:proc(a:T, c:int, w:Weight), merge:proc(a, b:T):T, mi:T)
```

全方位木DPによるデータ構造を作ります。ノード数が$N$, 各ノードに$T$型のデータを持ち、各辺には$Weight$型のデータを持ちます。
頂点$v$とその子$c$について、まず$c$のデータを$f$で加工します。```f(a:T, c:int, w:Weight)```の形で指定できて、$a$が$c$のデータ、$w$が$c\to v$を結ぶ辺の$Weight$で、それに対応するようなprocを指定してください。
$v$の各子$c$について加工した結果を$merge$関数でマージします。この関数は結合的である必要があります。最後にマージ結果を$g$で加工して、その結果が$v$に格納されます。つまり、各頂点$v$のデータを$T_v$, $v$の子を$c_1, c_2, \ldots, c_k$として$c_i$から$v$への辺の重みを$w_{c_i}$とすると、
$$
T_v = g(merge(f(T_{c_1}, {c_1}, w_{c_1}), f(T_{c_2}, {c_2}, w_{c_2}), \ldots, f(T_{c_k}, {c_k}, w_{c_k})), v)
$$
といった計算がされます。

(2)のように重みを使わない場合は省略可能で、(3)のようにgも省略可能です(省略した場合は$g(a, v) = v$)。


**@{keyword.constraints}**

- merge関数は結合則が成り立つ。つまり、3つ以上あるデータをどの順番でマージしても結果が同じである

## 辺の追加
```nim
(1) a.addEdge(u, v:int)
(2) a.addEdge(u, v:int, w:Weight)
(3) a.addEdge(u, v:int, w_1, w_2:Weight)
```

$u$と$v$の間に双方向の辺を張ります。(2)のように重みを指定したり、(3)のように向きによって重みを変えることもできます。
(3)の場合、$u$から$v$への辺の重みが$w_1$, $v$から$u$への辺の重みが$w_2$です。

必ず木になるように追加してください。多重辺やループがある場合の動作は未定義です。

**@{keyword.constraints}**

- 追加は木になるように行わなければならない


## 計算
```nim
a.solve()
```

**@{keyword.complexity}**

- $O(N)$

## 結果の取得
```nim
a[u:int]:T
```

ノード$u$での結果を取得します。つまり、もとの木において$u$を根として上記の計算をすべての頂点で行った場合に$u$に格納されるデータを返します。

- $O(d)$ ($d$は$u$と隣接する辺の本数)

## @{keyword.examples}

@{example.rerooting_practice}
