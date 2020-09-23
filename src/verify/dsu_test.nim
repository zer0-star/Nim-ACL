# verify-helper: PROBLEM https://judge.yosupo.jp/problem/unionfind

import atcoder/dsu
import std/sequtils, std/strutils

let
  nq = stdin.readLine.split.map(parseInt)

var
  uf = initDSU(nq[0])

for _ in 0 ..< nq[1]:
  let
    tuv = stdin.readLine.split.map(parseInt)

  if tuv[0] == 0:
    uf.merge(tuv[1], tuv[2])
  elif tuv[0] == 1:
    echo(
      if uf.same(tuv[1], tuv[2]):
        1
      else:
        0
    )
