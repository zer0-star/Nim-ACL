# 約数列挙

約数を列挙したりします。基本$O(\sqrt n)$の計算量がかかります。
扱う整数$n$が100万程度と小さく、$O(n)$の計算量と空間をかけていいのであれば、エラトステネス法の利用をおすすめします。
また、さらに大きく$O(\sqrt n)$もかけられない場合はpollard ryo法をおすすめします

### 約数
```nim
divisor(n:int):seq[int]
```

約数を返します。

**@{keyword.complexity}**

- $O(\sqrt n)$

### 素因数分解
```nim
prime_factorization(n: int): seq[(int, int)]
```

素因数分解します。(素因数, 指数)の配列が返されます

### 約数列挙
```nim
divisor(f: openArray[(int, int)]):seq[int]
```

素因数分解した配列から約数の配列に変換します。渡した配列の第一引数に素数以外の数がある場合や素数が重複している場合の動作は未定義です。

```nim
divisor(f: openArray[int]):seq[int]
```

素数の配列から約数の配列に変換します。引数の素数は割れる数だけ重複させてください。
配列に素数でない数がある場合の動作は未定義です。
