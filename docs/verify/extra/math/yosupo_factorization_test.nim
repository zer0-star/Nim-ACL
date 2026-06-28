# verify-helper: PROBLEM https://judge.yosupo.jp/problem/factorize

include atcoder/header
import atcoder/extra/math/factorization

block main:
  let Q = nextInt()
  for _ in 0..<Q:
    let x = factor(nextInt()).sorted()
    var ans: seq[int]
    for (p, e) in x:
      for _ in 0 ..< e:
        ans.add p
    echo ans.len, " ", ans.join(" ")
