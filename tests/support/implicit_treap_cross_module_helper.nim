import atcoder/extra/structure/implicit_treap


proc crossSumOp(
    left,
    right: int,
): int =
  left + right


proc crossSumE(): int =
  0


proc crossConcatOp(
    left,
    right: string,
): string =
  left & right


proc crossConcatE(): string =
  ""


type
  CrossSumTreap* =
    ImplicitTreapType[int](
      crossSumOp,
      crossSumE,
    )

  CrossStringTreap* =
    ImplicitTreapType[string](
      crossConcatOp,
      crossConcatE,
    )


proc buildCrossModuleTreapResult*():
    tuple[
      values: seq[int],
      total: int,
      removed: int,
      text: string,
    ] =
  var numberTree =
    CrossSumTreap.init(
      @[1, 2, 3, 4],
      seed = 123'u64,
    )

  numberTree.reverse(
    1,
    4,
  )

  numberTree.insert(
    2,
    10,
  )

  result.removed =
    numberTree.erase(0)

  result.values =
    numberTree.toSeq()

  result.total =
    numberTree.allProd()

  var textTree =
    CrossStringTreap.init(
      @["a", "bc", "d"]
    )

  textTree.reverse(
    0,
    3,
  )

  result.text =
    textTree.allProd()
