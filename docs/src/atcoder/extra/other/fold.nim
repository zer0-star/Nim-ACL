when not declared ATCODER_FOLD_HPP:
  const ATCODER_FOLD_HPP* = 1
  proc fold_associative*[T](v:seq[T], f:proc(a, b:T):T):T =
    if v.len == 0: return # 何もないものの積問題
    var v = v
    while v.len >= 2:
      var i = 0
      for j in countup(0, v.len - 1, 2):
        v[i] =
          if j + 1 < v.len:
            f(v[j], v[j + 1])
          else:
            v[j]
        i.inc
      v.setLen(i)
    return v[0]
  
  # v[0] + v[0]*v[1] + v[0]*v[1]*v[2] + ...
  proc fold_staircase_sum*[T](v:seq[T], sum:proc(a, b:T):T, prod:proc(a, b:T):T):T =
    proc fold_staircase_sum_sub(l, r:int):tuple[p, s:T] =
      doAssert l < r
      if l + 1 == r: return (v[l], v[l])
      let m = (l + r) shr 1
      let (pa, sa) = fold_staircase_sum_sub(l, m)
      let (pb, sb) = fold_staircase_sum_sub(m, r)
      return (prod(pa, pb), sum(sa, prod(pa, sb)))
    if v.len == 0: return # 注意
    return fold_staircase_sum_sub(0, v.len).s
