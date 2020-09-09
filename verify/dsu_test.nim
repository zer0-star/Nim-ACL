# verify-helper: PROBLEM https://judge.yosupo.jp/problem/unionfind

include src/nim_acl/dsu

import sequtils, strutils

let
  nq = stdin.readLine.split.map(parseInt)

var
  dsu = initDSU(nq[0])

for _ in 0 ..< nq[1]:
  let
    tuv = stdin.readLine.split.map(parseInt)

  if tuv[0] == 0:
    dsu.merge(tuv[1], tuv[2])
  elif tuv[0] == 1:
    echo(
      if dsu.same(tuv[1], tuv[2]):
        1
      else:
        0
    )
