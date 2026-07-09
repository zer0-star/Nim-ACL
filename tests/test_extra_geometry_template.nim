when not declared ATCODER_TEST_EXTRA_GEOMETRY_TEMPLATE:
  const ATCODER_TEST_EXTRA_GEOMETRY_TEMPLATE* = 1

  import std/unittest
  import std/math
  import atcoder/extra/geometry/geometry_template

  const EPS = 1e-9

  proc close(a, b: float): bool =
    abs(a - b) <= EPS

  proc closePoint(p, q: Point[float]): bool =
    close(p.re, q.re) and close(p.im, q.im)

  suite "extra geometry template":
    test "point construction and basic products":
      let
        a = initPoint[float](0.0, 0.0)
        b = initPoint[float](3.0, 4.0)
        c = initPoint[float](1.0, 0.0)
        d = initPoint[float](0.0, 1.0)

      check close(distance(a, b), 5.0)
      check close(dot(b, b), 25.0)
      check close(cross(c, d), 1.0)
      check close(norm(b), 25.0)

    test "angle conversion and rotation":
      let p = initPoint[float](1.0, 0.0)
      let q = rotate(PI / 2.0, p)

      check close(radianToDegree(PI), 180.0)
      check close(degreeToRadian(180.0), PI)
      check closePoint(q, initPoint[float](0.0, 1.0))

    test "ccw classifies simple positions":
      let
        a = initPoint[float](0.0, 0.0)
        b = initPoint[float](2.0, 0.0)
        c = initPoint[float](1.0, 1.0)
        d = initPoint[float](1.0, -1.0)
        e = initPoint[float](1.0, 0.0)
        f = initPoint[float](3.0, 0.0)
        g = initPoint[float](-1.0, 0.0)

      check ccw(a, b, c) == CCWState.COUNTER_CLOCKWISE
      check ccw(a, b, d) == CCWState.CLOCKWISE
      check ccw(a, b, e) == CCWState.ON_SEGMENT
      check ccw(a, b, f) == CCWState.ONLINE_FRONT
      check ccw(a, b, g) == CCWState.ONLINE_BACK

    test "line and segment operations":
      let
        a = initPoint[float](0.0, 0.0)
        b = initPoint[float](2.0, 2.0)
        c = initPoint[float](0.0, 2.0)
        d = initPoint[float](2.0, 0.0)

      let
        l1 = initLine(a, b)
        l2 = initLine(c, d)
        s1 = initSegment(a, b)
        s2 = initSegment(c, d)

      check intersect(l1, l2)
      check intersect(s1, s2)

      let p = crosspoint(l1, l2)

      check closePoint(p, initPoint[float](1.0, 1.0))

    test "parallel orthogonal and distance":
      let
        a = initPoint[float](0.0, 0.0)
        b = initPoint[float](1.0, 0.0)
        c = initPoint[float](0.0, 1.0)
        d = initPoint[float](1.0, 1.0)

      let
        horizontal1 = initLine(a, b)
        horizontal2 = initLine(c, d)
        vertical = initLine(a, c)

      check parallel(horizontal1, horizontal2)
      check orthogonal(horizontal1, vertical)
      check close(distance(horizontal1, c), 1.0)
