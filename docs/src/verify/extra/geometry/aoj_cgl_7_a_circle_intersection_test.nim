# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_7_A

include atcoder/header
import atcoder/extra/geometry/geometry_template

block main:
  let
    p1 = initPoint(nextFloat(), nextFloat())
    r1 = nextFloat()
    c1 = initCircle(p1, r1)
    p2 = initPoint(nextFloat(), nextFloat())
    r2 = nextFloat()
    c2 = initCircle(p2, r2)
  echo intersect(c1, c2)
