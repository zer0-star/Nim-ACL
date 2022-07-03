---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.5/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.5/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_DICE:\n  const ATCODER_DICE* = 1\n  type FACE*\
    \ = enum\n    TOP, BOTTOM, FRONT, BACK, LEFT, RIGHT\n  \n  type dice*[T] = object\n\
    \    val:array[6, T]\n    id:array[6, int]\n  \n  proc initDice*[T]():dice[T]\
    \ =\n    var id:array[6, int]\n    id[TOP.int] = 0; id[FRONT.int] = 1; id[LEFT.int]\
    \ = 2;\n    id[RIGHT.int] = 3; id[BACK.int] = 4; id[BOTTOM.int] = 5\n    result.id\
    \ = id\n  \n  proc `[]`*[T](self:dice[T], f:FACE):T = self.val[self.id[f.int]]\n\
    \  proc `[]=`*[T](self:var dice[T], f:FACE, t:T) = self.val[self.id[f.int]] =\
    \ t\n  \n  proc `==`*[T](self, b:dice[T]):bool =\n    return self[TOP] == b[TOP]\
    \ and self[BOTTOM] == b[BOTTOM] and\n           self[FRONT] == b[FRONT] and self[BACK]\
    \ == b[BACK] and\n           self[LEFT] == b[LEFT] and self[RIGHT] == b[RIGHT]\n\
    \  \n  proc roll*[T](self: var dice[T], a, b, c, d:FACE) =\n    let tmp = self.id[a.int]\n\
    \    self.id[a.int] = self.id[b.int]; self.id[b.int] = self.id[c.int];\n    self.id[c.int]\
    \ = self.id[d.int]; self.id[d.int] = tmp\n  \n  proc roll_x*[T](self:var dice[T])\
    \ = self.roll(TOP, BACK, BOTTOM, FRONT)\n  proc roll_y*[T](self:var dice[T]) =\
    \ self.roll(TOP, LEFT, BOTTOM, RIGHT)\n  proc roll_z*[T](self:var dice[T]) = self.roll(FRONT,\
    \ RIGHT, BACK, LEFT)\n  \n  proc all_rolls*[T](self:dice[T]):seq[dice[T]] =\n\
    \    var dice = dice\n    var k = 0\n    while k < 6:\n      var i = 0\n     \
    \ while i < 4:\n        result.add(dice)\n        self.roll_z()\n        i.inc\n\
    \      if (k and 1) != 0: self.roll_y()\n      else: self.roll_x()\n      k.inc\n\
    \  \n  proc equivalent_to*[T](self, di: dice[T]):bool =\n    var self = self\n\
    \    var k = 0\n    while k < 6:\n      var i = 0\n      while i < 4:\n      \
    \  if self == di: return true\n        self.roll_z()\n        i.inc\n      if\
    \ (k and 1) != 0: self.roll_y()\n      else: self.roll_x()\n      k.inc\n    return\
    \ false\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/other/dice.nim
  requiredBy: []
  timestamp: '2021-04-18 04:42:38+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/other/dice.nim
layout: document
redirect_from:
- /library/atcoder/extra/other/dice.nim
- /library/atcoder/extra/other/dice.nim.html
title: atcoder/extra/other/dice.nim
---
