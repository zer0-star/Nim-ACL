# verify-helper: PROBLEM https://judge.yosupo.jp/problem/associative_array

import atcoder/header
import atcoder/extra/structure/set_map

proc main() =
  let Q = nextInt()
  var a = initSortedMap(int, int)
  for q in 0..<Q:
    let t = nextInt()
    if t == 0:
      let k, v = nextInt()
      a[k] = v
    else:
      let k = nextInt()
      if k in a: echo a[k]
      else: echo 0

main()
