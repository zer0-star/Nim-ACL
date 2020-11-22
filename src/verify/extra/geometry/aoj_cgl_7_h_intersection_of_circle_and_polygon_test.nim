# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_7_H
# verify-helper: ERROR 1e-5

include atcoder/header
import atcoder/extra/geometry/geometry_template
import atcoder/extra/geometry/polygon

block main:
  let
    n = nextInt()
    c = initCircle(initPoint(0.0, 0.0), nextFloat())
    g = newSeqWith(n, initPoint(nextFloat(), nextFloat()))
  echo area(g, c)
