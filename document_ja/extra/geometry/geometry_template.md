# geometry_template

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/geometry/geometry_template

## 公開 API

    const ATCODER_GEOMETRY_TEMPLATE_HPP* = 1
    type Point*[Real] = Complex[Real]
    proc initPoint*[Real](re, im:Real):Point[Real] = Point[Real](re:Real(re), im:Real(im))
    proc initPoint*[Real; S: not Real, T](re:S, im:T):Point[Real] = Point[Real](re:Real(re), im:Real(im))
    proc initPoint*[Real; T: not Real](re:Real, im:T):Point[Real] = Point[Real](re:Real(re), im:Real(im))
    proc `*`*[Real](p:Point[Real], d:Real):Point[Real] =
    proc toString*[Real](p:Point[Real]):string = $(p.re) & " " & $(p.im)
    proc rotate*[Real](theta:Real, p:Point):Point =
    proc radianToDegree*[Real](r:Real):Real = r * 180.Real / Real$.pi
    proc degreeToRadian*[Real](d:Real):Real = d * Real$.pi / 180.Real
    proc getAngle*[Real](a,b,c:Point[Real]):Real =
    proc `=~`*[Real](a,b:Point[Real]):bool =
    proc `<~`*[Real](a,b:Point[Real]):bool =
    proc `>~`*[Real](a,b:Point[Real]):bool = b <~ a
    proc `<=~`*[Real](a,b:Point[Real]):bool =
    proc `>=~`*[Real](a,b:Point[Real]):bool = b <=~ a
    type Line*[Real] = object
    type Segment*[Real] = distinct Line[Real]
    proc a*[Real](self:Segment[Real]):Point[Real] = Line[Real](self).a
    proc b*[Real](self:Segment[Real]):Point[Real] = Line[Real](self).b
    proc initLine*[Real](a,b:Point[Real]):Line[Real] = Line[Real](a:a, b:b)
    proc initLine*[Real](A, B, C:Real):Line[Real] = # Ax + By = C
    proc `--`*[Real](a, b:Point[Real]):Line[Real] = initLine(a, b)
    proc `$`*[Real](p:Line[Real]):string =
    proc initSegment*[Real](a, b:Point[Real]):Segment[Real] = Segment[Real](Line[Real](a:a, b:b))
    proc `!!`*[Real](a, b:Point[Real]):Segment[Real] =
    type Circle*[Real] = object
    proc initCircle*[Real](p:Point[Real], r:Real):Circle[Real] = Circle[Real](p:p, r:r)
    proc initCircle*[Real](a, b, c: Point[Real]):Circle[Real] =
    proc name*[Real](a:type_a, b:type_b):auto =
    proc name*[Real](b:type_b, a:type_a):auto =
    proc cross*[Real](a,b:Point[Real]):Real = a.re * b.im - a.im * b.re
    proc dot*[Real](a,b:Point[Real]):Real = a.re * b.re + a.im * b.im
    proc norm*[Real](a:Point[Real]):Real = dot(a,a)
    type CCWState* = enum
    proc ccw*[Real](a, b, c: Point[Real]):CCWState =
    proc parallel*[Real](a,b:Line[Real]):bool = cross(a.b - a.a, b.b - b.a) =~ 0.Real
    proc orthogonal*[Real](a,b:Line[Real]):bool = dot(a.a - a.b, b.a - b.b) =~ 0.Real
    proc intersect*[Real](l, m: Line[Real]):bool =
    proc intersect*[Real](s, t: Segment[Real]):bool =
    proc intersect*[Real](c1, c2: Circle[Real]):int =
    proc distance*[Real](a, b:Point[Real]):Real = abs(a - b)
    proc distance*[Real](l, m: Line[Real]):Real =
    proc distance*[Real](a, b:Segment[Real]):Real =
    proc crosspoint*[Real](l, m:Line[Real]):Point[Real] =
    proc crosspoint*[Real](l, m:Segment[Real]):Point[Real] =
    let base = sqrt(c.r * c.r - norm(pr - c.p))
    proc crosspoint*[Real](c1, c2: Circle[Real]):(Point[Real],Point[Real]) =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
