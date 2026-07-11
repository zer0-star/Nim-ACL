when not declared ATCODER_EXTRA_STRUCTURE_PERSISTENT_SEGMENT_TREE_HPP:
  const ATCODER_EXTRA_STRUCTURE_PERSISTENT_SEGMENT_TREE_HPP* = 1

  import atcoder/rangeutils

  type
    PersistentSegmentTreeNode*[T] = object
      left*, right*: int
      value*: T

    PersistentSegmentTree*[T] = object
      n*: int
      size*: int
      identity*: T
      op*: proc(a, b: T): T {.closure.}

      nodes*: seq[PersistentSegmentTreeNode[T]]
      root*: int

  proc appendNode[T](
    tree: var PersistentSegmentTree[T],
    node: PersistentSegmentTreeNode[T]
  ): int =
    result = tree.nodes.len
    tree.nodes.add node

  proc buildEmptyNode[T](
    tree: var PersistentSegmentTree[T],
    l, r: int
  ): int =
    if r - l == 1:
      return tree.appendNode(
        PersistentSegmentTreeNode[T](
          left: -1,
          right: -1,
          value: tree.identity,
        )
      )

    let middle = (l + r) div 2

    let left = tree.buildEmptyNode(l, middle)
    let right = tree.buildEmptyNode(middle, r)

    tree.appendNode(
      PersistentSegmentTreeNode[T](
        left: left,
        right: right,
        value: tree.op(
          tree.nodes[left].value,
          tree.nodes[right].value,
        ),
      )
    )

  proc buildArrayNode[T](
    tree: var PersistentSegmentTree[T],
    values: openArray[T],
    l, r: int
  ): int =
    if r - l == 1:
      let value =
        if l < values.len:
          values[l]
        else:
          tree.identity

      return tree.appendNode(
        PersistentSegmentTreeNode[T](
          left: -1,
          right: -1,
          value: value,
        )
      )

    let middle = (l + r) div 2

    let left = tree.buildArrayNode(values, l, middle)
    let right = tree.buildArrayNode(values, middle, r)

    tree.appendNode(
      PersistentSegmentTreeNode[T](
        left: left,
        right: right,
        value: tree.op(
          tree.nodes[left].value,
          tree.nodes[right].value,
        ),
      )
    )

  proc treeHeight(size: int): int =
    var x = size

    while x > 1:
      result.inc
      x = x shr 1

  proc initPersistentSegmentTree*[T](
    n: int,
    identity: T,
    op: proc(a, b: T): T {.closure.},
    expectedUpdates: int = 0
  ): PersistentSegmentTree[T] =
    ## Builds an identity-filled persistent segment tree.
    doAssert n >= 0
    doAssert expectedUpdates >= 0

    result.n = n
    result.size = 1
    result.identity = identity
    result.op = op

    while result.size < max(1, n):
      result.size = result.size shl 1

    let capacity =
      2 * result.size +
      expectedUpdates * (treeHeight(result.size) + 1)

    result.nodes =
      newSeqOfCap[PersistentSegmentTreeNode[T]](capacity)

    result.root = result.buildEmptyNode(0, result.size)

  proc initPersistentSegmentTree*[T](
    values: openArray[T],
    identity: T,
    op: proc(a, b: T): T {.closure.},
    expectedUpdates: int = 0
  ): PersistentSegmentTree[T] =
    ## Builds a persistent segment tree from an initial array.
    doAssert expectedUpdates >= 0

    result.n = values.len
    result.size = 1
    result.identity = identity
    result.op = op

    while result.size < max(1, values.len):
      result.size = result.size shl 1

    let capacity =
      2 * result.size +
      expectedUpdates * (treeHeight(result.size) + 1)

    result.nodes =
      newSeqOfCap[PersistentSegmentTreeNode[T]](capacity)

    result.root =
      result.buildArrayNode(values, 0, result.size)

  proc len*[T](
    tree: PersistentSegmentTree[T]
  ): int {.inline.} =
    tree.n

  proc nodeCount*[T](
    tree: PersistentSegmentTree[T]
  ): int {.inline.} =
    tree.nodes.len

  proc updateNode[T](
    tree: var PersistentSegmentTree[T],
    node, l, r, position: int,
    value: T
  ): int =
    if r - l == 1:
      return tree.appendNode(
        PersistentSegmentTreeNode[T](
          left: -1,
          right: -1,
          value: value,
        )
      )

    let
      middle = (l + r) div 2
      old = tree.nodes[node]

    var
      left = old.left
      right = old.right

    if position < middle:
      left = tree.updateNode(
        old.left,
        l,
        middle,
        position,
        value,
      )
    else:
      right = tree.updateNode(
        old.right,
        middle,
        r,
        position,
        value,
      )

    tree.appendNode(
      PersistentSegmentTreeNode[T](
        left: left,
        right: right,
        value: tree.op(
          tree.nodes[left].value,
          tree.nodes[right].value,
        ),
      )
    )

  proc setValue*[T](
    tree: var PersistentSegmentTree[T],
    root, position: int,
    value: T
  ): int =
    ## Returns a new root with `a[position] = value`.
    doAssert 0 <= root and root < tree.nodes.len
    doAssert 0 <= position and position < tree.n

    tree.updateNode(
      root,
      0,
      tree.size,
      position,
      value,
    )

  proc update*[T](
    tree: var PersistentSegmentTree[T],
    root, position: int,
    value: T
  ): int =
    ## Alias of `setValue`.
    tree.setValue(root, position, value)

  proc prodNode[T](
    tree: PersistentSegmentTree[T],
    node, nodeL, nodeR, queryL, queryR: int
  ): T =
    if queryR <= nodeL or nodeR <= queryL:
      return tree.identity

    if queryL <= nodeL and nodeR <= queryR:
      return tree.nodes[node].value

    let middle = (nodeL + nodeR) div 2

    tree.op(
      tree.prodNode(
        tree.nodes[node].left,
        nodeL,
        middle,
        queryL,
        queryR,
      ),
      tree.prodNode(
        tree.nodes[node].right,
        middle,
        nodeR,
        queryL,
        queryR,
      ),
    )

  proc prod*[T](
    tree: PersistentSegmentTree[T],
    root, l, r: int
  ): T =
    ## Returns the range product over the half-open interval `[l, r)`.
    doAssert 0 <= root and root < tree.nodes.len
    doAssert 0 <= l and l <= r and r <= tree.n

    if l == r:
      return tree.identity

    tree.prodNode(
      root,
      0,
      tree.size,
      l,
      r,
    )

  proc get*[T](
    tree: PersistentSegmentTree[T],
    root, position: int
  ): T =
    ## Returns the value at `position` in a version.
    doAssert 0 <= position and position < tree.n

    tree.prod(root, position, position + 1)

  proc allProd*[T](
    tree: PersistentSegmentTree[T],
    root: int
  ): T =
    ## Returns the aggregate of the whole version.
    doAssert 0 <= root and root < tree.nodes.len

    tree.nodes[root].value

  proc toSeq*[T](
    tree: PersistentSegmentTree[T],
    root: int
  ): seq[T] =
    ## Materializes one version as a sequence.
    result = newSeq[T](tree.n)

    for i in 0 ..< tree.n:
      result[i] = tree.get(root, i)


  type
    PersistentVersion* = distinct int

    PersistentSegTree*[S; p: static[tuple]] = object
      ## Standard-style static-monoid facade.
      ##
      ## The legacy `PersistentSegmentTree[T]` backend remains
      ## available for source compatibility.
      impl: PersistentSegmentTree[S]

  template calc_op*[
    PST: PersistentSegTree
  ](
    self: PST or typedesc[PST],
    a, b: PST.S
  ): auto =
    PST.p.op(a, b)

  template calc_e*[
    PST: PersistentSegTree
  ](
    self: PST or typedesc[PST]
  ): auto =
    PST.p.e()

  template PersistentSegTreeType*[S](
    op0,
    e0: untyped
  ): typedesc[PersistentSegTree] =
    proc op1(
      left,
      right: S
    ): S {.gensym, inline.} =
      op0(left, right)

    proc e1(): S {.gensym, inline.} =
      e0()

    PersistentSegTree[
      S,
      (
        op: op1,
        e: e1,
      ),
    ]

  proc init*[
    PST: PersistentSegTree
  ](
    tree: var PST,
    n: int,
    expectedUpdates: int = 0
  ) =
    proc runtimeOp(
      left,
      right: PST.S
    ): PST.S {.closure.} =
      PST.calc_op(left, right)

    tree.impl = initPersistentSegmentTree(
      n,
      identity = PST.calc_e(),
      op = runtimeOp,
      expectedUpdates = expectedUpdates,
    )

  proc init*[
    PST: PersistentSegTree
  ](
    tree: var PST,
    values: seq[PST.S],
    expectedUpdates: int = 0
  ) =
    proc runtimeOp(
      left,
      right: PST.S
    ): PST.S {.closure.} =
      PST.calc_op(left, right)

    tree.impl = initPersistentSegmentTree(
      values,
      identity = PST.calc_e(),
      op = runtimeOp,
      expectedUpdates = expectedUpdates,
    )

  proc init*[
    PST: PersistentSegTree
  ](
    treeType: typedesc[PST],
    n: int,
    expectedUpdates: int = 0
  ): PST =
    result.init(
      n,
      expectedUpdates,
    )

  proc init*[
    PST: PersistentSegTree
  ](
    treeType: typedesc[PST],
    values: seq[PST.S],
    expectedUpdates: int = 0
  ): PST =
    result.init(
      values,
      expectedUpdates,
    )

  template initPersistentSegmentTree*[S](
    values: seq[S],
    op,
    e: untyped,
    expectedUpdates: int = 0
  ): auto =
    PersistentSegTreeType[S](
      op,
      e,
    ).init(
      values,
      expectedUpdates,
    )

  template initPersistentSegmentTree*(
    n: int,
    op,
    e: untyped,
    expectedUpdates: int = 0
  ): auto =
    block:
      type S = typeof(e())

      PersistentSegTreeType[S](
        op,
        e,
      ).init(
        n,
        expectedUpdates,
      )

  proc len*[
    PST: PersistentSegTree
  ](
    tree: PST
  ): int {.inline.} =
    tree.impl.len

  proc nodeCount*[
    PST: PersistentSegTree
  ](
    tree: PST
  ): int {.inline.} =
    tree.impl.nodeCount

  proc initialVersion*[
    PST: PersistentSegTree
  ](
    tree: PST
  ): PersistentVersion {.inline.} =
    PersistentVersion(
      tree.impl.root
    )

  proc set*[
    PST: PersistentSegTree
  ](
    tree: var PST,
    position: IndexType,
    value: PST.S,
    version: PersistentVersion
  ): PersistentVersion =
    let index = tree^^position

    PersistentVersion(
      tree.impl.setValue(
        int(version),
        index,
        value,
      )
    )

  proc setValue*[
    PST: PersistentSegTree
  ](
    tree: var PST,
    position: IndexType,
    value: PST.S,
    version: PersistentVersion
  ): PersistentVersion =
    ## Compatibility spelling for `set`.
    tree.set(
      position,
      value,
      version,
    )

  proc update*[
    PST: PersistentSegTree
  ](
    tree: var PST,
    position: IndexType,
    value: PST.S,
    version: PersistentVersion
  ): PersistentVersion =
    ## Compatibility spelling for `set`.
    tree.set(
      position,
      value,
      version,
    )

  proc get*[
    PST: PersistentSegTree
  ](
    tree: PST,
    position: IndexType,
    version: PersistentVersion
  ): PST.S =
    let index = tree^^position

    tree.impl.get(
      int(version),
      index,
    )

  proc prod*[
    PST: PersistentSegTree
  ](
    tree: PST,
    range: RangeType,
    version: PersistentVersion
  ): PST.S =
    let (left, right) =
      tree.halfOpenEndpoints(range)

    tree.impl.prod(
      int(version),
      left,
      right,
    )

  proc prod*[
    PST: PersistentSegTree
  ](
    tree: PST,
    left,
    right: int,
    version: PersistentVersion
  ): PST.S =
    tree.impl.prod(
      int(version),
      left,
      right,
    )

  proc allProd*[
    PST: PersistentSegTree
  ](
    tree: PST,
    version: PersistentVersion
  ): PST.S =
    ## Returns the aggregate stored at `version`.
    tree.impl.allProd(int(version))

  proc toSeq*[
    PST: PersistentSegTree
  ](
    tree: PST,
    version: PersistentVersion
  ): seq[PST.S] =
    tree.impl.toSeq(
      int(version)
    )
