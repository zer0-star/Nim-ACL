import atcoder/extra/numeric/internal/limbs

proc divideMod4*(
    numerator,
    denominator: UInt256Limbs,
): tuple[
    quotient: UInt256Limbs,
    remainder: UInt256Limbs,
] =
  if isZero4(denominator):
    raise newException(
      DivByZeroDefect,
      "division by zero",
    )

  for bitIndex in countdown(255, 0):
    result.remainder =
      shiftLeftOne4(
        result.remainder
      )

    if getBit4(
      numerator,
      range[0 .. 255](bitIndex),
    ):
      result.remainder[0] =
        result.remainder[0] or
        1'u64

    if compare4(
      result.remainder,
      denominator,
    ) >= 0:
      result.remainder =
        sub4(
          result.remainder,
          denominator,
        ).value

      setBit4(
        result.quotient,
        range[0 .. 255](bitIndex),
      )
