when not declared ATCODER_TEST_EXTRA_DP_2D_EDIT_RECTANGLE:
  const ATCODER_TEST_EXTRA_DP_2D_EDIT_RECTANGLE* = 1

  import std/unittest
  import atcoder/extra/dp/cumulative_sum_2d
  import atcoder/extra/dp/dual_cumulative_sum_2d
  import atcoder/extra/dp/edit_distance
  import atcoder/extra/dp/largest_rectangle

  suite "extra dp 2d and string utilities":
    test "cumulative_sum_2d from matrix":
      let a = @[
        @[1, 2, 3],
        @[4, 5, 6],
        @[7, 8, 9],
      ]

      var cs = initCumulativeSum2D(a)

      check cs[0 .. 0, 0 .. 0] == 1
      check cs[0 .. 1, 0 .. 1] == 12
      check cs[1 .. 2, 1 .. 2] == 28
      check cs[0 .. 2, 0 .. 2] == 45

    test "cumulative_sum_2d point add and build":
      var cs = initCumulativeSum2D[int](3, 3)

      cs.add(0, 0, 5)
      cs.add(2, 1, 7)
      cs.add(1, 2, 11)
      cs.build()

      check cs[0 .. 2, 0 .. 2] == 23
      check cs[2 .. 2, 1 .. 1] == 7
      check cs[1 .. 2, 1 .. 2] == 18

    test "dual_cumulative_sum_2d range add point get":
      var ds = initDualCumulativeSum2D[int](4, 4)

      ds.add(1 .. 2, 0 .. 1, 10)
      ds.add(0 .. 3, 3 .. 3, 5)
      ds.add(2, 2, -4)
      ds.build()

      check ds[0, 0] == 0
      check ds[1, 0] == 10
      check ds[2, 1] == 10
      check ds[2, 2] == -4
      check ds[3, 3] == 5
      check ds[-1, 0] == 0
      check ds[4, 0] == 0

    test "edit_distance":
      check editDistance("", "") == 0
      check editDistance("abc", "abc") == 0
      check editDistance("kitten", "sitting") == 3
      check editDistance("abc", "") == 3
      check editDistance("", "abc") == 3

    test "largest_rectangle":
      check largestRectangle(@[2, 1, 5, 6, 2, 3]) == 10
      check largestRectangle(@[2, 4]) == 4
      check largestRectangle(@[1, 1, 1, 1]) == 4
      check largestRectangle(newSeq[int]()) == 0
