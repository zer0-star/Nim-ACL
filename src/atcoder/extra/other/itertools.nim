when not declared ATCODER_EXTRA_OTHER_ITERTOOLS_HPP:
  const ATCODER_EXTRA_OTHER_ITERTOOLS_HPP* = 1

  type CartesianPower*[T] = object
    pool: seq[T]
    repeat: int

  proc ownedSeq[T](pool: openArray[T]): seq[T] =
    result = newSeq[T](pool.len)

    for i in 0 ..< pool.len:
      result[i] = pool[i]

  iterator permutations*[T](
      pool: openArray[T],
      r: int
  ): seq[T] =
    let n = pool.len
    let valid = 0 <= r and r <= n
    let count = if valid: r else: 0

    if valid:
      if count == 0:
        yield newSeq[T]()
      else:
        var indices = newSeq[int](n)
        var cycles = newSeq[int](count)

        for i in 0 ..< n:
          indices[i] = i

        for i in 0 ..< count:
          cycles[i] = n - i

        var initial = newSeq[T](count)

        for i in 0 ..< count:
          initial[i] = pool[indices[i]]

        yield initial

        while true:
          var advanced = false
          var i = count

          while i > 0:
            i.dec
            cycles[i].dec

            if cycles[i] == 0:
              let firstIndex = indices[i]

              for j in i ..< n - 1:
                indices[j] = indices[j + 1]

              indices[n - 1] = firstIndex
              cycles[i] = n - i
            else:
              let j = n - cycles[i]

              swap(indices[i], indices[j])

              var value = newSeq[T](count)

              for k in 0 ..< count:
                value[k] = pool[indices[k]]

              yield value
              advanced = true
              break

          if not advanced:
            break

  iterator permutations*[T](
      pool: openArray[T]
  ): seq[T] =
    for value in permutations(pool, pool.len):
      yield value

  iterator combinations*[T](
      pool: openArray[T],
      r: int
  ): seq[T] =
    let n = pool.len
    let valid = 0 <= r and r <= n
    let count = if valid: r else: 0

    if valid:
      if count == 0:
        yield newSeq[T]()
      else:
        var indices = newSeq[int](count)

        for i in 0 ..< count:
          indices[i] = i

        while true:
          var value = newSeq[T](count)

          for i in 0 ..< count:
            value[i] = pool[indices[i]]

          yield value

          var pivot = -1
          var i = count

          while i > 0:
            i.dec

            if indices[i] != i + n - count:
              pivot = i
              break

          if pivot < 0:
            break

          indices[pivot].inc

          for j in pivot + 1 ..< count:
            indices[j] = indices[j - 1] + 1

  iterator cartesianProduct*[T](
      pools: openArray[seq[T]]
  ): seq[T] =
    let dimensions = pools.len

    if dimensions == 0:
      yield newSeq[T]()
    else:
      var hasEmptyPool = false

      for pool in pools:
        if pool.len == 0:
          hasEmptyPool = true

      if not hasEmptyPool:
        var indices = newSeq[int](dimensions)

        while true:
          var value = newSeq[T](dimensions)

          for i in 0 ..< dimensions:
            value[i] = pools[i][indices[i]]

          yield value

          var position = dimensions

          while position > 0:
            position.dec
            indices[position].inc

            if indices[position] <
                pools[position].len:
              break

            indices[position] = 0

          if (
            position == 0 and
            indices[0] == 0
          ):
            break

  iterator product*[T](
      pool: openArray[T],
      repeat: int
  ): seq[T] =
    let valid = repeat >= 0
    let count = if valid: repeat else: 0

    if valid:
      let owned = ownedSeq(pool)
      var pools = newSeq[seq[T]](count)

      for i in 0 ..< count:
        pools[i] = owned

      for value in cartesianProduct(pools):
        yield value

  proc cartesianPower*[T](
      pool: openArray[T],
      repeat: int
  ): CartesianPower[T] =
    CartesianPower[T](
      pool: ownedSeq(pool),
      repeat: repeat,
    )

  proc cartesianPower*[T: Ordinal](
      pool: Slice[T],
      repeat: int
  ): CartesianPower[T] =
    result.repeat = repeat

    for value in pool:
      result.pool.add(value)

  iterator items*[T](
      power: CartesianPower[T]
  ): seq[T] =
    for value in product(
      power.pool,
      power.repeat,
    ):
      yield value

  proc `^`*[T: Ordinal](
      pool: Slice[T],
      repeat: int
  ): CartesianPower[T] =
    cartesianPower(pool, repeat)

  proc `^`*[T](
      pool: seq[T],
      repeat: int
  ): CartesianPower[T] =
    cartesianPower(pool, repeat)
