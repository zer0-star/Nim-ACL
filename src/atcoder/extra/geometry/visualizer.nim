import std/math
import atcoder/extra/other/floatutils
import atcoder/extra/geometry/geometry_template
import atcoder/extra/geometry/polygon

import nigui

const D = 900

type CanvasData[Real] = object
  p: seq[(Point[Real], string, Color)]
  l: seq[(Line[Real], string, Color)]
  s: seq[(Segment[Real], string, Color)]
  c: seq[(Circle[Real], string, Color)]
  poly: seq[(Polygon[Real], string, Color)]
  width, height: int
  xmin, ymin: float
  d: float


proc convert[Real](self:CanvasData[Real], p:Point[Real]):Point[Real] =
  return initPoint((p.re - self.xmin)/self.d * D, D - (p.im - self.ymin)/self.d * D)
proc convert[Real](self:CanvasData[Real], c:Circle[Real]):Circle[Real] =
  return initCircle(self.convert c.p, c.r/self.d*D)
proc convert[Real](self:CanvasData[Real], l:Line[Real]):Line[Real] =
  return initLine(self.convert l.a, self.convert l.b)
proc convert[Real](self:CanvasData[Real], l:Segment[Real]):Segment[Real] =
  return initSegment(self.convert l.a, self.convert l.b)
proc convert[Real](self:CanvasData[Real], p:Polygon[Real]):Polygon[Real] =
  for p in p: result.add(self.convert p)

const MARGIN = 5.0

proc setCanvasSize[Real](self: var CanvasData[Real]) =
  var
    xmin = float.inf
    xmax = -float.inf
    ymin = float.inf
    ymax = -float.inf
  proc update(p:Point[Real]) =
    xmin.min=p.re
    xmax.max=p.re
    ymin.min=p.im
    ymax.max=p.im
  for p in self.p:
    update(p[0])
  for p in self.s:
    update(p[0].a)
    update(p[0].b)
  for p in self.c:
    let
      c = p[0].p
      r = p[0].r
    update(initPoint(c.re+r,c.im+r))
    update(initPoint(c.re-r,c.im-r))
  xmin -= MARGIN;ymin -= MARGIN
  xmax += MARGIN;ymax += MARGIN
  let d = max(xmax - xmin, ymax - ymin)
  self.xmin = xmin
  self.ymin = ymin
  self.d = d
  

type Canvas[Real] = object
  Win: Window
  Ctl: Control
  canvas_data: CanvasData[Real]

# initCanvas {{{
proc initCanvas*[Real]():Canvas[Real] =
  result = Canvas[Real]()
  app.init()
  result = Canvas[Real](Win:newWindow("Canvas"), Ctl:newControl(), canvas_data: CanvasData[Real]())
  result.Ctl.widthMode = WidthMode_Fill
  result.Ctl.heightMode = HeightMode_Fill
  result.Win.add(result.Ctl)
  result.Win.width = D
  result.Win.height = D
  var s = result.canvas_data.addr

  result.Ctl.onClick = proc(c:ClickEvent)=
    echo "Canvas"

  proc getLineEndpoints(l:Line[Real]):Line[Real] =
    let D2 = D * 5
    let v = l.b - l.a
    let
      left = initPoint(Real(0), Real(0)) !! initPoint(Real(0), Real(D2))
      right = initPoint(Real(D2), Real(0)) !! initPoint(Real(D2), Real(D2))
      bottom = initPoint(Real(0), Real(0)) !! initPoint(Real(D2), Real(0))
      top = initPoint(Real(0), Real(D2)) !! initPoint(Real(D2), Real(D2))
      li = intersect(left, l)
      ri = intersect(right, l)
      bi = intersect(bottom, l)
      ti = intersect(top, l)
    if li:
      let lp = crossPoint(left, l)
      if ri:
        return lp -- crossPoint(right, l)
      elif bi:
        return lp -- crossPoint(bottom, l)
      elif ti:
        return lp -- crossPoint(top, l)
    elif ri:
      let rp = crossPoint(right, l)
      if ti:
        return rp -- crossPoint(top, l)
      elif bi:
        return rp -- crossPoint(bottom, l)
    elif bi:
      let bp = crossPoint(bottom, l)
      if ti:
        return bp -- crossPoint(top, l)
    return l

  result.Ctl.onDraw = proc(e:DrawEvent) =
    let Cv=e.control.canvas
  
    Cv.areaColor=rgb(255,240,180)
    Cv.fill()
    s[].setCanvasSize()

    for (p, label, col) in s[].p:
      let p = s[].convert p
      Cv.areaColor = col
      Cv.drawEllipseArea(p.re.int - 3, p.im.int - 3, 6, 6)
      Cv.textColor = col
      Cv.drawText(label, p.re.int + 10, p.im.int - 20)
    for (l, label, col) in s[].l:
      let l = s[].convert l
      Cv.lineColor = col
      let l2 = getLineEndpoints(l)
      Cv.drawLine(l2.a.re.int, l2.a.im.int, l2.b.re.int, l2.b.im.int)
      Cv.textColor = col
      Cv.drawText(label, l.a.re.int + 10, l.a.im.int - 20)
    for (l, label, col) in s[].s:
      let l = s[].convert l
      Cv.lineColor = col
      Cv.drawLine(l.a.re.int, l.a.im.int, l.b.re.int, l.b.im.int)
      Cv.textColor = col
      Cv.drawText(label, l.a.re.int + 10, l.a.im.int - 20)
    for (c, label, col) in s[].c:
      let c = s[].convert c
      Cv.lineColor = col
      Cv.drawArcOutline(c.p.re.int, c.p.im.int, c.r, 0.0, PI * 2.0)
      Cv.textColor = col
      Cv.drawText(label, (c.p.re + c.r/2.0).int, (c.p.im - c.r/2.0).int)
    for (poly, label, col) in s[].poly:
      let poly = s[].convert poly
      Cv.lineColor = col
      for i in 0..<poly.len:
        let
          p = poly[i]
          q = poly[(i + 1) mod poly.len]
        Cv.drawLine(p.re.int, p.im.int, q.re.int, q.im.int)
      let p = poly[0]
      Cv.textColor = col
      Cv.drawText(label, p.re.int + 10, p.im.int - 20)
# }}}

proc add*[Real](self: var Canvas[Real], p:auto, label = "", color = rgb(0, 0, 0)) =
  when p is Point:
    self.canvas_data.p.add((p, label, color))
  elif p is Line:
    self.canvas_data.l.add((p, label, color))
  elif p is Segment:
    self.canvas_data.s.add((p, label, color))
  elif p is Circle:
    self.canvas_data.c.add((p, label, color))
  elif p is Polygon:
    self.canvas_data.poly.add((p, label, color))

proc show*[Real](self: Canvas[Real]) =
  self.Win.show()
  app.run()

