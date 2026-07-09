when not declared ATCODER_EXTRA_GEOMETRY_GEOMETRY_HPP:
  const ATCODER_EXTRA_GEOMETRY_GEOMETRY_HPP* = 1

  import atcoder/extra/geometry/geometry_template
  import atcoder/extra/geometry/closest_pair
  import atcoder/extra/geometry/polygon
  import atcoder/extra/geometry/triangle
  import atcoder/extra/geometry/tangent

  export geometry_template
  export closest_pair
  export polygon
  export triangle
  export tangent

  type
    Point2*[Real] = Point[Real]
    Line2*[Real] = Line[Real]
    Segment2*[Real] = Segment[Real]
    Circle2*[Real] = Circle[Real]
    Polygon2*[Real] = Polygon[Real]

  proc point*[Real](x, y: Real): Point[Real] =
    initPoint[Real](x, y)

  proc line*[Real](a, b: Point[Real]): Line[Real] =
    initLine(a, b)

  proc line*[Real](A, B, C: Real): Line[Real] =
    initLine(A, B, C)

  proc segment*[Real](a, b: Point[Real]): Segment[Real] =
    initSegment(a, b)

  proc circle*[Real](center: Point[Real], radius: Real): Circle[Real] =
    initCircle(center, radius)

  proc circle*[Real](a, b, c: Point[Real]): Circle[Real] =
    initCircle(a, b, c)

  proc dist*[Real](a, b: Point[Real]): Real =
    distance(a, b)

  proc dist*[Real](l: Line[Real], p: Point[Real]): Real =
    distance(l, p)

  proc dist*[Real](s: Segment[Real], p: Point[Real]): Real =
    distance(s, p)

  proc dist*[Real](a, b: Segment[Real]): Real =
    distance(a, b)

  proc intersects*[Real](a, b: Line[Real]): bool =
    intersect(a, b)

  proc intersects*[Real](a, b: Segment[Real]): bool =
    intersect(a, b)

  proc intersection*[Real](a, b: Line[Real]): Point[Real] =
    crosspoint(a, b)

  proc intersection*[Real](a, b: Segment[Real]): Point[Real] =
    crosspoint(a, b)
