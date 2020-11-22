# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_7_D
# verify-helper: ERROR 1e-6

include atcoder/header
import atcoder/extra/geometry/geometry_template

block main:
  let
    c = initCircle(initPoint(nextFloat(), nextFloat()), nextFloat())
    q = nextInt()
  for i in 0..<q:
    let p1, p2 = initPoint(nextFloat(), nextFloat())
    let l = initLine(p1, p2)
    var q = crosspoint(c, l)
    if q[0] > q[1]: swap(q[0], q[1])
    echo q[0].toString(), " ", q[1].toString()
