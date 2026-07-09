when not declared ATCODER_TEST_EXTRA_GEOMETRY_FACADE:
  const ATCODER_TEST_EXTRA_GEOMETRY_FACADE* = 1

  import std/unittest
  import std/math
  import atcoder/extra/geometry/geometry

  const EPS = 1e-9

  proc close(a, b: float): bool =
    abs(a - b) <= EPS

  proc closePoint(p, q: Point[float]): bool =
    close(p.re, q.re) and close(p.im, q.im)

  suite "extra geometry friendly facade":
    test "friendly constructors and aliases":
      let
        a = point(0.0, 0.0)
        b = point(3.0, 4.0)

      check close(dist(a, b), 5.0)
      check close(dot(b, b), 25.0)

      let c: Circle2[float] = circle(a, 2.0)

      check close(c.r, 2.0)
      check closePoint(c.p, a)

    test "friendly line segment names":
      let
        a = point(0.0, 0.0)
        b = point(2.0, 2.0)
        c = point(0.0, 2.0)
        d = point(2.0, 0.0)

      let
        l1 = line(a, b)
        l2 = line(c, d)
        s1 = segment(a, b)
        s2 = segment(c, d)

      check intersects(l1, l2)
      check intersects(s1, s2)
      check closePoint(intersection(l1, l2), point(1.0, 1.0))
      check closePoint(intersection(s1, s2), point(1.0, 1.0))

    test "facade reexports polygon and closest pair":
      let ps: Polygon2[float] = @[
        point(0.0, 0.0),
        point(2.0, 0.0),
        point(2.0, 2.0),
        point(0.0, 2.0),
        point(1.0, 1.0),
      ]

      let h = convexHull(ps)

      check h.len == 4
      check close(abs(area(h)), 4.0)
      check close(closest_pair(@[point(0.0, 0.0), point(3.0, 4.0), point(1.0, 0.0)]), 1.0)

    test "facade reexports triangle and tangent":
      let
        a = point(0.0, 0.0)
        b = point(4.0, 0.0)
        c = point(0.0, 3.0)

      check closePoint(incenter(a, b, c), point(1.0, 1.0))
      check closePoint(circumcenter(a, b, c), point(2.0, 1.5))

      let
        circ = circle(point(0.0, 0.0), 1.0)
        q = point(2.0, 0.0)

      let (u, v) = tangent(circ, q)

      check close(dist(circ.p, u), 1.0)
      check close(dist(circ.p, v), 1.0)
