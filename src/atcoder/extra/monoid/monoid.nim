when not declared ATCODER_EXTRA_MONOID_MONOID_HPP:
  const ATCODER_EXTRA_MONOID_MONOID_HPP* = 1

  type Monoid* = concept C, type T
    type E = T.value_type()
    var x, y: E
    T.op(x, y) is E
    T.e() is E

  type InversibleMonoid* = concept C, type T
    T is Monoid
    type E = T.value_type()
    var x: E
    T.inv(x) is E

  type ActedMonoid* = concept C, type T
    T.MS is Monoid
    T.MF is Monoid
    var x, y: T.S
    var f, g: T.F
    T.op(x, y) is T.S
    T.e() is T.S
    T.composition(f, g) is T.F
    T.id() is T.F
    T.mapping(f, x) is T.S

  type MonoidBase*[E; op: static[proc], e: static[proc], inv: static[proc or bool]] = object

  template MonoidType*(E: typedesc, op0, e0: untyped, inv0: untyped): typedesc[MonoidBase] =
    proc op1(a, b: E): E {.gensym, inline.} = op0(a, b)
    proc e1(): E {.gensym, inline.} = e0()
    proc inv1(a: E): E {.gensym, inline.} = inv0(a)
    MonoidBase[E, op1, e1, inv1]

  template MonoidType*(E: typedesc, op0, e0: untyped): typedesc[MonoidBase] =
    proc op1(a, b: E): E {.gensym, inline.} = op0(a, b)
    proc e1(): E {.gensym, inline.} = e0()
    MonoidBase[E, op1, e1, false]

  template MonoidOf*(E: typedesc, op0, e0: untyped): untyped =
    MonoidType(E, op0, e0)

  template GroupOf*(E: typedesc, op0, e0, inv0: untyped): untyped =
    MonoidType(E, op0, e0, inv0)

  template value_type*[T: MonoidBase](_: typedesc[T]): typedesc =
    T.E

  proc op*[T: MonoidBase](_: typedesc[T], a, b: T.E): T.E =
    T.op(a, b)

  proc e*[T: MonoidBase](_: typedesc[T]): T.E =
    T.e()

  proc inv*[T: MonoidBase](_: typedesc[T], a: T.E): T.E =
    T.inv(a)

  type ActedMonoidBase*[MS, MF; p: static[tuple]] = object

  template ActedMonoidType*(MS, MF: typedesc, mapping0: untyped): typedesc[ActedMonoidBase] =
    type
      S = MS.value_type
      F = MF.value_type
    proc mapping1(f: F, s: S): S {.gensym, inline.} = mapping0(f, s)
    ActedMonoidBase[MS, MF, (mapping1,)]

  template ActedMonoidOf*(MS, MF: typedesc, mapping0: untyped): untyped =
    ActedMonoidType(MS, MF, mapping0)


  template useMonoid*(Name, E, op0, e0: untyped): untyped =
    type Name = MonoidType(E, op0, e0)

  template useGroup*(Name, E, op0, e0, inv0: untyped): untyped =
    type Name = MonoidType(E, op0, e0, inv0)

  template useActedMonoid*(Name, MS, MF, mapping0: untyped): untyped =
    type Name = ActedMonoidType(MS, MF, mapping0)

  template S*[T: ActedMonoidBase](_: typedesc[T]): typedesc =
    T.MS.value_type

  template F*[T: ActedMonoidBase](_: typedesc[T]): typedesc =
    T.MF.value_type

  proc op*[T: ActedMonoidBase](_: typedesc[T], a, b: T.S): T.S =
    T.MS.op(a, b)

  proc e*[T: ActedMonoidBase](_: typedesc[T]): T.S =
    T.MS.e()

  proc composition*[T: ActedMonoidBase](_: typedesc[T], a, b: T.F): T.F =
    T.MF.op(a, b)

  proc id*[T: ActedMonoidBase](_: typedesc[T]): T.F =
    T.MF.e()

  proc mapping*[T: ActedMonoidBase](_: typedesc[T], f: T.F, s: T.S): T.S =
    T.p[0](f, s)


  template useActionMonoid*(
      Name,
      MF,
      MS,
      mapping0: untyped
  ): untyped =
    ## Defines an acted monoid using the public semantic order
    ## action monoid F, followed by value monoid S.
    ##
    ## The existing implementation order is preserved internally.
    useActedMonoid(
      Name,
      MS,
      MF,
      mapping0,
    )

  # BEGIN NIM_ACL_COMMUTATIVE_MONOID_V1

  type
    CommutativeMonoidBase*[M] = object

  type CommutativeMonoid* = concept C, type T
    T is CommutativeMonoidBase
    T.M is Monoid

  template CommutativeMonoidType*(
      M: typedesc
  ): typedesc[CommutativeMonoidBase] =
    ## Marks an existing Monoid type as commutative.
    ##
    ## Commutativity is an algebraic contract supplied by the caller.
    CommutativeMonoidBase[M]

  template CommutativeMonoidOf*(
      E: typedesc,
      op0,
      e0: untyped
  ): untyped =
    CommutativeMonoidType(
      MonoidType(E, op0, e0)
    )

  template useCommutativeMonoid*(
      Name,
      E,
      op0,
      e0: untyped
  ): untyped =
    type Name =
      CommutativeMonoidOf(
        E,
        op0,
        e0,
      )

  template value_type*[
      T: CommutativeMonoidBase
  ](
      _: typedesc[T]
  ): typedesc =
    T.M.value_type

  proc op*[
      T: CommutativeMonoidBase
  ](
      _: typedesc[T],
      a,
      b: T.M.value_type
  ): T.M.value_type {.inline.} =
    T.M.op(a, b)

  proc e*[
      T: CommutativeMonoidBase
  ](
      _: typedesc[T]
  ): T.M.value_type {.inline.} =
    T.M.e()

  # END NIM_ACL_COMMUTATIVE_MONOID_V1
