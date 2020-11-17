import std/unittest, std/sugar

import atcoder/modint
import atcoder/extra/math/matrix
import atcoder/extra/math/gaussian_elimination

type mint = modint998244353
type M = getMatrixType(mint)

test "MatrixOperation":
  var A = M.init([[1, 2], [3, 4], [5, 6]])
  var A2 = M.init([[3, 7], [2, 9], [5, 7]])
  var S = M.init([[4, 9], [5, 13], [10, 13]])
  var D = M.init([[-2, -5], [1, -5], [0, -1]])
  var B = M.init([[3, 1, 4], [1, 5, 9]])
  var v = M.initVector([2, 7])
  var w = M.initVector([16, 34, 52])
  var C = M.init([[5, 11, 22], [13, 23, 48], [21, 35, 74]])
  check A + A2 == S
  check A - A2 == D
  check A * B == C
  check A * v == w

test "MatrixDeterminant":
  var A = M.init([[3, 1, 1, 2], [5, 1, 3, 4], [2, 0, 1, 0], [1, 3, 2, 1]])
  check A.determinant == -22

test "MatrixInv":
  var A = M.init([[3, 1, 1, 2], [5, 1, 3, 4], [2, 0, 1, 0], [1, 3, 2, 1]])
  check A.inv() * A == A.unit()

import rationals
type MR = getMatrixType(Rational[int], ()=>initRational[int](0, 1), ()=>initRational[int](1, 1))

converter toRational[T](a:T):Rational[T] = initRational[T](a, T(1))

test "MatrixInvRational":
  var A = MR.init([[3, 1, 1, 2], [5, 1, 3, 4], [2, 0, 1, 0], [1, 3, 2, 1]])
  check A.inv() * A == A.unit()
