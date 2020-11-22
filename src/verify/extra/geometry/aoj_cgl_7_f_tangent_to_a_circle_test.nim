# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_7_F

# verify-helper: ERROR 1e-5

include atcoder/header
import atcoder/extra/geometry/geometry_template
import atcoder/extra/geometry/tangent

block main:
  let
    p = initPoint(nextFloat(), nextFloat())
    c = initCircle(initPoint(nextFloat(), nextFloat()), nextFloat())
  var q = tangent(c, p)
  if q[0] > q[1]: swap(q[0], q[1])
  echo q[0].toString()
  echo q[1].toString()
