# 素因数分解

pollard_rho法による素因数分解を行います。
$O(\sqrt n)$でも間に合わない大きな数を分解しない限りは遅いと思われるので、エラトステネス法等のアルゴリズムを用いましょう

### 素数判定
```nim
isPrime(n: int):bool
```

素数かどうか判定します。

**@{keyword.complexity}**

- ??

### 素因数分解
```nim
factor(n: int):seq[(int, int)]
```

素因数分解します。

**@{keyword.complexity}**

- ??

