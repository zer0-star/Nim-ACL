when not declared ATCODER_TEST_EXTRA_GEOMETRY_POLYGON:
  const ATCODER_TEST_EXTRA_GEOMETRY_POLYGON* = 1

  import std/unittest
  import std/math
  import atcoder/extra/geometry/geometry_template
  import atcoder/extra/geometry/closest_pair
  import atcoder/extra/geometry/polygon

  const EPS = 1e-9

  proc close(a, b: float): bool =
    abs(a - b) <= EPS

  proc p(x, y: float): Point[float] =
    initPoint[float](x, y)

  suite "extra geometry closest_pair and polygon":
    test "closest_pair computes minimum distance":
      let ps = @[
        p(0.0, 0.0),
        p(3.0, 4.0),
        p(2.0, 0.0),
        p(2.0, 1.0),
        p(10.0, 10.0),
      ]

      check close(closest_pair(ps), 1.0)

    test "closest_pair handles duplicate points":
      let ps = @[
        p(0.0, 0.0),
        p(1.0, 1.0),
        p(0.0, 0.0),
      ]

      check close(closest_pair(ps), 0.0)

    test "polygon area and contains":
      let square: Polygon[float] = @[
        p(0.0, 0.0),
        p(2.0, 0.0),
        p(2.0, 2.0),
        p(0.0, 2.0),
      ]

      check close(area(square), 4.0)
      check contains(square, p(1.0, 1.0)) == State.IN
      check contains(square, p(2.0, 1.0)) == State.ON
      check contains(square, p(3.0, 1.0)) == State.OUT

    test "convex hull removes inner point":
      let ps: Polygon[float] = @[
        p(0.0, 0.0),
        p(2.0, 0.0),
        p(2.0, 2.0),
        p(0.0, 2.0),
        p(1.0, 1.0),
      ]

      let h = convexHull(ps)

      check h.len == 4
      check close(abs(area(h)), 4.0)
      check isConvex(h)

    test "isConvex distinguishes concave polygon":
      let convex: Polygon[float] = @[
        p(0.0, 0.0),
        p(2.0, 0.0),
        p(2.0, 2.0),
        p(0.0, 2.0),
      ]

      let concave: Polygon[float] = @[
        p(0.0, 0.0),
        p(2.0, 0.0),
        p(1.0, 1.0),
        p(2.0, 2.0),
        p(0.0, 2.0),
      ]

      check isConvex(convex)
      check not isConvex(concave)

    test "convex diameter of square":
      let square: Polygon[float] = @[
        p(0.0, 0.0),
        p(2.0, 0.0),
        p(2.0, 2.0),
        p(0.0, 2.0),
      ]

      check close(convex_diameter(square), sqrt(8.0))
