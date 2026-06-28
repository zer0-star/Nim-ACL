when not declared ATCODER_POLYGON_HPP:
  const ATCODER_POLYGON_HPP* = 1
  import std/sugar, std/algorithm, std/math
  import atcoder/extra/other/floatutils
  import atcoder/extra/other/internal_complex
  import atcoder/extra/geometry/geometry_template

  type Polygon*[Real] = seq[Point[Real]]
  
  # convex polygon {{{
  # http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_3_B
  proc isConvex*[Real](p:Polygon[Real]):bool =
    let n = p.len
    for i in 0..<n:
      if ccw(p[(i + n - 1) mod n], p[i], p[(i + 1) mod n]) == CCWState.CLOCKWISE: return false
    return true
  
  # http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_4_A
  proc convexHull*[Real](p:Polygon[Real], strict = false): Polygon[Real] =
    let n = p.len
    var eps_cmp =
      if strict: (a:Real) => a <=~ 0.Real
      else: (a:Real) => a <~ 0.Real
  #  let eps = if strict: EPS else: -EPS
    var
      k = 0
      p = p
    if n <= 2: return p
    p.sort do (a, b:Point[Real])->int:
      if a <~ b: -1
      elif b <~ a: 1
      else: 0
    var
      ch = newSeq[Point[Real]](2 * n)
      i = 0
    while i < n:
      while k >= 2 and cross(ch[k - 1] - ch[k - 2], p[i] - ch[k - 1]).eps_cmp: k.dec
      ch[k] = p[i]
      k.inc;i.inc
    i = n - 2
    let t = k + 1
    while i >= 0:
      while k >= t and cross(ch[k - 1] - ch[k - 2], p[i] - ch[k - 1]).eps_cmp: k.dec
      ch[k] = p[i]
      k.inc;i.dec
    ch.setLen(k - 1)
    return ch
  
  # http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_4_C
  # cut with a straight line l and return a convex polygon on the left
  proc convex_cut*[Real](U: Polygon[Real], l:Line[Real]):Polygon[Real] =
    result = newSeq[Point[Real]]()
    for i in 0..<U.len:
      let
        now = U[i]
        nxt = U[(i + 1) mod U.len]
      if ccw(l.a, l.b, now) != CCWState.CLOCKWISE: result.add(now)
      if ccw(l.a, l.b, now).int * ccw(l.a, l.b, nxt).int < 0:
        result.add(crosspoint(initLine(now, nxt), l))
  
  # http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_4_B
  proc convex_diameter*[Real](p: Polygon[Real]):Real =
    let N = p.len
    var
      it = 0
      jt = 0
    for i in 1..<N:
      if p[i].im >~ p[it].im: it = i
      if p[i].im <~ p[jt].im: jt = i
    var maxdis = norm(p[it] - p[jt])
  
    var
      i, maxi = it
      j, maxj = jt
    while true:
      if cross(p[(i + 1) mod N] - p[i], p[(j + 1) mod N] - p[j]) >=~ 0.Real:
        j = (j + 1) mod N
      else:
        i = (i + 1) mod N
      if norm(p[i] - p[j]) >~ maxdis:
        maxdis = norm(p[i] - p[j])
        maxi = i
        maxj = j
      if not (i != it or j != jt): break
    return sqrt(maxdis)
  
  # }}}
  
  # polygon {{{
  # contains {{{
  # http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_3_C
  type State* = enum
    OUT, ON, IN
  
  proc contains*[Real](Q: Polygon[Real], p:Point[Real]):State =
    var inside = false;
    for i in 0..<Q.len:
      var
        a = Q[i] - p
        b = Q[(i + 1) mod Q.len] - p
      if a.im >~ b.im: swap(a, b)
      if a.im <=~ 0.Real and 0.Real <~ b.im and cross(a, b) <~ 0.Real: inside = not inside
      if cross(a, b) =~ 0.Real and dot(a, b) <=~ 0.Real: return ON
    return if inside: IN else: OUT
  # }}}
  
  # area {{{
  # http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_3_A
  proc area*[Real](p: Polygon[Real]):Real =
    var A = 0.Real
    for i in 0..<p.len:
      A += cross(p[i], p[(i + 1) mod p.len])
    return A / Real(2)
  
  # http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_7_H
  proc area*[Real](p:Polygon[Real], c:Circle[Real]):Real =
    if p.len < 3: return Real(0)
    proc cross_area(c: Circle[Real], a,b: Point[Real]):Real =
      let
        va = c.p - a
        vb = c.p - b
        f = cross(va, vb)
      result = Real(0)
      if f =~ Real(0): return
      if max(abs(va), abs(vb)) <=~ c.r: return f
      if c.r <=~ distance(initSegment(a, b), c.p):
        return c.r * c.r * phase(vb * conjugate(va))
      let u = crosspoint(c, initSegment(a, b))
      let tot = @[a, u[0], u[1], b]
      for i in 0..<tot.len:
        result += cross_area(c, tot[i], tot[i + 1])
    var A = 0.Real
    for i in 0..<p.len:
      A += cross_area(c, p[i], p[(i + 1) mod p.len]) / Real(2)
    return A
  # }}}
  # }}}
