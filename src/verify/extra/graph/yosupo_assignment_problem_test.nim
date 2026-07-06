# verify-helper: PROBLEM https://judge.yosupo.jp/problem/assignment

include atcoder/header
import atcoder/extra/graph/hungarian

proc main() =
  let
    N = nextInt()
    a = newSeqWith(N, newSeqWith(N, nextInt()))
  let (X, p) = a.hungarian()
  echo X
  echo p.mapIt($it).join(" ")

main()
