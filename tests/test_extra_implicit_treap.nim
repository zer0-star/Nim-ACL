import std/unittest

import atcoder/extra/structure/implicit_treap


proc sumOp(
    left,
    right: int,
): int =
  left + right


proc sumE(): int =
  0


proc concatOp(
    left,
    right: string,
): string =
  left & right


proc concatE(): string =
  ""


type
  SumTreap =
    ImplicitTreapType[int](
      sumOp,
      sumE,
    )

  StringTreap =
    ImplicitTreapType[string](
      concatOp,
      concatE,
    )


proc sequenceInsert[T](
    values: var seq[T],
    position: int,
    value: T,
) =
  let oldLength =
    values.len

  values.setLen(
    oldLength + 1
  )

  var index =
    oldLength

  while index > position:
    values[index] =
      values[index - 1]

    dec index

  values[position] =
    value


proc sequenceErase[T](
    values: var seq[T],
    position: int,
): T =
  result =
    values[position]

  var index =
    position

  while index + 1 < values.len:
    values[index] =
      values[index + 1]

    inc index

  values.setLen(
    values.len - 1
  )


proc sequenceReverse[T](
    values: var seq[T],
    left,
    right: int,
) =
  var
    first =
      left

    last =
      right - 1

  while first < last:
    swap(
      values[first],
      values[last],
    )

    inc first
    dec last


proc sequenceSum(
    values: openArray[int],
    left,
    right: int,
): int =
  for index in left ..< right:
    result +=
      values[index]


proc nextRandom(
    state: var uint64,
): uint64 {.inline.} =
  state =
    state xor (state shl 7)

  state =
    state xor (state shr 9)

  state =
    state xor (state shl 8)

  state


