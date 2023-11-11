# verify-helper: PROBLEM https://judge.yosupo.jp/problem/characteristic_polynomial

include atcoder/header
import atcoder/modint
import atcoder/extra/math/matrix
import atcoder/extra/math/characteristic_polynomial

type mint = modint998244353

block main:
  let N = nextInt()
  type Mat = DynamicMatrixType(mint)
  var
    A = Mat.init(N)
  for i in 0 ..< N:
    for j in 0 ..< N:
      A[i, j] = nextInt()

  echo characteristic_polynomial(A).join(" ")
