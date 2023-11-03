when not declared ATCODER_CUMULATIVE_MONOID_HPP:
  const ATCODER_CUMULATIVE_MONOID_HPP* = 1
  import std/sequtils

  type CumulativeMonoid*[M; p:static[tuple]; reverse:static[bool]] = object
    size*:int
    d*: seq[M]
  template calc_op*[ST:CumulativeMonoid](self:ST or typedesc[ST], a, b:ST.M):auto =
    block:
      let u = ST.p.op(a, b)
      u
  template calc_e*[ST:CumulativeMonoid](self:ST or typedesc[ST]):auto =
    block:
      let u = ST.p.e()
      u

  proc init*[ST:CumulativeMonoid](self: var ST, v:seq[ST.M]) =
    let n = v.len+1
    self.size = n
    self.d = newSeqWith(n, ST.calc_e())
    if not ST.reverse:
      for i in 1..<n:
        self.d[i] = ST.calc_op(self.d[i-1], v[i-1])
    else:
      for i in countdown(n-2,0):
        self.d[i] = ST.calc_op(self.d[i+1], v[i])
  proc init*[ST:CumulativeMonoid](self: var ST, n:int) =
    self.init(newSeqWith(n, ST.calc_e()))
  proc init*[ST:CumulativeMonoid](self: typedesc[ST], v:seq[ST.M]):auto =
    result = ST()
    result.init(v)
  proc init*[ST:CumulativeMonoid](self: typedesc[ST], n:int):auto =
    self.init(newSeqWith(n, ST.calc_e()))
  template CumulativeMonoidType*[M](op0, e0, reverse:untyped):typedesc[CumulativeMonoid] =
    proc op1(l, r:M):M {.gensym inline.} = op0(l, r)
    proc e1():M {.gensym inline.} = e0()
    CumulativeMonoid[M, (op:op1, e:e1), reverse]

  template initCumulativeMonoid*[M](v:seq[M] or int, op, e:untyped):auto =
    CumulativeMonoidType[M](op, e, false).init(v)
  template initCumulativeMonoidRev*[M](v:seq[M] or int, op, e:untyped):auto =
    CumulativeMonoidType[M](op, e, true).init(v)

  proc `[]`*[ST:CumulativeMonoid](self: var typedesc[ST], i: int):ST.M =
      return self.d[i]

# example code:
#   var x = @[1,5,3,2,6]
#   echo initCumulativeMonoid(x, `+`, () => 0)
#   echo initCumulativeMonoidRev(x, `+`, () => 0)
#   echo initCumulativeMonoid(x, max, () => 0)
#   echo initCumulativeMonoid(x, max, () => 0).d[5]
# output:
#   (size: 6, d: @[0, 1, 6, 9, 11, 17])
#   (size: 6, d: @[17, 16, 11, 8, 6, 0])
#   (size: 6, d: @[0, 1, 5, 5, 5, 6])
#   6

# example
import std/sugar
var x = @[1,5,3,2,6]
echo initCumulativeMonoid(x, `+`, () => 0)
echo initCumulativeMonoidRev(x, `+`, () => 0)
echo initCumulativeMonoid(x, max, () => 0).d[5]

import atcoder/extra/math/matrix
let unit = StaticMatrixType(int).unit(2) # [[1,0],[0,1]]
var ms = newSeqWith(5, unit)
echo initCumulativeMonoid[StaticMatrix](`*`, ()=>unit, false).init(ms)

