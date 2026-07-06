# DSU

無向グラフに対して、

- 辺の追加
- $2$ 頂点が連結かの判定

をならし $O(\alpha(n))$ 時間で処理することが出来ます。

また、内部的に各連結成分ごとに代表となる頂点を $1$ つ持っています。辺の追加により連結成分がマージされる時、新たな代表元は元の連結成分の代表元のうちどちらかになります。

## コンストラクタ

```nim
d = initDSU(n:int):DSU
```

- $n$ 頂点 $0$ 辺の無向グラフを作ります。

**@{keyword.constraints}**

- $0 \leq n \leq 10^8$

**@{keyword.complexity}**

- $O(n)$

## merge

```nim
d.merge(a:int, b:int):int
```

辺 $(a, b)$ を足します。

$a, b$ が連結だった場合はその代表元、非連結だった場合は新たな代表元を返します。

**@{keyword.constraints}**

- $0 \leq a < n$
- $0 \leq b < n$

**@{keyword.complexity}**

- ならし $O(\alpha(n))$

## same

```nim
d.same(a:int, b:int):bool
```

頂点 $a, b$ が連結かどうかを返します。

**@{keyword.constraints}**

- $0 \leq a < n$
- $0 \leq b < n$

**@{keyword.complexity}**

- ならし $O(\alpha(n))$

## leader

```nim
d.leader(a:int):int
```

頂点 $a$ の属する連結成分の代表元を返します。

**@{keyword.constraints}**

- $0 \leq a < n$

**@{keyword.complexity}**

- ならし $O(\alpha(n))$

## size

```nim
d.size(a:int):int
```

頂点 $a$ の属する連結成分のサイズを返します。

**@{keyword.constraints}**

- $0 \leq a < n$

**@{keyword.complexity}**

- ならし $O(\alpha(n))$

## groups

```nim
d.groups():seq[seq[int]]
```

グラフを連結成分に分け、その情報を返します。

返り値は「「一つの連結成分の頂点番号のリスト」のリスト」です。
(内側外側限らず)vector内でどの順番で頂点が格納されているかは未定義です。

**@{keyword.complexity}**

- $O(n)$

## @{keyword.examples}

@{example.dsu_practice}
