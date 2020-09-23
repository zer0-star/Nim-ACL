# Modint

自動でmodを取る構造体です。AC Libraryはmodintを使わなくとも全アルゴリズムが使えるように整備しているので、必ずしもこのファイルの内容を把握する必要はありません。

多くの問題では `modint998244353`, `modint1000000007`, `modint` のどれかを使えば十分で、以下のように使えます。

```nim
import atcoder/header
import atcoder/modint

type mint = modint998244353

# print sum of array (mod 998244353)
let n = nextInt()
var sum = mint(0)
for i in 0..<n:
  sum += nextInt()
echo sum.val()
```

modがfixedでない場合は、`modint` を使用し以下のように書けます。

```nim
import atcoder/header
import atcoder/modint as modint_lib

type mint = modint

# print sum of array (input mod)
let n, M = nextInt()
mint.set_mod(M)
var sum = mint(0)
for i in 0..<n:
  sum += nextInt()
echo sum.val()

```

以下の関数らは、`set_mod` を除き $3$ つともに対して動きます。

## コンストラクタ

```nim
(1) x = modint()
(2) x = modint[T](y:T)
```

- (1) modintのデフォルトコンストラクタです。$0$ が格納されます。
- (2) 整数型 `T`(`int, char, ull, bool, ...`) に対するコンストラクタです。`y` のmodを取ってmodintに格納します。

## set_mod

```nim
set_mod(m:int):void
```

modを設定します。最初に呼んでください。

**@{keyword.constraints}**

- $1 \leq m \leq 2 \times 10^9 + 1000$

**@{keyword.complexity}**

- $O(1)$

## mod

```nim
modint.mod():int
```

modを返します。

## val

```nim
x.val():int
```

`x`に格納されている値を返します。

## 各種演算

```nim
-modint

modint.inc
modint.dec

modint + modint
modint - modint
modint * modint
modint / modint

modint += modint
modint -= modint
modint *= modint
modint /= modint

modint == modint
modint != modint
```

が動きます。

```nim
modint x = 10;
1 + x;
```

も(`modint(1) + x`と自動で解釈されるので)動きます。

```cpp
modint.set_mod(11)
var y = modint(10)
var z = 1234
y * z
```

も`y * modint(z)`と解釈され、動きます。

**@{keyword.constraints}**

- `a / b`(or `a /= b`)を行なう時、`gcd(b.val(), mod) == 1`

**@{keyword.complexity}**

- $O(1)$ (割り算以外)
- $O(\log \mathrm{mod})$ (割り算)

## pow

```nim
x.pow(ll n):modint
```

$x^n$ を返します。

**@{keyword.constraints}**

- $0 \le n$

**@{keyword.complexity}**

- $O(\log n)$

## inv

```nim
x.inv():modint
```

$xy \equiv 1$ なる $y$ を返します。

**@{keyword.constraints}**

- `gcd(x.val(), mod) = 1`

**@{keyword.complexity}**

- $O(\log \mathrm{mod})$

## raw

```nim
modint.raw(int x):modint
```

`x`に対してmodを取らずに、`modint(x)`を返す。

定数倍高速化のための関数です。

上で述べたように

```nim
var a:modint
var i:int
a += i
```

は、`i`がmod以上でも動きます。勝手に`i`に対してmodを取るためです。

ですが、たとえば以下のようなコードでは、`i`がmodを超えないことを保証できます。

```nim
modint::set_mod(1000000007)
var a = modint(1)
for i in 1..< 100000:
    a += i
```

このような時に、

```nim
modint::set_mod(1000000007)
var a = modint(1)
for i in 1..< 100000:
  a += modint.raw(i)
```

と書くと、modの回数を減らすことが出来ます。

当然ながら`modint::raw(x)`にmod以上の値を入れたときの挙動は未定義です。

**@{keyword.constraints}**

- $0 \leq x \lt \mathrm{mod}$

## Tips(other mod)

問題文で他のmod (例: `1000000009`) が与えられる場合、以下のように書けます

```nim
type mint = StaticModInt[1000000009]
```

`modint998244353`, `modint1000000007` は、`static_modint<998244353>`, `static_modint<1000000007>`のエイリアスになっています。

```nim
type modint998244353 = StaticModInt[998244353]
type modint1000000007 = StaticModInt[1000000007]
```

## Tips(複数mod)

複数種類modを使用したい場合以下のようにできます

```nim
type mint0 = DynamicModInt[0]
type mint1 = DynamicModInt[1]
```

`modint`は、`DynamicModInt[-1]`のエイリアスになっています。

```cpp
type modint = DynamicModInt[-1]
```

## @{keyword.examples}

@{example.modint_usage}
