when not declared ATCODER_TEST_EXTRA_MATH_BASIC:
  const ATCODER_TEST_EXTRA_MATH_BASIC* = 1

  import std/unittest
  import std/options
  import atcoder/modint
  import atcoder/extra/math/convert_base
  import atcoder/extra/math/mod_sqrt
  import atcoder/extra/math/combination_table
  import atcoder/extra/math/floor_sum_square
  import atcoder/extra/math/factorial

  type mint = modint998244353

  proc bruteFloorSumSquare(n, m, a, b: int): tuple[S1, S2, S3: int] =
    for i in 0 ..< n:
      let q = (a * i + b) div m
      result.S1 += i * q
      result.S2 += q * q
      result.S3 += q

  suite "extra math basic utilities":
    test "convert_base uses little endian digits":
      check toSeq(12345, 10) == @[5, 4, 3, 2, 1]
      check toInt(@[5, 4, 3, 2, 1], 10) == 12345
      check toSeq(13, 2) == @[1, 0, 1, 1]
      check toInt(@[1, 0, 1, 1], 2) == 13
      check toSeq(0, 10, 4) == @[0, 0, 0, 0]

    test "mod_sqrt returns square root when it exists":
      let r = modSqrt(mint(4))

      check r.isSome

      let x = r.get

      check x * x == mint(4)
      check modSqrt(mint(0)).get == mint(0)

    test "mod_sqrt returns none for non quadratic residue":
      check modSqrt(mint(3)).isNone

    test "combination_table typedesc helpers":
      check int.C(5, 2) == 10
      check int.C(5, -1) == 0
      check int.C(5, 7) == 0
      check int.H(3, 2) == 6
      check int.P(5, 2) == 20
      check int.fact(5) == 120

    test "floor_sum_square matches brute force for positive inputs":
      let ans = floor_sum_square(5, 7, 3, 2)
      let expected = bruteFloorSumSquare(5, 7, 3, 2)

      check ans.S1 == expected.S1
      check ans.S2 == expected.S2
      check ans.S3 == expected.S3

    test "factorial for static modint":
      check factorial[mint](0) == mint(1)
      check factorial[mint](1) == mint(1)
      check factorial[mint](5) == mint(120)
      check factorial[mint](10) == mint(3628800)
