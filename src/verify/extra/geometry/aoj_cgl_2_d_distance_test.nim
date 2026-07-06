# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_2_D

# verify-helper: ERROR 1e-8

include atcoder/header
import atcoder/extra/geometry/geometry_template

block main:
  let q = nextInt()
  for i in 0..<q:
    var p = newSeqWith(4, initPoint(nextFloat(), nextFloat()))
    echo distance(initSegment(p[0], p[1]), initSegment(p[2], p[3]))
