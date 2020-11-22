# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_3_A

include atcoder/header
import atcoder/extra/geometry/geometry_template
import atcoder/extra/geometry/polygon

block main:
  let
    n = nextInt()
    p = newSeqWith(n, initPoint(nextFloat(), nextFloat()))
  echo fmt"{p.area():.1f}"
