when not declared ATCODER_EDIT_DISTANCE_HPP:
  const ATCODER_EDIT_DISTANCE_HPP* = 1

  proc editDistance*(S, T: string): int =
    let N = S.len
    let M = T.len

    var prev = newSeq[int](M + 1)
    var cur = newSeq[int](M + 1)

    for j in 0 .. M:
      prev[j] = j

    for i in 1 .. N:
      cur[0] = i

      for j in 1 .. M:
        let cost = if S[i - 1] == T[j - 1]: 0 else: 1

        cur[j] = min(
          min(prev[j] + 1, cur[j - 1] + 1),
          prev[j - 1] + cost
        )

      swap(prev, cur)

    return prev[M]
