# verify-helper: PROBLEM https://judge.yosupo.jp/problem/system_of_linear_equations

include atcoder/header
import atcoder/modint
import atcoder/extra/math/matrix
import options

type mint = modint998244353

block main:
  let N, M = nextInt()
  type Mat = DynamicMatrixType(mint)
  let
    A = Mat.init(newSeqWith(N, newSeqWith(M, mint(nextInt()))))
    b:Mat.Vector = newSeqWith(N, mint(nextInt()))
  let t = linearEquations(A, b)
  if t.isSome():
    let (x, vs) = t.get
    echo vs.len
    echo x.mapIt($it).join(" ")
    for v in vs:
      echo v.mapIt($it).join(" ")
  else:
    echo -1
