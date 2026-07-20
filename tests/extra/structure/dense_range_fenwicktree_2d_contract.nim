import atcoder/modint
import atcoder/extra/structure/dense_range_fenwicktree_2d

type
  mint = modint998244353
  NaiveGrid = object
    data: seq[seq[int64]]

proc initNaiveGrid(h, w: int): NaiveGrid =
  result.data = newSeq[seq[int64]](h)
  for y in 0 ..< h:
    result.data[y] = newSeq[int64](w)

proc add(
    g: var NaiveGrid,
    y1, y2, x1, x2: int,
    delta: int64,
) =
  for y in y1 ..< y2:
    for x in x1 ..< x2:
      g.data[y][x] += delta

proc sum(
    g: NaiveGrid,
    y1, y2, x1, x2: int,
): int64 =
  for y in y1 ..< y2:
    for x in x1 ..< x2:
      result += g.data[y][x]

proc nextState(s: var uint64): uint64 =
  s = s * 6364136223846793005'u64 + 1442695040888963407'u64
  s

proc nextInt(s: var uint64, bound: int): int =
  doAssert bound > 0
  int(nextState(s) mod uint64(bound))

proc randomRange(
    s: var uint64,
    size: int,
): tuple[left, right: int] =
  result.left = s.nextInt(size + 1)
  result.right =
    result.left + s.nextInt(size - result.left + 1)

block emptyDimensions:
  var a = initDenseRangeFenwickTree2D[int64](0, 0)
  a.add(0, 0, 0, 0, 123'i64)
  doAssert a.sum(0, 0, 0, 0) == 0'i64

  var b = initDenseRangeFenwickTree2D[int64](0, 3)
  b.add(0, 0, 0, 3, 456'i64)
  doAssert b.sum(0, 0, 0, 3) == 0'i64

  var c = initDenseRangeFenwickTree2D[int64](3, 0)
  c.add(0, 3, 0, 0, 789'i64)
  doAssert c.sum(0, 3, 0, 0) == 0'i64

block fixedCases:
  const H = 4
  const W = 5
  var tree = initDenseRangeFenwickTree2D[int64](H, W)
  var naive = initNaiveGrid(H, W)
  let updates = [
    (0, 4, 0, 5, 3'i64),
    (1, 3, 2, 5, -2'i64),
    (0, 1, 0, 1, 7'i64),
    (2, 4, 1, 4, 5'i64),
    (4, 4, 0, 5, 999'i64),
    (0, 4, 5, 5, -999'i64),
  ]

  for u in updates:
    let (y1, y2, x1, x2, d) = u
    tree.add(y1, y2, x1, x2, d)
    naive.add(y1, y2, x1, x2, d)

  for y1 in 0 .. H:
    for y2 in y1 .. H:
      for x1 in 0 .. W:
        for x2 in x1 .. W:
          doAssert tree.sum(y1, y2, x1, x2) ==
            naive.sum(y1, y2, x1, x2)

  for y in 0 ..< H:
    for x in 0 ..< W:
      doAssert tree.get(y, x) == naive.data[y][x]

block exhaustiveSingleUpdates:
  const Deltas = [-3'i64, -1'i64, 0'i64, 2'i64, 5'i64]

  for h in 0 .. 4:
    for w in 0 .. 4:
      for y1 in 0 .. h:
        for y2 in y1 .. h:
          for x1 in 0 .. w:
            for x2 in x1 .. w:
              for d in Deltas:
                var tree = initDenseRangeFenwickTree2D[int64](h, w)
                var naive = initNaiveGrid(h, w)
                tree.add(y1, y2, x1, x2, d)
                naive.add(y1, y2, x1, x2, d)

                for qy1 in 0 .. h:
                  for qy2 in qy1 .. h:
                    for qx1 in 0 .. w:
                      for qx2 in qx1 .. w:
                        doAssert tree.sum(
                          qy1, qy2, qx1, qx2,
                        ) == naive.sum(
                          qy1, qy2, qx1, qx2,
                        )

block deterministicRandomDifferential:
  var state = 20260719'u64

  for caseIndex in 0 ..< 500:
    let h = state.nextInt(9)
    let w = state.nextInt(9)
    var tree = initDenseRangeFenwickTree2D[int64](h, w)
    var naive = initNaiveGrid(h, w)

    for operationIndex in 0 ..< 80:
      let yr = state.randomRange(h)
      let xr = state.randomRange(w)

      if state.nextInt(100) < 58:
        let d = int64(state.nextInt(2001) - 1000)
        tree.add(yr.left, yr.right, xr.left, xr.right, d)
        naive.add(yr.left, yr.right, xr.left, xr.right, d)
      else:
        doAssert tree.sum(
          yr.left, yr.right, xr.left, xr.right,
        ) == naive.sum(
          yr.left, yr.right, xr.left, xr.right,
        )

      discard caseIndex
      discard operationIndex

    for y in 0 ..< h:
      for x in 0 ..< w:
        doAssert tree.get(y, x) == naive.data[y][x]

block modintCase:
  var tree = initDenseRangeFenwickTree2D[mint](3, 4)
  tree.add(0, 3, 0, 4, mint(5))
  tree.add(1, 3, 2, 4, mint(-2))
  tree.add(0, 1, 0, 1, mint(7))
  doAssert tree.get(0, 0) == mint(12)
  doAssert tree.get(1, 2) == mint(3)
  doAssert tree.get(2, 3) == mint(3)
  doAssert tree.sum(0, 3, 0, 4) == mint(59)
  doAssert tree.sum(1, 3, 2, 4) == mint(12)

echo "DENSE_RANGE_FENWICKTREE_2D_CONTRACT_OK"
