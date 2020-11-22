when not declared ATCODER_CLOSEST_PAIR_HPP:
  const ATCODER_CLOSEST_PAIR_HPP* = 1
  import atcoder/extra/other/internal_complex
  import atcoder/extra/other/floatutils
  import atcoder/extra/geometry/geometry_template

  proc inplace_merge*[T](v: var seq[T], left, mid, right: int, cmp:proc(a,b:T):bool) =
    let
      v1 = v[left..<mid]
      v2 = v[mid..<right]
    var
      vi = left
      i, j = 0
    while vi < right:
      var is_v1: bool
      if i == v1.len: is_v1 = false
      elif j == v2.len: is_v1 = true
      else:
        if cmp(v2[j], v1[i]): is_v1 = false
        else: is_v1 = true
      if is_v1: v[vi] = v1[i];vi.inc;i.inc
      else: v[vi] = v2[j];vi.inc;j.inc
  
  # http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_5_A
  proc closest_pair*[Real](ps: seq[Point[Real]]):Real =
  #  if ps.len <= 1: throw (0)
    if ps.len <= 1: assert(false)
    var ps = ps
    ps.sort(cmp[Point[Real]])
  
    proc compare_y(a, b:Point[Real]):bool =
      return a.im <~ b.im
  
    var beet = newSeq[Point[Real]](ps.len)
    let INF = 1e+100
  
    proc rec(left, right:int):Real =
      if right - left <= 1: return INF
      let mid = (left + right) shr 1
      let x = ps[mid].re
      result = min(rec(left, mid), rec(mid, right))
      # TODO
  #    inplace_merge(begin(ps) + left, begin(ps) + mid, begin(ps) + right, compare_y);
      ps.inplace_merge(left, mid, right, compare_y)
      var p = 0;
      for i in left..<right:
        if abs(ps[i].re - x) >=~ result: continue
        for j in 0..<p:
          let luz = ps[i] - beet[p - j - 1]
          if luz.im >=~ result: break
          result = min(result, abs(luz))
        beet[p] = ps[i];
        p += 1
    return rec(0, ps.len)
  # }}}
