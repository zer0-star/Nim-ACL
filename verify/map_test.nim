# verify-helper: PROBLEM https://judge.yosupo.jp/problem/associative_array

include src/nim_acl/header
include src/nim_acl/extra/structure/set_map

proc main() =
  let Q = nextInt()
  var a = initOrderedMap[int,int]()
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
