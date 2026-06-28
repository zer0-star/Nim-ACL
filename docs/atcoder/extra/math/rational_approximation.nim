when not declared ATCODER_RATIONAL_APPROXIMATION_HPP:
  const ATCODER_RATIONAL_APPROXIMATION_HPP* = 1
  # https://hitonanode.github.io/cplib-cpp/number/rational_approximation.hpp
  
  # Rational approximation based on Stern–Brocot tree
  # Input: N > 0, num >= 0, den >= 0 (num > 0 or den > 0)
  # return {{p, q}, {r, s}} where p/q <= num/den <= r/s. Strictly,
  # - p/q = max(n / d | n / d <= num / den, 0 <= n <= N, 1 <= d <= N)
  # - r/s = min(n / d | num / den <= n / d, 0 <= n <= N, 1 <= d <= N)
  
  proc rational_approximation*[T](N, num, den: T): ((T, T), (T, T)) =
    assert N >= 1
    assert num >= 0
    assert den >= 0
    assert num > 0 or den > 0
    if num == T(0): return ((T(0), T(1)), (T(0), T(1))) # 0
    if den == T(0): return ((T(1), T(0)), (T(1), T(0))) # inf
  
    # p/q <= num/den <= r/s
    var
      p = T(0)
      q = T(1)
      r = T(1)
      s = T(0)
      num = num
      den = den
  
    var is_left = false
    while true:
      var max_steps = num div den
  
      if is_left:
        # r + steps * p <= N
        # s + steps * q <= N
  
        if p > T(0): max_steps = min(max_steps, (N - r) div p)
        max_steps = min(max_steps, (N - s) div q)
  
        r += max_steps * p
        s += max_steps * q
      else:
        # p + steps * r <= N
        # q + steps * s <= N
  
        max_steps = min(max_steps, (N - p) div r)
        if s > T(0): max_steps = min(max_steps, (N - q) div s)
  
        p += max_steps * r
        q += max_steps * s
  
      if is_left and max_steps == 0:
        break
  
      num -= max_steps * den
  
      if num == T(0):
        if is_left:
          return ((r, s), (r, s))
        else:
          return ((p, q), (p, q))
  
      swap num, den
      is_left = not is_left
  
    return ((p, q), (r, s))
