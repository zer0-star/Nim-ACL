# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_1_C

include atcoder/header
import atcoder/extra/geometry/geometry_template

block main:
  let
    xp0, yp0, xp1, yp1 = nextFloat()
    p0 = initPoint(xp0, yp0)
    p1 = initPoint(xp1, yp1)
  let q = nextInt()
  for i in 0..<q:
    let
      xp2, yp2 = nextFloat()
      p2 = initPoint(xp2, yp2)
      c = ccw(p0, p1, p2)
    if c == CCWState.COUNTER_CLOCKWISE:    echo "COUNTER_CLOCKWISE"
    elif c == CCWState.CLOCKWISE: echo "CLOCKWISE"
    elif c == CCWState.ONLINE_BACK: echo "ONLINE_BACK"
    elif c == CCWState.ONLINE_FRONT: echo "ONLINE_FRONT"
    else: echo "ON_SEGMENT"
