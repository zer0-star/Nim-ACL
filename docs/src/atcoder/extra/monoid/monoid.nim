when not declared ATCODER_MONOID_HPP:
  const ATCODER_MONOID_HPP* = 1

  type Monoid* = concept C, type T
    type E = T.value_type()
    var x, y: E
    T.op(x, y) is E
    T.e() is E
  type InversibleMonoid* = concept C, type T
    echo T is Monoid
    T is Monoid
    type E = T.value_type()
    var x: E
    T.inv(x) is E
  
  type ActedMonoid* = concept C, type T
    T.MS is Monoid
    T.MF is Monoid
    var
      x, y: T.S
      f, g: T.F
    T.op(x, y) is T.S
    T.e() is T.S
    T.composition(f, g) is T.F
    T.id() is T.F
    T.mapping(f, x) is T.S

  type MonoidBase*[E; op:static[proc], e:static[proc], inv:static[proc or bool]] = object

  template MonoidType*(E:typedesc, op0, e0: untyped, inv0: untyped):typedesc[MonoidBase] =
    proc op1(a, b:E):E {.gensym inline.} = op0(a, b)
    proc e1():E {.gensym inline.} = e0()
    proc inv1(a:E):E {.gensym inline.} = inv0(a)
    MonoidBase[E, op1, e1, inv1]
  template MonoidType*(E:typedesc, op0, e0: untyped):typedesc[MonoidBase] =
    proc op1(a, b:E):E {.gensym inline.} = op0(a, b)
    proc e1():E {.gensym inline.} = e0()
    MonoidBase[E, op1, e1, false]
  template value_type*[T:MonoidBase](_: typedesc[T]):typedesc = T.E

  type ActedMonoidBase*[MS, MF; p:static[tuple]] = object
    discard
  
  template ActedMonoidType*(MS, MF: typedesc, mapping0: untyped):typedesc[ActedMonoidBase] =
    type
      S = MS.E
      F = MF.E
    proc mapping1(f:F, s:S):S {.gensym, inline.} = mapping0(f, s)
    ActedMonoidBase[MS, MF, (mapping1, )]

  template S*[T:ActedMonoidBase](_: typedesc[T]):typedesc = T.MS.value_type
  template F*[T:ActedMonoidBase](_: typedesc[T]):typedesc = T.MF.value_type
  proc op*[T:ActedMonoidBase](_:typedesc[T], a, b:T.S):T.S = T.MS.op(a, b)
  proc e*[T:ActedMonoidBase](_:typedesc[T]):T.S = T.MS.e()
  proc composition*[T:ActedMonoidBase](_:typedesc[T], a, b:T.F):T.F = T.MF.op(a, b)
  proc id*[T:ActedMonoidBase](_:typedesc[T]):T.F = T.MF.e()
  proc mapping*[T:ActedMonoidBase](_:typedesc[T], f:T.F, s:T.S):T.S = T.p[0](f, s)