suite "implicit treap":
  test "multiple factories coexist":
    var sumTree =
      SumTreap.init(
        @[1, 2, 3]
      )

    var stringTree =
      StringTreap.init(
        @["a", "b", "c"]
      )

    check sumTree.allProd() == 6
    check stringTree.allProd() == "abc"

  test "basic dynamic sequence operations":
    var tree =
      SumTreap.init(
        @[1, 2, 3, 4],
        seed = 7'u64,
      )

    check tree.len == 4
    check tree.toSeq() == @[1, 2, 3, 4]
    check tree.prod(1, 4) == 9

    tree.insert(
      2,
      10,
    )

    check tree.toSeq() ==
      @[1, 2, 10, 3, 4]

    check tree.erase(1) == 2

    check tree.toSeq() ==
      @[1, 10, 3, 4]

    tree[2] =
      30

    check tree[2] == 30

    tree.reverse(
      1,
      4,
    )

    check tree.toSeq() ==
      @[1, 4, 30, 10]

    check tree.allProd() == 45

  test "noncommutative aggregate survives reversal":
    var tree =
      StringTreap.init(
        @[
          "a",
          "bc",
          "d",
          "ef",
        ],
        seed = 11'u64,
      )

    check tree.allProd() ==
      "abcdef"

    tree.reverse(
      1,
      4,
    )

    check tree.toSeq() ==
      @[
        "a",
        "ef",
        "d",
        "bc",
      ]

    check tree.allProd() ==
      "aefdbc"

    check tree.prod(
      1,
      4,
    ) == "efdbc"

    tree.reverse(
      0,
      4,
    )

    check tree.allProd() ==
      "bcdefa"

  test "empty ranges use the identity":
    var tree =
      SumTreap.init(
        @[1, 2, 3]
      )

    check tree.prod(0, 0) == 0
    check tree.prod(2, 2) == 0
    check tree.prod(3, 3) == 0

    tree.reverse(
      1,
      1,
    )

    check tree.toSeq() ==
      @[1, 2, 3]

  test "fixed and custom seeds preserve semantics":
    let initial =
      @[3, 1, 4, 1, 5, 9, 2, 6]

    var expected =
      initial

    expected.sequenceReverse(
      2,
      7,
    )

    expected.sequenceInsert(
      4,
      100,
    )

    discard expected.sequenceErase(1)

    for seed in [
        0'u64,
        1'u64,
        2'u64,
        uint64.high,
    ]:
      var tree =
        SumTreap.init(
          initial,
          seed = seed,
        )

      tree.reverse(
        2,
        7,
      )

      tree.insert(
        4,
        100,
      )

      discard tree.erase(1)

      check tree.toSeq() ==
        expected

  test "erase and insert churn remains correct":
    var tree =
      SumTreap.init(
        @[0],
        seed = 19'u64,
      )

    for value in 1 .. 2000:
      tree.insert(
        1,
        value,
      )

      check tree.erase(0) ==
        value - 1

      check tree.len == 1
      check tree[0] == value

  test "randomized differential against seq":
    var
      state =
        0xb7e1_5162_8aed_2a6b'u64

      reference:
        seq[int]

      tree =
        SumTreap.init(
          seed = 0'u64,
        )

    for operationIndex in 0 ..< 5000:
      let operation =
        int(
          nextRandom(state) mod 6'u64
        )

      if operation == 0 or reference.len == 0:
        let positionRandom =
          nextRandom(state)

        let valueRandom =
          nextRandom(state)

        let
          position =
            int(
              positionRandom mod
                uint64(reference.len + 1)
            )

          value =
            int(
              valueRandom mod 201'u64
            ) - 100

        reference.sequenceInsert(
          position,
          value,
        )

        tree.insert(
          position,
          value,
        )

      elif operation == 1:
        let positionRandom =
          nextRandom(state)

        let position =
          int(
            positionRandom mod
              uint64(reference.len)
          )

        let expected =
          reference.sequenceErase(
            position
          )

        check tree.erase(position) ==
          expected

      elif operation == 2:
        let positionRandom =
          nextRandom(state)

        let valueRandom =
          nextRandom(state)

        let
          position =
            int(
              positionRandom mod
                uint64(reference.len)
            )

          value =
            int(
              valueRandom mod 201'u64
            ) - 100

        reference[position] =
          value

        tree[position] =
          value

      elif operation == 3:
        let firstRandom =
          nextRandom(state)

        let secondRandom =
          nextRandom(state)

        let
          first =
            int(
              firstRandom mod
                uint64(reference.len + 1)
            )

          second =
            int(
              secondRandom mod
                uint64(reference.len + 1)
            )

          left =
            min(
              first,
              second,
            )

          right =
            max(
              first,
              second,
            )

        reference.sequenceReverse(
          left,
          right,
        )

        tree.reverse(
          left,
          right,
        )

      elif operation == 4:
        let firstRandom =
          nextRandom(state)

        let secondRandom =
          nextRandom(state)

        let
          first =
            int(
              firstRandom mod
                uint64(reference.len + 1)
            )

          second =
            int(
              secondRandom mod
                uint64(reference.len + 1)
            )

          left =
            min(
              first,
              second,
            )

          right =
            max(
              first,
              second,
            )

        check tree.prod(
          left,
          right,
        ) == reference.sequenceSum(
          left,
          right,
        )

      else:
        let positionRandom =
          nextRandom(state)

        let position =
          int(
            positionRandom mod
              uint64(reference.len)
          )

        check tree[position] ==
          reference[position]

      check tree.len ==
        reference.len

      if operationIndex mod 37 == 0:
        check tree.toSeq() ==
          reference

        check tree.allProd() ==
          reference.sequenceSum(
            0,
            reference.len,
          )

    check tree.toSeq() ==
      reference

  test "invalid positions and ranges":
    var tree =
      SumTreap.init(
        @[1, 2, 3]
      )

    expect ValueError:
      tree.insert(
        -1,
        0,
      )

    expect ValueError:
      tree.insert(
        5,
        0,
      )

    expect ValueError:
      discard tree.erase(3)

    expect ValueError:
      discard tree.get(-1)

    expect ValueError:
      tree.set(
        3,
        0,
      )

    expect ValueError:
      tree.reverse(
        2,
        1,
      )

    expect ValueError:
      discard tree.prod(
        0,
        4,
      )
