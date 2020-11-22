# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_3_C

include atcoder/header
import atcoder/extra/geometry/geometry_template
import atcoder/extra/geometry/polygon

block main:
  let
    g = nextInt()
    poly = newSeqWith(g, initPoint(nextFloat(), nextFloat()))
    q = nextInt()
  for i in 0..<q:
    let p = initPoint(nextFloat(), nextFloat())
    let t = p in poly
    if t == IN:
      echo 2
    elif t == ON:
      echo 1
    else:
      echo 0
