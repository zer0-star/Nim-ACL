import std/unittest

import atcoder/modint
import atcoder/extra/math/berlekamp_massey


type
  Mint998 = modint998244353
  Mint1e9 = modint1000000007
  Mint5 = StaticModInt[5]


proc makeSequence[T](
    initial,
    coefficient: openArray[T],
    length: int,
): seq[T] =
  result = newSeq[T](length)

  for index in 0 ..< min(
      initial.len,
      length,
  ):
    result[index] = initial[index]

  for position in initial.len ..< length:
    var value = default(T)

    for index in 0 ..< coefficient.len:
      value +=
        coefficient[index] *
        result[position - 1 - index]

    result[position] = value


proc reproduces[T](
    sequence,
    coefficient: openArray[T],
): bool =
  for position in coefficient.len ..< sequence.len:
    var value = default(T)

    for index in 0 ..< coefficient.len:
      value +=
        coefficient[index] *
        sequence[position - 1 - index]

    if value != sequence[position]:
      return false

  true


proc nextRandom(
    state: var uint64,
): uint64 {.inline.} =
  state = state xor (state shl 7)
  state = state xor (state shr 9)
  state = state xor (state shl 8)
  state


proc power(
    base,
    exponent: int,
): int =
  result = 1

  for _ in 0 ..< exponent:
    result *= base


proc existsShorterRecurrence(
    sequence: openArray[Mint5],
    length: int,
): bool =
  let candidateCount =
    power(5, length)

  for encoded in 0 ..< candidateCount:
    var
      value = encoded
      candidate =
        newSeq[Mint5](length)

    for index in 0 ..< length:
      candidate[index] =
        Mint5.init(value mod 5)

      value = value div 5

    if reproduces(
        sequence,
        candidate,
    ):
      return true

  false


suite "Berlekamp-Massey":
  test "empty and all-zero sequences":
    check berlekampMassey(
      newSeq[Mint998]()
    ).len == 0

    check berlekampMassey(
      @[
        Mint998.init(0),
        Mint998.init(0),
        Mint998.init(0),
        Mint998.init(0),
      ]
    ).len == 0

  test "constant and geometric sequences":
    let constant =
      @[
        Mint998.init(7),
        Mint998.init(7),
        Mint998.init(7),
        Mint998.init(7),
        Mint998.init(7),
      ]

    check berlekampMassey(
      constant
    ) == @[
      Mint998.init(1),
    ]

    let geometric =
      @[
        Mint998.init(3),
        Mint998.init(6),
        Mint998.init(12),
        Mint998.init(24),
        Mint998.init(48),
      ]

    check berlekampMassey(
      geometric
    ) == @[
      Mint998.init(2),
    ]

  test "Fibonacci recurrence":
    let fibonacci =
      @[
        Mint998.init(0),
        Mint998.init(1),
        Mint998.init(1),
        Mint998.init(2),
        Mint998.init(3),
        Mint998.init(5),
        Mint998.init(8),
        Mint998.init(13),
        Mint998.init(21),
      ]

    let coefficient =
      berlekampMassey(fibonacci)

    check coefficient == @[
      Mint998.init(1),
      Mint998.init(1),
    ]

    check reproduces(
      fibonacci,
      coefficient,
    )

  test "known order-three recurrence":
    let coefficient =
      @[
        Mint998.init(2),
        Mint998.init(3),
        Mint998.init(4),
      ]

    let sequence =
      makeSequence(
        @[
          Mint998.init(1),
          Mint998.init(2),
          Mint998.init(5),
        ],
        coefficient,
        30,
      )

    let recovered =
      berlekampMassey(sequence)

    check recovered == coefficient
    check reproduces(
      sequence,
      recovered,
    )

  test "multiple field types in one module":
    let sequence998 =
      makeSequence(
        @[
          Mint998.init(1),
          Mint998.init(4),
        ],
        @[
          Mint998.init(3),
          Mint998.init(2),
        ],
        24,
      )

    let sequence1e9 =
      makeSequence(
        @[
          Mint1e9.init(1),
          Mint1e9.init(4),
        ],
        @[
          Mint1e9.init(3),
          Mint1e9.init(2),
        ],
        24,
      )

    check berlekampMassey(
      sequence998
    ) == @[
      Mint998.init(3),
      Mint998.init(2),
    ]

    check berlekampMassey(
      sequence1e9
    ) == @[
      Mint1e9.init(3),
      Mint1e9.init(2),
    ]

  test "random generated recurrences reproduce every prefix":
    var state =
      0x9a13_0f42_7765_bc81'u64

    for order in 1 .. 7:
      for _ in 0 ..< 30:
        var
          coefficient =
            newSeq[Mint998](order)

          initial =
            newSeq[Mint998](order)

        for index in 0 ..< order:
          coefficient[index] =
            Mint998.init(
              int(
                nextRandom(state) mod
                1000'u64
              )
            )

          initial[index] =
            Mint998.init(
              int(
                nextRandom(state) mod
                1000'u64
              )
            )

        let sequence =
          makeSequence(
            initial,
            coefficient,
            50,
          )

        let recovered =
          berlekampMassey(sequence)

        check recovered.len <= order

        check reproduces(
          sequence,
          recovered,
        )

  test "returned recurrence is minimal on random prefixes over F_5":
    var state =
      0x3cf1_85a2_0b79_4e6d'u64

    for _ in 0 ..< 40:
      var sequence =
        newSeq[Mint5](10)

      for index in 0 ..< sequence.len:
        sequence[index] =
          Mint5.init(
            int(
              nextRandom(state) mod 5'u64
            )
          )

      let recovered =
        berlekampMassey(sequence)

      check reproduces(
        sequence,
        recovered,
      )

      for shorterLength in 0 ..< recovered.len:
        check not existsShorterRecurrence(
          sequence,
          shorterLength,
        )
