# verify-helper: PROBLEM https://judge.yosupo.jp/problem/persistent_queue

include atcoder/header

import atcoder/extra/structure/persistent_array

const M = 500000
var S: array[-1..M-1, tuple[a:PersistentArray[int], head, tail:int]]

proc main() =
  let Q = nextInt()
  S[-1] = (initPersistentArray(newSeq[int](M)), 0, 0)
  for i in 0..<Q:
    let q, t = nextInt()
    var (a, head, tail) = S[t]
    if q == 0:
      let x = nextInt()
      a[tail] = x
      tail.inc
    else:
      echo a[head]
      head.inc
    S[i] = (a, head, tail)

main()
