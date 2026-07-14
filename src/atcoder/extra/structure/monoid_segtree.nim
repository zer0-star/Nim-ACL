when not declared ATCODER_EXTRA_STRUCTURE_MONOID_SEGTREE_HPP:
  const ATCODER_EXTRA_STRUCTURE_MONOID_SEGTREE_HPP* = 1

  import atcoder/extra/monoid/monoid
  import atcoder/segtree
  import atcoder/lazysegtree

  export monoid
  export segtree
  export lazysegtree



  template descriptorOp(
      M,
      a,
      b: untyped
  ): untyped =
    when compiles(M.op(a, b)):
      M.op(a, b)
    elif compiles(default(M).op(a, b)):
      default(M).op(a, b)
    elif compiles(M().op(a, b)):
      M().op(a, b)
    else:
      {.error:
        "the Monoid descriptor does not expose op(a, b)"
      .}


  template descriptorIdentity(
      M: untyped
  ): untyped =
    when compiles(M.e()):
      M.e()
    elif compiles(default(M).e()):
      default(M).e()
    elif compiles(M().e()):
      M().e()
    elif compiles(M.unit()):
      M.unit()
    elif compiles(default(M).unit()):
      default(M).unit()
    elif compiles(M().unit()):
      M().unit()
    else:
      {.error:
        "the Monoid descriptor does not expose e() or unit()"
      .}


  template actionValueOp(
      A,
      a,
      b: untyped
  ): untyped =
    when compiles(descriptorOp(A.MS, a, b)):
      descriptorOp(A.MS, a, b)
    elif compiles(
      descriptorOp(default(A).MS, a, b)
    ):
      descriptorOp(default(A).MS, a, b)
    elif compiles(A.op(a, b)):
      A.op(a, b)
    elif compiles(default(A).op(a, b)):
      default(A).op(a, b)
    else:
      {.error:
        "the ActionMonoid descriptor does not expose its value operation"
      .}


  template actionValueIdentity(
      A: untyped
  ): untyped =
    when compiles(descriptorIdentity(A.MS)):
      descriptorIdentity(A.MS)
    elif compiles(
      descriptorIdentity(default(A).MS)
    ):
      descriptorIdentity(default(A).MS)
    elif compiles(A.e()):
      A.e()
    elif compiles(default(A).e()):
      default(A).e()
    else:
      {.error:
        "the ActionMonoid descriptor does not expose its value identity"
      .}


  template actionMapping(
      A,
      f,
      x: untyped
  ): untyped =
    when compiles(A.mapping(f, x)):
      A.mapping(f, x)
    elif compiles(default(A).mapping(f, x)):
      default(A).mapping(f, x)
    elif compiles(A().mapping(f, x)):
      A().mapping(f, x)
    else:
      {.error:
        "the ActionMonoid descriptor does not expose mapping(f, x)"
      .}


  template actionComposition(
      A,
      f,
      g: untyped
  ): untyped =
    when compiles(descriptorOp(A.MF, f, g)):
      descriptorOp(A.MF, f, g)
    elif compiles(
      descriptorOp(default(A).MF, f, g)
    ):
      descriptorOp(default(A).MF, f, g)
    elif compiles(A.composition(f, g)):
      A.composition(f, g)
    elif compiles(
      default(A).composition(f, g)
    ):
      default(A).composition(f, g)
    else:
      {.error:
        "the ActionMonoid descriptor does not expose composition"
      .}


  template actionIdentity(
      A: untyped
  ): untyped =
    when compiles(descriptorIdentity(A.MF)):
      descriptorIdentity(A.MF)
    elif compiles(
      descriptorIdentity(default(A).MF)
    ):
      descriptorIdentity(default(A).MF)
    elif compiles(A.id()):
      A.id()
    elif compiles(default(A).id()):
      default(A).id()
    else:
      {.error:
        "the ActionMonoid descriptor does not expose its action identity"
      .}


  template initSegTree*(
      M: typedesc,
      values: untyped
  ): untyped =
    block:
      type S = typeof(descriptorIdentity(M))

      proc facadeOp(
          a,
          b: S
      ): S =
        descriptorOp(M, a, b)

      proc facadeIdentity(): S =
        descriptorIdentity(M)

      segtree.initSegTree[S](
        values,
        facadeOp,
        facadeIdentity,
      )


  template initSegTree*(
      M: typedesc,
      n: int
  ): untyped =
    block:
      type S = typeof(descriptorIdentity(M))

      doAssert n >= 0

      let count =
        if n >= 0:
          n
        else:
          0

      let identity = descriptorIdentity(M)
      var values = newSeq[S](count)

      for i in 0 ..< count:
        values[i] = identity

      initSegTree(
        M,
        values,
      )


  template initLazySegTree*(
      A: typedesc,
      values: untyped
  ): untyped =
    block:
      type S = typeof(actionValueIdentity(A))
      type F = typeof(actionIdentity(A))

      proc facadeOp(
          a,
          b: S
      ): S =
        actionValueOp(A, a, b)

      proc facadeIdentity(): S =
        actionValueIdentity(A)

      proc facadeMapping(
          f: F,
          x: S
      ): S =
        actionMapping(A, f, x)

      proc facadeComposition(
          f,
          g: F
      ): F =
        actionComposition(A, f, g)

      proc facadeActionIdentity(): F =
        actionIdentity(A)

      when compiles(
        lazysegtree.initLazySegTree[S, F](
          values,
          facadeOp,
          facadeIdentity,
          facadeMapping,
          facadeComposition,
          facadeActionIdentity,
        )
      ):
        lazysegtree.initLazySegTree[S, F](
          values,
          facadeOp,
          facadeIdentity,
          facadeMapping,
          facadeComposition,
          facadeActionIdentity,
        )

      elif compiles(
        lazysegtree.initLazySegTree(
          values,
          facadeOp,
          facadeIdentity,
          facadeMapping,
          facadeComposition,
          facadeActionIdentity,
        )
      ):
        lazysegtree.initLazySegTree(
          values,
          facadeOp,
          facadeIdentity,
          facadeMapping,
          facadeComposition,
          facadeActionIdentity,
        )

      elif compiles(
        lazysegtree.initLazySegTree[S, F](
          facadeOp,
          facadeIdentity,
          facadeMapping,
          facadeComposition,
          facadeActionIdentity,
          values,
        )
      ):
        lazysegtree.initLazySegTree[S, F](
          facadeOp,
          facadeIdentity,
          facadeMapping,
          facadeComposition,
          facadeActionIdentity,
          values,
        )

      elif compiles(
        lazysegtree.initLazySegTree(
          facadeOp,
          facadeIdentity,
          facadeMapping,
          facadeComposition,
          facadeActionIdentity,
          values,
        )
      ):
        lazysegtree.initLazySegTree(
          facadeOp,
          facadeIdentity,
          facadeMapping,
          facadeComposition,
          facadeActionIdentity,
          values,
        )

      else:
        {.error:
          "no compatible LazySegTree callback constructor was found"
        .}


  template initLazySegTree*(
      A: typedesc,
      n: int
  ): untyped =
    block:
      type S = typeof(actionValueIdentity(A))

      doAssert n >= 0

      let count =
        if n >= 0:
          n
        else:
          0

      let identity = actionValueIdentity(A)
      var values = newSeq[S](count)

      for i in 0 ..< count:
        values[i] = identity

      initLazySegTree(
        A,
        values,
      )
