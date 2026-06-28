when not declared ATCODER_SQUARE_FLOOR_SUM:
  const ATCODER_SQUARE_FLOOR_SUM* = 1
  import std/math

  #【一次式の線形加重 & 平方切り捨て和】O(log(n + m + a + b))
  #
  #  S1 = Σi∈[0..n) i floor((a i + b) / m)
  #  S2 = Σi∈[0..n) floor((a i + b) / m)^2
  #  S3 = Σi∈[0..n) floor((a i + b) / m)
  # とおき，3 つ組 (S1, S2, S3) を返す．

  proc floor_sum_square*[T](n, m, a, b:T):tuple[S1, S2, S3: T] =
    # verify : https://yukicoder.me/problems/no/2362

    #【方法】
    #【一次式の切り捨て和】と同じように分母がより小さい問題への帰着を目指す．
    # ただし同じ形に帰着できるわけではないので，
    #    S1 = Σi∈[0..n) i floor((a i + b) / m)
    #    S2 = Σi∈[0..n) floor((a i + b) / m)^2
    #    S3 = Σi∈[0..n) floor((a i + b) / m) （通常の FloorSum）
    # の 3 つを並行して計算していく．

    mixin floorMod
    assert m != 0
    if n <= 0: return (T(0), T(0), T(0))
    var (a, b, m) = (a, b, m)
      
    # m < 0 の場合，分母分子を -1 倍して m > 0 とする．
    if m < 0: a *= -1; b *= -1; m *= -1

    # a を m だけ増減させた場合の影響は floor なしの和で計算できるので，0 ≦ a < m とする．
    let A = a div m - (if a mod m < 0: T(1) else: T(0))
    a = floorMod(a, m)

    # b を m だけ増減させた場合の影響は floor なしの和で計算できるので，0 ≦ b < m とする．
    let B = b div m - (if b mod m < 0: T(1) else: T(0))
    b = floorMod(b, m)

    #function<tuple<T, T, T>(T, T, T, T)> rf1, rf2;
    proc rf2(n, m, a, b:T):(T, T, T)

    # a ≧ m, b ≧ 0 用
    proc rf1(n, m, a, b:T):(T, T, T) =
      if n == 0: return (T(0), T(0), T(0))

      var
        A = a div m
        B = b div m
        n3 = n * (n - 1) * (2 * n - 1) div 6
        n2 = n * (n - 1) div 2

        s1 = A * n3 + B * n2
        s2 = A * A * n3 + 2 * A * B * n2 + B * B * n
        s3 = A * n2 + B * n

        a = a mod m
        b = b mod m
      let (ns1, ns2, ns3) = rf2(n, m, a, b)

      s1 += ns1
      s2 += ns2 + 2 * A * ns1 + 2 * B * ns3
      s3 += ns3

      return (s1, s2, s3)

    # 0 ≦ a < m, 0 ≦ b < m 用
    proc rf2(n, m, a, b:T):(T, T, T) =
      if a == 0: return (T(0), T(0), T(0))
      let
        nn = (a * n + b) div m
        nm = a
        na = m
        nb = a * n + b - m * nn
        (ns1, ns2, ns3) = rf1(nn, nm, na, nb)

        s1 = ((2 * n - 1) * ns3 - ns2) div 2
        s2 = (2 * nn - 1) * ns3 - 2 * ns1
        s3 = ns3

      return (s1, s2, s3)

    var (s1, s2, s3) = rf2(n, m, a, b)

    var
      n2 = n * (n - 1) div 2
      n3 = n * (n - 1) * (2 * n - 1) div 6

    s2 += 2 * A * s1
    s2 += 2 * B * s3
    s2 += A * A * n3
    s2 += 2 * A * B * n2
    s2 += B * B * n

    s1 += A * n3
    s1 += B * n2

    s3 += A * n2
    s3 += B * n

    return (s1, s2, s3)
