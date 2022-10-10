---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':question:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':question:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':question:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/geometry/geometry_template.nim
    title: atcoder/extra/geometry/geometry_template.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/geometry/geometry_template.nim
    title: atcoder/extra/geometry/geometry_template.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/geometry/geometry_template.nim
    title: atcoder/extra/geometry/geometry_template.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/geometry/geometry_template.nim
    title: atcoder/extra/geometry/geometry_template.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/geometry/polygon.nim
    title: atcoder/extra/geometry/polygon.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/geometry/polygon.nim
    title: atcoder/extra/geometry/polygon.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/geometry/polygon.nim
    title: atcoder/extra/geometry/polygon.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/geometry/polygon.nim
    title: atcoder/extra/geometry/polygon.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/other/floatutils.nim
    title: atcoder/extra/other/floatutils.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/other/floatutils.nim
    title: atcoder/extra/other/floatutils.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/other/floatutils.nim
    title: atcoder/extra/other/floatutils.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/other/floatutils.nim
    title: atcoder/extra/other/floatutils.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/other/internal_complex.nim
    title: atcoder/extra/other/internal_complex.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/other/internal_complex.nim
    title: atcoder/extra/other/internal_complex.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/other/internal_complex.nim
    title: atcoder/extra/other/internal_complex.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/other/internal_complex.nim
    title: atcoder/extra/other/internal_complex.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/other/static_var.nim
    title: atcoder/extra/other/static_var.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/other/static_var.nim
    title: atcoder/extra/other/static_var.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/other/static_var.nim
    title: atcoder/extra/other/static_var.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/other/static_var.nim
    title: atcoder/extra/other/static_var.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.7/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.7/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "import std/math\nimport atcoder/extra/other/floatutils\nimport atcoder/extra/geometry/geometry_template\n\
    import atcoder/extra/geometry/polygon\n\nimport nigui\n\nconst D = 900\n\ntype\
    \ CanvasData[Real] = object\n  p: seq[(Point[Real], string, Color)]\n  l: seq[(Line[Real],\
    \ string, Color)]\n  s: seq[(Segment[Real], string, Color)]\n  c: seq[(Circle[Real],\
    \ string, Color)]\n  poly: seq[(Polygon[Real], string, Color)]\n  width, height:\
    \ int\n  xmin, ymin: float\n  d: float\n\n\nproc convert[Real](self:CanvasData[Real],\
    \ p:Point[Real]):Point[Real] =\n  return initPoint((p.re - self.xmin)/self.d *\
    \ D, D - (p.im - self.ymin)/self.d * D)\nproc convert[Real](self:CanvasData[Real],\
    \ c:Circle[Real]):Circle[Real] =\n  return initCircle(self.convert c.p, c.r/self.d*D)\n\
    proc convert[Real](self:CanvasData[Real], l:Line[Real]):Line[Real] =\n  return\
    \ initLine(self.convert l.a, self.convert l.b)\nproc convert[Real](self:CanvasData[Real],\
    \ l:Segment[Real]):Segment[Real] =\n  return initSegment(self.convert l.a, self.convert\
    \ l.b)\nproc convert[Real](self:CanvasData[Real], p:Polygon[Real]):Polygon[Real]\
    \ =\n  for p in p: result.add(self.convert p)\n\nconst MARGIN = 5.0\n\nproc setCanvasSize[Real](self:\
    \ var CanvasData[Real]) =\n  var\n    xmin = float.inf\n    xmax = -float.inf\n\
    \    ymin = float.inf\n    ymax = -float.inf\n  proc update(p:Point[Real]) =\n\
    \    xmin.min=p.re\n    xmax.max=p.re\n    ymin.min=p.im\n    ymax.max=p.im\n\
    \  for p in self.p:\n    update(p[0])\n  for p in self.s:\n    update(p[0].a)\n\
    \    update(p[0].b)\n  for p in self.c:\n    let\n      c = p[0].p\n      r =\
    \ p[0].r\n    update(initPoint(c.re+r,c.im+r))\n    update(initPoint(c.re-r,c.im-r))\n\
    \  xmin -= MARGIN;ymin -= MARGIN\n  xmax += MARGIN;ymax += MARGIN\n  let d = max(xmax\
    \ - xmin, ymax - ymin)\n  self.xmin = xmin\n  self.ymin = ymin\n  self.d = d\n\
    \  \n\ntype Canvas[Real] = object\n  Win: Window\n  Ctl: Control\n  canvas_data:\
    \ CanvasData[Real]\n\n# initCanvas {{{\nproc initCanvas*[Real]():Canvas[Real]\
    \ =\n  result = Canvas[Real]()\n  app.init()\n  result = Canvas[Real](Win:newWindow(\"\
    Canvas\"), Ctl:newControl(), canvas_data: CanvasData[Real]())\n  result.Ctl.widthMode\
    \ = WidthMode_Fill\n  result.Ctl.heightMode = HeightMode_Fill\n  result.Win.add(result.Ctl)\n\
    \  result.Win.width = D\n  result.Win.height = D\n  var s = result.canvas_data.addr\n\
    \n  result.Ctl.onClick = proc(c:ClickEvent)=\n    echo \"Canvas\"\n\n  proc getLineEndpoints(l:Line[Real]):Line[Real]\
    \ =\n    let D2 = D * 5\n    let v = l.b - l.a\n    let\n      left = initPoint(Real(0),\
    \ Real(0)) !! initPoint(Real(0), Real(D2))\n      right = initPoint(Real(D2),\
    \ Real(0)) !! initPoint(Real(D2), Real(D2))\n      bottom = initPoint(Real(0),\
    \ Real(0)) !! initPoint(Real(D2), Real(0))\n      top = initPoint(Real(0), Real(D2))\
    \ !! initPoint(Real(D2), Real(D2))\n      li = intersect(left, l)\n      ri =\
    \ intersect(right, l)\n      bi = intersect(bottom, l)\n      ti = intersect(top,\
    \ l)\n    if li:\n      let lp = crossPoint(left, l)\n      if ri:\n        return\
    \ lp -- crossPoint(right, l)\n      elif bi:\n        return lp -- crossPoint(bottom,\
    \ l)\n      elif ti:\n        return lp -- crossPoint(top, l)\n    elif ri:\n\
    \      let rp = crossPoint(right, l)\n      if ti:\n        return rp -- crossPoint(top,\
    \ l)\n      elif bi:\n        return rp -- crossPoint(bottom, l)\n    elif bi:\n\
    \      let bp = crossPoint(bottom, l)\n      if ti:\n        return bp -- crossPoint(top,\
    \ l)\n    return l\n\n  result.Ctl.onDraw = proc(e:DrawEvent) =\n    let Cv=e.control.canvas\n\
    \  \n    Cv.areaColor=rgb(255,240,180)\n    Cv.fill()\n    s[].setCanvasSize()\n\
    \n    for (p, label, col) in s[].p:\n      let p = s[].convert p\n      Cv.areaColor\
    \ = col\n      Cv.drawEllipseArea(p.re.int - 3, p.im.int - 3, 6, 6)\n      Cv.textColor\
    \ = col\n      Cv.drawText(label, p.re.int + 10, p.im.int - 20)\n    for (l, label,\
    \ col) in s[].l:\n      let l = s[].convert l\n      Cv.lineColor = col\n    \
    \  let l2 = getLineEndpoints(l)\n      Cv.drawLine(l2.a.re.int, l2.a.im.int, l2.b.re.int,\
    \ l2.b.im.int)\n      Cv.textColor = col\n      Cv.drawText(label, l.a.re.int\
    \ + 10, l.a.im.int - 20)\n    for (l, label, col) in s[].s:\n      let l = s[].convert\
    \ l\n      Cv.lineColor = col\n      Cv.drawLine(l.a.re.int, l.a.im.int, l.b.re.int,\
    \ l.b.im.int)\n      Cv.textColor = col\n      Cv.drawText(label, l.a.re.int +\
    \ 10, l.a.im.int - 20)\n    for (c, label, col) in s[].c:\n      let c = s[].convert\
    \ c\n      Cv.lineColor = col\n      Cv.drawArcOutline(c.p.re.int, c.p.im.int,\
    \ c.r, 0.0, PI * 2.0)\n      Cv.textColor = col\n      Cv.drawText(label, (c.p.re\
    \ + c.r/2.0).int, (c.p.im - c.r/2.0).int)\n    for (poly, label, col) in s[].poly:\n\
    \      let poly = s[].convert poly\n      Cv.lineColor = col\n      for i in 0..<poly.len:\n\
    \        let\n          p = poly[i]\n          q = poly[(i + 1) mod poly.len]\n\
    \        Cv.drawLine(p.re.int, p.im.int, q.re.int, q.im.int)\n      let p = poly[0]\n\
    \      Cv.textColor = col\n      Cv.drawText(label, p.re.int + 10, p.im.int -\
    \ 20)\n# }}}\n\nproc add*[Real](self: var Canvas[Real], p:auto, label = \"\",\
    \ color = rgb(0, 0, 0)) =\n  when p is Point:\n    self.canvas_data.p.add((p,\
    \ label, color))\n  elif p is Line:\n    self.canvas_data.l.add((p, label, color))\n\
    \  elif p is Segment:\n    self.canvas_data.s.add((p, label, color))\n  elif p\
    \ is Circle:\n    self.canvas_data.c.add((p, label, color))\n  elif p is Polygon:\n\
    \    self.canvas_data.poly.add((p, label, color))\n\nproc show*[Real](self: Canvas[Real])\
    \ =\n  self.Win.show()\n  app.run()\n\n"
  dependsOn:
  - atcoder/extra/other/internal_complex.nim
  - atcoder/extra/other/floatutils.nim
  - atcoder/extra/other/static_var.nim
  - atcoder/extra/geometry/polygon.nim
  - atcoder/extra/geometry/geometry_template.nim
  - atcoder/element_concepts.nim
  - atcoder/extra/other/floatutils.nim
  - atcoder/extra/geometry/polygon.nim
  - atcoder/element_concepts.nim
  - atcoder/extra/other/internal_complex.nim
  - atcoder/extra/geometry/geometry_template.nim
  - atcoder/extra/other/static_var.nim
  - atcoder/extra/other/internal_complex.nim
  - atcoder/extra/other/floatutils.nim
  - atcoder/extra/other/static_var.nim
  - atcoder/extra/geometry/polygon.nim
  - atcoder/extra/geometry/geometry_template.nim
  - atcoder/element_concepts.nim
  - atcoder/extra/other/floatutils.nim
  - atcoder/extra/geometry/polygon.nim
  - atcoder/element_concepts.nim
  - atcoder/extra/other/internal_complex.nim
  - atcoder/extra/geometry/geometry_template.nim
  - atcoder/extra/other/static_var.nim
  isVerificationFile: false
  path: atcoder/extra/geometry/visualizer.nim
  requiredBy: []
  timestamp: '2022-08-25 23:07:00+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/geometry/visualizer.nim
layout: document
redirect_from:
- /library/atcoder/extra/geometry/visualizer.nim
- /library/atcoder/extra/geometry/visualizer.nim.html
title: atcoder/extra/geometry/visualizer.nim
---
