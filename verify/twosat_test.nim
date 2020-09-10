# verify-helper: PROBLEM https://judge.yosupo.jp/problem/two_sat

include src/nim_acl/header
include src/nim_acl/twosat

import sequtils, strutils, sugar

block:
  let
    p, cnf = nextString() # dummy
    N, M = nextInt()
  var ts = initTwoSat(N)
  for _ in 0..<M:
    var a, b = nextInt()
    let zero = nextString() # summy
    var f, g:bool
    if a > 0:
      f = true
    else:
      f = false
      a *= -1
    a.dec
    if b > 0:
      g = true
    else:
      g = false
      b *= -1
    b.dec
    ts.add_clause(a, f, b, g)
  if ts.satisfiable:
    echo "s SATISFIABLE"
    stdout.write "v "
    for i,a in ts.answer:
      if a:
        stdout.write i + 1, " "
      else:
        stdout.write -(i + 1), " "
    echo 0
  else:
    echo "s UNSATISFIABLE"
