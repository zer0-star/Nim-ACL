# verify-helper: PROBLEM https://judge.yosupo.jp/problem/factorize

include atcoder/header
import atcoder/extra/math/factorization

block main:
  let Q = nextInt()
  for _ in 0..<Q:
    let x = factor(nextInt()).sorted()
    stdout.write(x.len, " ")
    stdout.write(x.mapIt($it).join(" "))
    echo ""
