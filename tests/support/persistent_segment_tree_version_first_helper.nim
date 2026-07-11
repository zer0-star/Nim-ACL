import atcoder/extra/structure/persistent_segment_tree

export persistent_segment_tree


proc crossSumOp(
    left,
    right: int,
): int {.inline.} =
  left + right


proc crossSumE(): int {.inline.} =
  0


type
  CrossPersistentTree* =
    PersistentSegTreeType[int](
      crossSumOp,
      crossSumE,
    )


proc buildCrossTree*():
    CrossPersistentTree =
  CrossPersistentTree.init(
    4,
    expectedUpdates = 8,
  )
