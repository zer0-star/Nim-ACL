when not declared ATCODER_SLICEUTILS_HPP:
  const ATCODER_SLICEUTILS_HPP* = 1
  proc index*[T](a:openArray[T]):Slice[int] =
    a.low..a.high
  type ReversedSlice[T] = distinct Slice[T]
  type StepSlice[T] = object
    s:Slice[T]
    d:T
  proc reversed*[T](p:Slice[T]):auto = ReversedSlice[T](p)
  iterator items*[T](p:ReversedSlice[T]):T =
    var i = Slice[T](p).b
    while true:
      yield i
      if i == Slice[T](p).a:break
      i.dec
  proc `>>`*[T](s:Slice[T], d:T):StepSlice[T] =
    assert d != 0
    StepSlice[T](s:s, d:d)
  proc `<<`*[T](s:Slice[T], d:T):StepSlice[T] =
    assert d != 0
    StepSlice[T](s:s, d: -d)
  proc low*[T](s:StepSlice[T]):T = s.s.a
  proc high*[T](s:StepSlice[T]):T =
    let p = s.s.b - s.s.a
    if p < 0: return s.low - 1
    let d = abs(s.d)
    return s.s.a + (p div d) * d
  iterator items*[T](p:StepSlice[T]):T = 
    assert p.d != 0
    if p.s.a <= p.s.b:
      if p.d > 0:
        var i = p.low
        let h = p.high
        while true:
          yield i
          if i == h: break
          i += p.d
      else:
        var i = p.high
        let l = p.low
        while true:
          yield i
          if i == l: break
          i += p.d
  proc `[]`*[T:SomeInteger, U](a:openArray[U], s:Slice[T]):seq[U] =
    for i in s:result.add(a[i])
  proc `[]=`*[T:SomeInteger, U](a:var openArray[U], s:StepSlice[T], b:openArray[U]) =
    var j = 0
    for i in s:
      a[i] = b[j]
      j.inc
