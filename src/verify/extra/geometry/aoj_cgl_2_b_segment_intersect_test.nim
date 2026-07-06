# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_2_B

include atcoder/header
import atcoder/extra/geometry/geometry_template

block main:
  let q = nextInt()
  for i in 0..<q:
    let xp0, yp0, xp1, yp1, xp2, yp2, xp3, yp3 = nextFloat()
    let
      p0 = initPoint(xp0, yp0)
      p1 = initPoint(xp1, yp1)
      p2 = initPoint(xp2, yp2)
      p3 = initPoint(xp3, yp3)
      s1 = initSegment(p0, p1)
      s2 = initSegment(p2, p3)
    if s1.intersect(s2): echo 1
    else: echo 0
