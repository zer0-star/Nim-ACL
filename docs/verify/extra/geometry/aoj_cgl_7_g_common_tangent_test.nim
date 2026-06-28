# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_7_G
# verify-helper: ERROR 1e-5

include atcoder/header
import atcoder/extra/other/floatutils
import atcoder/extra/geometry/geometry_template
import atcoder/extra/geometry/tangent

block main:
  let
    c1, c2 = initCircle(initPoint(nextFloat(), nextFloat()), nextFloat())
    q = tangent(c1, c2)
  var ans = newSeq[Point[float]]()
  for l in q:
    if distance(l.a, c1.p) =~ c1.r:
      ans.add l.a
    else:
      ans.add l.b
  ans.sort() do (x, y:Point[float]) -> int:
    if x <~ y: -1
    elif x >~ y: 1
    else: 0
  for a in ans:
    echo a.toString()
