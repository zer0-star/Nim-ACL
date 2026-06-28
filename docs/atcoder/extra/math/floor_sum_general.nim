when not declared ATCODER_FLOOR_SUM_GENERAL_HPP:
  const ATCODER_FLOOR_SUM_GENERAL_HPP* = 1
  import std/math
  
  type has_power_method = concept x, type T
    T.power(x, 10)
  
  proc monoid_pow*[Monoid, U](x: Monoid, exp: U): Monoid =
    when Monoid is has_power_method:
      return Monoid.power(x, exp)
    else:
      assert exp >= 0
      var
        res = Monoid.unit()
        x = x
        exp = exp
      while exp > 0:
        if (exp and U(1)) != U(0): res = Monoid.op(res, x)
        x = Monoid.op(x, x)
        exp = exp shr U(1)
      return res
  
  #line 3 "library/mod/floor_monoid_product.hpp"
  
  ## https://yukicoder.me/submissions/883884
  ## https://qoj.ac/contest/1411/problem/7620
  ## U は範囲内で ax+b がオーバーフローしない程度
  ## yyy x yyyy x ... yyy x yyy (x を N 個)
  ## k 個目の x までに floor(ak+b,m) 個の y がある
  ## my<=ax+b における lattice path における辺の列と見なせる
  proc floor_monoid_product*[Monoid; X, U](x, y: X, N, a, b, m:U):X =
    var
      c = (a * N + b) div m
      pre = Monoid.unit()
      suf = Monoid.unit()
      (x, y, N, a, b, m) = (x, y, N, a, b, m)
    while true:
      var
        p = a div m
        q = b div m
      a = a mod m; b = b mod m
      x = Monoid.op(x, monoid_pow(y, p))
      pre = Monoid.op(pre, monoid_pow(y, q))
      c -= (p * N + q)
      if c == 0: break
      let d = (m * c - b - 1) div a + 1
      suf = Monoid.op(y, Monoid.op(monoid_pow(x, N - d), suf));
      b = m - b - 1 + a; N = c - 1; c = d
      swap(m, a); swap(x, y)
    x = monoid_pow(x, N)
    return Monoid.op(Monoid.op(pre, x), suf)
  #line 2 "library/alg/monoid/monoid_for_floor_sum.hpp"
  # sum i^k1floor^k2: floor path で (x,y) から x 方向に進むときに x^k1y^k2 を足す
  
  type MonoidForFloorSum*[T; K1, K2: static[int]] = object
    dp: array[K1 + 1, array[K2 + 1, T]]
    dx, dy: T
  
  #struct Monoid_for_floor_sum {
  #  using ARR = array<array<T, K2 + 1>, K1 + 1>;
  #  struct Data {
  #    ARR dp;
  #    T dx, dy;
  #  };
  
  proc op*[CLASS: MonoidForFloorSum](class: typedesc[CLASS], a, b: CLASS):CLASS =
    const
      (K1, K2) = (CLASS.K1, CLASS.K2)
      n = max(K1, K2)
    type T = CLASS.T
    var
      comb {.global.}: array[n + 1, array[n + 1, T]]
      (a, b) = (a, b)
    once:
      comb[0][0] = T(1)
      for i in 0 ..< n:
        for j in 0 .. i:
          comb[i + 1][j] += comb[i][j]; comb[i + 1][j + 1] += comb[i][j]
    var
      pow_x: array[K1 + 1, T]
      pow_y: array[K2 + 1, T]
    pow_x[0] = 1; pow_y[0] = 1
    for i in 0 ..< K1: pow_x[i + 1] = pow_x[i] * a.dx
    for i in 0 ..< K2: pow_y[i + 1] = pow_y[i] * a.dy
  
    # +dy
    for i in 0 .. K1:
      for j in countdown(K2, 0):
        var x = b.dp[i][j]
        for k in j + 1 .. K2:
          b.dp[i][k] += comb[k][j] * pow_y[k - j] * x
    # +dx
    for j in 0 .. K2:
      for i in countdown(K1, 0):
        for k in i .. K1: a.dp[k][j] += comb[k][i] * pow_x[k - i] * b.dp[i][j]
  
    a.dx += b.dx; a.dy += b.dy
    return a
  
  proc unit*[CLASS: MonoidForFloorSum](class: typedesc[CLASS]): CLASS =
    result.dx = CLASS.T(0)
    result.dy = CLASS.T(0)
  
  proc to_x*[CLASS: MonoidForFloorSum](class: typedesc[CLASS]):CLASS =
    var x = CLASS.unit()
    x.dp[0][0] = 1; x.dx = 1
    return x
  
  proc to_y*[CLASS: MonoidForFloorSum](class: typedesc[CLASS]):CLASS =
    var x = CLASS.unit()
    x.dy = 1
    return x
  #  static constexpr bool commute = false # 使ってない？
  #line 5 "library/mod/floor_sum_of_linear_polynomial.hpp"
  
  # 全部非負, T は答, U は ax+b がオーバーフローしない
  proc floor_sum_of_linear_polynomial_nonnegative*[T;K1, K2: static[int]; U](N, a, b, md: U): array[K1 + 1, array[K2 + 1, T]] =
    static:
      assert U is uint
      #U is uint or U is Uint128
    assert a == 0 or N < (cast[U](-1) - b) div a
    type Mono = Monoid_for_floor_sum[T, K1, K2]
    let x = floor_monoid_product[Mono, Mono, U](Mono.to_x(), Mono.to_y(), N, a, b, md)
    return x.dp
  
  import atcoder/math
  import random
  
  # sum_{L<=x<R} x^i floor(ax+b,mod)^j
  # a+bx が I, U でオーバーフローしない
  proc floor_sum_of_linear_polynomial*[T;K1, K2: static[int];I](rg: Slice[I], a, b, md: I): array[K1 + 1, array[K2 + 1, T]] =
    static:
      assert I is int or I is Int128
    let
      L = rg.a
      R = rg.b + 1
    assert L <= R and md > 0
    if a < 0:
      var ANS = floor_sum_of_linear_polynomial[T, K1, K2, I](-R + 1 .. -L, -a, b, md)
      for i in 0 .. K1:
        if i mod 2 == 1:
          for j in 0 .. K2:
            ANS[i][j] = -ANS[i][j]
      return ANS
    assert a >= 0
    let
      ADD_X = L
      N = R - L
    var b = b
    b += a * L
    let ADD_Y = b.floorDiv(md)
    b -= ADD_Y * md
    assert a >= 0 and b >= 0
  
    type
      Mono = Monoid_for_floor_sum[T, K1, K2]
      #U = std.conditional_t<is_same_v<I, ll>, u64, u128>;
      #U = uint
    var
      A = floor_monoid_product[Mono, Mono, I](Mono.to_x(), Mono.to_y(), N, a, b, md)
      offset = Mono.unit()
    offset.dx = T(ADD_X); offset.dy = T(ADD_Y)
    A = Mono.op(offset, A)
    return A.dp
