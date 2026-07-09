when not declared ATCODER_TEST_EXTRA_DP_BASIC:
  const ATCODER_TEST_EXTRA_DP_BASIC* = 1

  import std/unittest
  import atcoder/extra/dp/cumulative_sum
  import atcoder/extra/dp/dual_cumulative_sum
  import atcoder/extra/dp/longest_increasing_subsequence
  import atcoder/extra/dp/slide_min
  import atcoder/extra/other/return_type

  proc isStrictlyIncreasing[T](a: seq[T]): bool =
    for i in 1 ..< a.len:
      if not (a[i - 1] < a[i]):
        return false
    true

  suite "extra dp basic utilities":
    test "cumulative_sum supports range sums":
      var cs = initCumulativeSum(@[1, 2, 3, 4, 5])

      check cs.sum(0) == 0
      check cs.sum(3) == 6
      check cs[0 .. 0] == 1
      check cs[1 .. 3] == 9
      check cs[0 .. 4] == 15

    test "cumulative_sum supports point add":
      var cs = initCumulativeSum[int](5)

      cs.add(0, 3)
      cs.add(2, 7)
      cs.add(4, 11)

      check cs[0 .. 4] == 21
      check cs[1 .. 3] == 7
      check cs[4 .. 4] == 11

    test "dual_cumulative_sum supports range add point get":
      var ds = initDualCumulativeSum[int](5)

      ds.add(1 .. 3, 10)
      ds.add(2, -3)

      check ds[0] == 0
      check ds[1] == 10
      check ds[2] == 7
      check ds[3] == 10
      check ds[4] == 0

    test "longest_increasing_subsequence length modes":
      let a = @[3, 1, 2, 1, 8, 5, 6]

      check longestIncreasingSubsequence(a) == 4
      check longestIncreasingSubsequence(@[2, 2, 2], strict = false) == 3
      check longestIncreasingSubsequence(@[2, 2, 2], strict = true) == 1

    test "longest_increasing_subsequence value return type":
      let a = @[3, 1, 2, 1, 8, 5, 6]

      let lis = longestIncreasingSubsequence(a, return_type = Value)

      check lis.len == 4
      check lis.isStrictlyIncreasing

    test "slide_min and slide_max":
      let a = @[4, 2, 5, 1, 3]

      check slideMin(a, 3)[^3 .. ^1] == @[2, 1, 1]
      check slideMax(a, 3)[^3 .. ^1] == @[5, 5, 5]
