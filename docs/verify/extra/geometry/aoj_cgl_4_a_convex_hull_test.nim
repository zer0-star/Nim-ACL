# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_4_A

include atcoder/header
import atcoder/extra/geometry/geometry_template
import atcoder/extra/geometry/polygon

block main:
  let
    n = nextInt()
    p = newSeqWith(n, initPoint(nextFloat(), nextFloat()))
    ch = p.convexHull()
  let EPS = 1e-8
  var min_p = initPoint(float.inf, float.inf)
  var min_i:int
  for i,p in ch:
    if min_p.im - EPS > p.im:
      min_p = p
      min_i = i
    elif min_p.im + EPS > p.im:
      if min_p.re - EPS > p.re:
        min_p = p
        min_i = i
  var i = min_i
  echo ch.len
  while true:
    echo ch[i].re.int, " ", ch[i].im.int
    i.inc
    if i == ch.len: i = 0
    if i == min_i: break
