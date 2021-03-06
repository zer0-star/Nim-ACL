# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_5_A
# verify-helper: ERROR 1e-6

include atcoder/header
import atcoder/extra/geometry/geometry_template
import atcoder/extra/geometry/closest_pair

block main:
  let
    n = nextInt()
    g = newSeqWith(n, initPoint(nextFloat(), nextFloat()))
  echo g.closest_pair()
