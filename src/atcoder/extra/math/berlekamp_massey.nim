when not declared ATCODER_EXTRA_MATH_BERLEKAMP_MASSEY_HPP:
  const
    ATCODER_EXTRA_MATH_BERLEKAMP_MASSEY_HPP* = 1

  proc berlekampMassey*[T](
      sequence: openArray[T],
  ): seq[T] =
    ## Returns the shortest linear recurrence determined by `sequence`.
    ##
    ## If the returned sequence is `coefficient`, then every determined
    ## term satisfies
    ##
    ## `sequence[n] =
    ##   coefficient[0] * sequence[n - 1] +
    ##   coefficient[1] * sequence[n - 2] + ...`.
    ##
    ## `T` must behave like a field. `default(T)` must be zero.
    ##
    ## Time complexity: `O(sequence.len^2)`.
    ## Memory complexity: `O(sequence.len)`.
    if sequence.len == 0:
      return @[]

    let zero = default(T)

    var firstNonzero = -1

    for index in 0 ..< sequence.len:
      if sequence[index] != zero:
        firstNonzero = index
        break

    if firstNonzero < 0:
      return @[]

    # This avoids requiring a particular integer-to-T constructor.
    let one =
      sequence[firstNonzero] /
      sequence[firstNonzero]

    # `current` stores the connection polynomial:
    #
    # current[0] * a[n] + current[1] * a[n - 1] + ... = 0.
    var
      current = @[one]
      previous = @[one]
      currentLength = 0
      shift = 1
      previousDiscrepancy = one

    for position in 0 ..< sequence.len:
      var discrepancy =
        sequence[position]

      for index in 1 .. currentLength:
        discrepancy +=
          current[index] *
          sequence[position - index]

      if discrepancy == zero:
        shift.inc
        continue

      let scale =
        discrepancy /
        previousDiscrepancy

      var saved =
        newSeq[T](current.len)

      for index in 0 ..< current.len:
        saved[index] = current[index]

      let requiredLength =
        previous.len + shift

      if current.len < requiredLength:
        current.setLen(requiredLength)

      for index in 0 ..< previous.len:
        current[index + shift] -=
          scale * previous[index]

      if 2 * currentLength <= position:
        currentLength =
          position + 1 - currentLength

        previous = saved
        previousDiscrepancy = discrepancy
        shift = 1
      else:
        shift.inc

    result =
      newSeq[T](currentLength)

    for index in 0 ..< currentLength:
      result[index] =
        zero - current[index + 1]
