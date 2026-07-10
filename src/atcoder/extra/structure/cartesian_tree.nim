when not declared ATCODER_EXTRA_STRUCTURE_CARTESIAN_TREE_HPP:
  const ATCODER_EXTRA_STRUCTURE_CARTESIAN_TREE_HPP* = 1

  type
    CartesianTree* = object
      root*: int
      parent*: seq[int]
      left*: seq[int]
      right*: seq[int]

  proc buildCartesianTree[T](
    a: openArray[T],
    less: proc(x, y: T): bool {.closure.}
  ): CartesianTree =
    let n = a.len

    result.root = -1
    result.parent = newSeq[int](n)
    result.left = newSeq[int](n)
    result.right = newSeq[int](n)

    for i in 0 ..< n:
      result.parent[i] = -1
      result.left[i] = -1
      result.right[i] = -1

    var stack: seq[int] = @[]

    for i in 0 ..< n:
      var last = -1

      while stack.len > 0 and less(a[i], a[stack[^1]]):
        last = stack[^1]
        stack.setLen(stack.len - 1)

      if stack.len > 0:
        let p = stack[^1]
        result.parent[i] = p
        result.right[p] = i

      if last >= 0:
        result.parent[last] = i
        result.left[i] = last

      stack.add i

    if stack.len > 0:
      result.root = stack[0]

  proc initCartesianTree*[T](a: openArray[T]): CartesianTree =
    ## Builds a stable min Cartesian tree.
    ##
    ## Equal values keep the earlier index above the later index.
    proc defaultLess(x, y: T): bool =
      x < y

    buildCartesianTree(a, defaultLess)

  proc initCartesianTree*[T](
    a: openArray[T],
    less: proc(x, y: T): bool {.closure.}
  ): CartesianTree =
    ## Builds a Cartesian tree using the supplied comparator.
    buildCartesianTree(a, less)

  proc initMinCartesianTree*[T](a: openArray[T]): CartesianTree =
    ## Alias of the default min Cartesian tree constructor.
    initCartesianTree(a)

  proc initMaxCartesianTree*[T](a: openArray[T]): CartesianTree =
    ## Builds a stable max Cartesian tree.
    proc greater(x, y: T): bool =
      x > y

    buildCartesianTree(a, greater)

  proc len*(tree: CartesianTree): int {.inline.} =
    tree.parent.len

  proc empty*(tree: CartesianTree): bool {.inline.} =
    tree.len == 0

  proc children*(tree: CartesianTree, v: int): seq[int] =
    ## Returns the existing children of `v`, left then right.
    doAssert 0 <= v and v < tree.len

    if tree.left[v] >= 0:
      result.add tree.left[v]

    if tree.right[v] >= 0:
      result.add tree.right[v]

  proc inorder*(tree: CartesianTree): seq[int] =
    ## Returns vertex indices in inorder.
    var stack: seq[int] = @[]
    var v = tree.root

    while v >= 0 or stack.len > 0:
      while v >= 0:
        stack.add v
        v = tree.left[v]

      v = stack[^1]
      stack.setLen(stack.len - 1)
      result.add v
      v = tree.right[v]
