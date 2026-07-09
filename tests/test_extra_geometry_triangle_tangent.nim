when not declared ATCODER_TEST_EXTRA_GEOMETRY_TRIANGLE_TANGENT:
  const ATCODER_TEST_EXTRA_GEOMETRY_TRIANGLE_TANGENT* = 1

  import std/unittest
  import std/math
  import atcoder/extra/geometry/geometry_template
  import atcoder/extra/geometry/triangle
  import atcoder/extra/geometry/tangent

  const EPS = 1e-8

  proc close(a, b: float): bool =
    abs(a - b) <= EPS

  proc closePoint(p, q: Point[float]): bool =
    close(p.re, q.re) and close(p.im, q.im)

  proc p(x, y: float): Point[float] =
    initPoint[float](x, y)

  suite "extra geometry triangle and tangent":
    test "triangle centers on 3-4-5 right triangle":
      let
        a = p(0.0, 0.0)
        b = p(4.0, 0.0)
        c = p(0.0, 3.0)

      check closePoint(centroid(a, b, c), p(4.0 / 3.0, 1.0))
      check closePoint(incenter(a, b, c), p(1.0, 1.0))
      check closePoint(circumcenter(a, b, c), p(2.0, 1.5))
      check closePoint(orthocenter(a, b, c), p(0.0, 0.0))

      let inc = incircle(a, b, c)
      check closePoint(inc.p, p(1.0, 1.0))
      check close(inc.r, 1.0)

      let cc = circumcircle(a, b, c)
      check closePoint(cc.p, p(2.0, 1.5))
      check close(cc.r, 2.5)

    test "excenters are returned for a nondegenerate triangle":
      let
        a = p(0.0, 0.0)
        b = p(4.0, 0.0)
        c = p(0.0, 3.0)

      let ex = excenter(a, b, c)

      check ex.len == 3
      check closePoint(ex[0], p(6.0, 6.0))
      check closePoint(ex[1], p(-2.0, 2.0))
      check closePoint(ex[2], p(3.0, -3.0))

    test "tangent points from external point touch circle":
      let
        c = initCircle(p(0.0, 0.0), 1.0)
        q = p(2.0, 0.0)

      let (u, v) = tangent(c, q)

      check close(distance(c.p, u), c.r)
      check close(distance(c.p, v), c.r)
      check close(dot(u - c.p, q - u), 0.0)
      check close(dot(v - c.p, q - v), 0.0)

    test "common tangents of two disjoint equal circles":
      let
        c1 = initCircle(p(0.0, 0.0), 1.0)
        c2 = initCircle(p(4.0, 0.0), 1.0)

      let lines = tangent(c1, c2)

      check lines.len == 4

      for l in lines:
        check close(distance(l, c1.p), c1.r)
        check close(distance(l, c2.p), c2.r)
