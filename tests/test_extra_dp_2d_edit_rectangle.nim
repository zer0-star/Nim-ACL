when not declared ATCODER_TEST_EXTRA_DP_2D_EDIT_RECTANGLE:
  const ATCODER_TEST_EXTRA_DP_2D_EDIT_RECTANGLE* = 1

  import std/unittest
  import atcoder/extra/dp/cumulative_sum_2d
  import atcoder/extra/dp/dual_cumulative_sum_2d
  import atcoder/extra/dp/edit_distance
  import atcoder/extra/dp/largest_rectangle

  suite "extra dp 2d and string utilities":
    test "cumulative_sum_2d from non-square matrix":
      let data = @[
        @[1, 2, 3],
        @[4, 5, 6],
      ]

      let cumulative =
        initCumulativeSum2D(data)

      check cumulative.height == 2
      check cumulative.width == 3

      check cumulative[
        0 .. 0,
        0 .. 0,
      ] == 1

      check cumulative[
        0 .. 1,
        1 .. 2,
      ] == 16

      check cumulative.sum(
        1,
        2,
        0,
        3,
      ) == 15

      check cumulative.allSum == 21

    test "cumulative_sum_2d point add and build":
      var cumulative =
        initCumulativeSum2D[int](
          2,
          3,
        )

      cumulative.add(0, 2, 7)
      cumulative.add(1, 1, 11)
      cumulative.add(0, 0, 5)
      cumulative.build()

      check cumulative.height == 2
      check cumulative.width == 3

      check cumulative[
        0 .. 1,
        0 .. 2,
      ] == 23

      check cumulative[
        0 .. 0,
        2 .. 2,
      ] == 7

      check cumulative[
        1 .. 1,
        1 .. 1,
      ] == 11

    test "dual_cumulative_sum_2d range add point get":
      var difference =
        initDualCumulativeSum2D[int](
          3,
          4,
        )

      difference.add(
        1 .. 2,
        0 .. 1,
        10,
      )

      difference.add(
        0 .. 2,
        3 .. 3,
        5,
      )

      difference.add(
        2,
        2,
        -4,
      )

      difference.build()

      check difference[0, 0] == 0
      check difference[1, 0] == 10
      check difference[2, 1] == 10
      check difference[2, 2] == -4
      check difference[2, 3] == 5
      check difference[-1, 0] == 0
      check difference[3, 0] == 0
      check difference[0, 4] == 0

    test "edit_distance":
      check editDistance("", "") == 0
      check editDistance("abc", "abc") == 0
      check editDistance("kitten", "sitting") == 3
      check editDistance("abc", "") == 3
      check editDistance("", "abc") == 3

    test "largest_rectangle":
      check largestRectangle(
        @[2, 1, 5, 6, 2, 3],
      ) == 10

      check largestRectangle(
        @[2, 4],
      ) == 4

      check largestRectangle(
        @[1, 1, 1, 1],
      ) == 4

      check largestRectangle(
        newSeq[int](),
      ) == 0
