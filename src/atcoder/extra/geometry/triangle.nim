#include "../template/template.nim"
#include "./template.nim"

proc centroid(a,b,c:Point):Point =
  result = a + b + c
  result /= 3.0.complex

proc incircle(a,b,c:Point):Circle =
  let
    (x, y, z) = (abs(b - c), abs(c - a), abs(a - b))
    p = (a * x + b * y + c * z)/(x + y + z)
  return initCircle(p, initLine(a, b).distance(p))

proc excircle(a,b,c:Point):array[3, Circle] =
  let
    (x, y, z) = (abs(b - c), abs(c - a), abs(a - b))
    pa = (- a * x + b * y + c * z)/(- x + y + z)
    pb = (a * x - b * y + c * z)/(x - y + z)
    pc = (a * x + b * y - c * z)/(x + y - z)
  return [initCircle(pa, initLine(b, c).distance(pa)), 
           initCircle(pb, initLine(c, a).distance(pb)), 
           initCircle(pc, initLine(a, b).distance(pc))]

proc circumcircle(a,b,c:Point):Circle =
  let
    x = 1.0/(b - a).conjugate
    y = 1.0/(c - a).conjugate
    p = (y - x)/(x.conjugate * y - x * y.conjugate) + a
  return initCircle(p, abs(p-a))
proc orthocenter(a,b,c:Point):Point =
  return crossPoint(
           initLine(a, a.projection(initLine(b, c))), 
           initLine(b, b.projection(initLine(a, b))))
