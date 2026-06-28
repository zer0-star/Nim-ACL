when not declared ATCODER_TANGENT_HPP:
  const ATCODER_TANGENT_HPP* = 1
  import std/math
  import atcoder/extra/other/floatutils
  import atcoder/extra/other/internal_complex
  import atcoder/extra/geometry/geometry_template
  # http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_7_F
  # tangent of circle c through point p
  proc tangent*[Real](c1: Circle[Real], p2:Point[Real]):(Point[Real], Point[Real]) =
    return crosspoint(c1, initCircle(p2, sqrt(norm(c1.p - p2) - c1.r * c1.r)))
  
  # http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_7_G
  # common tangent of circles c1 and c2
  proc tangent*[Real](c1, c2: Circle[Real]):seq[Line[Real]] =
    result = newSeq[Line[Real]]()
    if c1.r <~ c2.r:
      result = tangent(c2, c1)
      for l in result.mitems:
        swap(l.a, l.b)
      return
    let g = norm(c1.p - c2.p)
    if g =~ 0.Real: return
    let
      u = (c2.p - c1.p) / sqrt(g)
  #    v = rotate(PI * 0.5, u)
      xx = rotate(PI * 0.5.Real, initPoint(1.Real, 0.Real))
      v = initPoint(- u.im, u.re)
    for s in [-1, 1]:
      let h = (c1.r + s.Real * c2.r) / sqrt(g)
      let d = 1.Real - h * h
      if d =~ 0.Real:
        result.add(initLine(c1.p + u * c1.r.complex, c1.p + (u + v) * c1.r.complex))
      elif d >~ 0.Real:
        let
          uu = u * h.complex
          vv = v * sqrt(1 - h * h).complex
        result.add(initLine(c1.p + (uu + vv) * c1.r.complex, c2.p - (uu + vv) * c2.r.complex * s.Real.complex))
        result.add(initLine(c1.p + (uu - vv) * c1.r.complex, c2.p - (uu - vv) * c2.r.complex * s.Real.complex))
