when not declared ATCODER_EXTRA_STRUCTURE_COMPRESSED_SEGTREE_2D_HPP:
  const ATCODER_EXTRA_STRUCTURE_COMPRESSED_SEGTREE_2D_HPP* = 1

  import std/algorithm
  import std/sequtils

  import atcoder/segtree
  import atcoder/extra/monoid/monoid

  export monoid

  type
    CompressedSegTree2D*[S; SegTree] = object
      ## Online point-update / rectangle-product data structure.
      ##
      ## Every coordinate that may be updated must be registered before
      ## construction. Rectangle products require a commutative monoid.
      N2*: int
      xs*: seq[int]
      ys*: seq[seq[int]]
      segt*: seq[SegTree]
      pointCountValue: int

    CompressedSegTree2DBuilder* = object
      points*: seq[tuple[x, y: int]]

  proc initCompressedSegTree2DBuilder*():
      CompressedSegTree2DBuilder {.inline.} =
    CompressedSegTree2DBuilder()

  proc addPoint*(
      builder: var CompressedSegTree2DBuilder,
      x,
      y: int
  ) {.inline.} =
    builder.points.add((x: x, y: y))

  proc registerPoint*(
      builder: var CompressedSegTree2DBuilder,
      x,
      y: int
  ) {.inline.} =
    builder.addPoint(x, y)

  proc addPoints*(
      builder: var CompressedSegTree2DBuilder,
      points: openArray[tuple[x, y: int]]
  ) =
    for point in points:
      builder.points.add(point)

  proc initCompressedSegTree2D*[
      CM: CommutativeMonoidBase
  ](
      points: openArray[tuple[x, y: int]],
      monoid: typedesc[CM]
  ): auto =
    ## Builds the fixed topology from the supplied coordinates.
    ##
    ## `monoid` is a type-level commutative-monoid descriptor.
    type
      S = CM.value_type

    proc forwardedOp(
        a,
        b: S
    ): S {.inline.} =
      CM.op(a, b)

    proc forwardedE(): S {.inline.} =
      CM.e()

    type
      InnerSegTree =
        SegTreeType[S](
          forwardedOp,
          forwardedE,
        )

    result =
      CompressedSegTree2D[
        S,
        InnerSegTree,
      ]()

    for point in points:
      result.xs.add(point.x)

    result.xs.sort()
    result.xs =
      result.xs.deduplicate(true)

    result.N2 = 1

    while result.N2 < result.xs.len:
      result.N2 *= 2

    result.ys.setLen(
      result.N2 * 2
    )

    result.segt.setLen(
      result.N2 * 2
    )

    for point in points:
      let xi =
        result.xs.lowerBound(point.x)

      var node =
        xi + result.N2

      while node > 0:
        result.ys[node].add(point.y)
        node = node shr 1

    for node in 1..<result.N2 * 2:
      result.ys[node].sort()

      result.ys[node] =
        result.ys[node].deduplicate(true)

      result.segt[node].init(
        result.ys[node].len
      )

    for xi in 0..<result.xs.len:
      result.pointCountValue +=
        result.ys[
          result.N2 + xi
        ].len

  proc build*[
      CM: CommutativeMonoidBase
  ](
      builder: CompressedSegTree2DBuilder,
      monoid: typedesc[CM]
  ): auto =
    initCompressedSegTree2D(
      builder.points,
      monoid,
    )

  proc pointCount*[
      ST: CompressedSegTree2D
  ](
      tree: ST
  ): int {.inline.} =
    ## Number of distinct registered coordinate pairs.
    tree.pointCountValue

  proc containsPoint*[
      ST: CompressedSegTree2D
  ](
      tree: ST,
      x,
      y: int
  ): bool =
    let xi = tree.xs.lowerBound(x)

    if (
      xi >= tree.xs.len or
      tree.xs[xi] != x
    ):
      return false

    let node = xi + tree.N2
    let yi = tree.ys[node].lowerBound(y)

    yi < tree.ys[node].len and
      tree.ys[node][yi] == y

  proc nodeValue[
      ST: CompressedSegTree2D
  ](
      tree: ST,
      node,
      y: int
  ): ST.S {.inline.} =
    let yi = tree.ys[node].lowerBound(y)

    if (
      yi < tree.ys[node].len and
      tree.ys[node][yi] == y
    ):
      tree.segt[node].get(yi)
    else:
      tree.SegTree.calc_e()

  proc set*[
      ST: CompressedSegTree2D
  ](
      tree: var ST,
      x,
      y: int,
      value: ST.S
  ) =
    ## Replaces the value stored at a registered coordinate.
    ##
    ## The x-leaf is changed directly. Each ancestor y-slot is then
    ## recomputed from its two children, so points with equal y but
    ## different x do not overwrite one another.
    let xi = tree.xs.lowerBound(x)

    doAssert (
      xi < tree.xs.len and
      tree.xs[xi] == x
    )

    var node = xi + tree.N2

    let leafYi =
      tree.ys[node].lowerBound(y)

    doAssert (
      leafYi < tree.ys[node].len and
      tree.ys[node][leafYi] == y
    )

    tree.segt[node][leafYi] = value

    node = node shr 1

    while node > 0:
      let yi =
        tree.ys[node].lowerBound(y)

      doAssert (
        yi < tree.ys[node].len and
        tree.ys[node][yi] == y
      )

      let leftValue =
        tree.nodeValue(
          node shl 1,
          y,
        )

      let rightValue =
        tree.nodeValue(
          (node shl 1) or 1,
          y,
        )

      tree.segt[node][yi] =
        tree.SegTree.calc_op(
          leftValue,
          rightValue,
        )

      node = node shr 1

  proc combineAt*[
      ST: CompressedSegTree2D
  ](
      tree: var ST,
      x,
      y: int,
      value: ST.S
  ) =
    ## Replaces the point value `current` by `op(current, value)`.
    let xi = tree.xs.lowerBound(x)

    doAssert (
      xi < tree.xs.len and
      tree.xs[xi] == x
    )

    var node = xi + tree.N2

    while node > 0:
      let yi =
        tree.ys[node].lowerBound(y)

      doAssert (
        yi < tree.ys[node].len and
        tree.ys[node][yi] == y
      )

      tree.segt[node][yi] =
        tree.SegTree.calc_op(
          tree.segt[node].get(yi),
          value,
        )

      node = node shr 1

  proc get*[
      ST: CompressedSegTree2D
  ](
      tree: ST,
      x,
      y: int
  ): ST.S =
    let xi = tree.xs.lowerBound(x)

    doAssert (
      xi < tree.xs.len and
      tree.xs[xi] == x
    )

    let node = xi + tree.N2
    let yi = tree.ys[node].lowerBound(y)

    doAssert (
      yi < tree.ys[node].len and
      tree.ys[node][yi] == y
    )

    tree.segt[node].get(yi)

  proc prod*[
      ST: CompressedSegTree2D
  ](
      tree: ST,
      xLeft,
      xRight,
      yLeft,
      yRight: int
  ): ST.S =
    ## Returns the product over
    ## `[xLeft, xRight) × [yLeft, yRight)`.
    if (
      xLeft >= xRight or
      yLeft >= yRight
    ):
      return tree.SegTree.calc_e()

    var left =
      tree.xs.lowerBound(xLeft) +
      tree.N2

    var right =
      tree.xs.lowerBound(xRight) +
      tree.N2

    var productLeft =
      tree.SegTree.calc_e()

    var productRight =
      tree.SegTree.calc_e()

    while left < right:
      if (left and 1) != 0:
        let yBegin =
          tree.ys[left].lowerBound(yLeft)

        let yEnd =
          tree.ys[left].lowerBound(yRight)

        productLeft =
          tree.SegTree.calc_op(
            productLeft,
            tree.segt[left].prod(
              yBegin..<yEnd
            ),
          )

        left.inc()

      if (right and 1) != 0:
        right.dec()

        let yBegin =
          tree.ys[right].lowerBound(yLeft)

        let yEnd =
          tree.ys[right].lowerBound(yRight)

        productRight =
          tree.SegTree.calc_op(
            tree.segt[right].prod(
              yBegin..<yEnd
            ),
            productRight,
          )

      left = left shr 1
      right = right shr 1

    tree.SegTree.calc_op(
      productLeft,
      productRight,
    )

  proc allProd*[
      ST: CompressedSegTree2D
  ](
      tree: ST
  ): ST.S {.inline.} =
    if tree.segt.len <= 1:
      tree.SegTree.calc_e()
    else:
      tree.segt[1].all_prod

  proc `[]`*[
      ST: CompressedSegTree2D
  ](
      tree: ST,
      x,
      y: int
  ): ST.S {.inline.} =
    tree.get(x, y)

  proc `[]=`*[
      ST: CompressedSegTree2D
  ](
      tree: var ST,
      x,
      y: int,
      value: ST.S
  ) {.inline.} =
    tree.set(x, y, value)
