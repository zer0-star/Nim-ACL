# 2-SAT

2-SATを解きます。
変数 $x_0, x_1, \cdots, x_{N - 1}$ に関して、

- $(x_i = f) \lor (x_j = g)$

というクローズを足し、これをすべて満たす変数の割当があるかを解きます。

## コンストラクタ

```nim
ts = initTwoSat(n:int):TwoSat
```

$n$ 変数の2-SATを作ります。

**@{keyword.constraints}**

- $0 \leq n \leq 10^8$

**@{keyword.complexity}**

- $O(n)$

## add_clause

```nim
ts.add_clause(i:int, f:bool, j:int, g:bool):void
```

$(x_i = f) \lor (x_j = g)$ というクローズを足します。

**@{keyword.constraints}**

- $0 \leq i \lt n$
- $0 \leq j \lt n$

**@{keyword.complexity}**

- ならし $O(1)$

## satisfiable

```nim
ts.satisfiable():bool
```

条件を足す割当が存在するかどうかを判定する。割当が存在するならば`true`、そうでないなら`false`を返す。

**@{keyword.constraints}**

- 複数回呼ぶことも可能。

**@{keyword.complexity}**

足した制約の個数を $m$ として

- $O(n + m)$

## answer

```nim
ts.answer():seq[bool]
```

最後に呼んだ `satisfiable` の、クローズを満たす割当を返す。`satisfiable` を呼ぶ前や、`satisfiable` で割当が存在しなかったときにこの関数を呼ぶと、中身が未定義の長さ $n$ の vectorを返す。

**@{keyword.complexity}**

- $O(n)$

## @{keyword.examples}

@{example.twosat_practice}
