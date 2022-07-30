import std/unittest, std/sugar

import atcoder/modint
import atcoder/extra/math/matrix

include atcoder/extra/other/operator

type mint = modint998244353
type M = DynamicMatrixType(mint)
type MS = StaticMatrixType(mint)
import rationals
const RationalOperator = getOperator(Rational[int]):
  zero() = initRational[int](0, 1)
  unit() = initRational[int](1, 1)
  add(a, b) = a + b
  mult(a, b) = a * b
  divide(a, b) = a / b
  isZero(a) = a == initRational[int](0, 1)

type MR = DynamicMatrixType(Rational[int], RationalOperator)
converter toRational[T](a:T):Rational[T] = initRational[T](a, T(1))
type MF = DynamicMatrixType(float)

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
  A += A
  A -= A

test "MatrixOperationStatic":
  type M = MS
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
  A += A
  A -= A

test "MatrixPower":
  var A = M.init([[1, 2, 3], [3, 4, 5], [5, 6, 7]])
  let
    a = 314
    b = 159
  check A^(a * b) == (A^a)^b

test "MatrixDeterminant":
  var A = M.init([[3, 1, 1, 2], [5, 1, 3, 4], [2, 0, 1, 0], [1, 3, 2, 1]])
  check A.determinant == -22
  var B = M.init([[2, 7, 9, 8], [1, 7, 9, 6], [3, 2, 1, 9], [8, 9, 5, 2]])
  check (A * B).determinant == A.determinant * B.determinant

test "MatrixInv":
  var A = M.init([[3, 1, 1, 2], [5, 1, 3, 4], [2, 0, 1, 0], [1, 3, 2, 1]])
  check A.inv() * A == A.unit()

test "MatrixInvRational":
  var A = MR.init([[3, 1, 1, 2], [5, 1, 3, 4], [2, 0, 1, 0], [1, 3, 2, 1]])
  check A.inv() * A == A.unit()

test "MatrixInvFloat":
  var A = MF.init([[3, 1, 1, 2], [5, 1, 3, 4], [2, 0, 1, 0], [1, 3, 2, 1]])
  check (A.inv() * A).equals(A.unit())
