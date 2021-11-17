when not declared ATCODER_ALGORITHM_UTILS_HPP:
  const ATCODER_ALGORITHM_UTILS_HPP* = 1
  import std/algorithm
  iterator permutation*[T](v:seq[T]):seq[T] =
    let n = v.len
    var a = (0..<n).toSeq
    while true:
      var result = newSeq[int]()
      for i in 0..<n: result.add v[a[i]]
      yield result
      if not a.nextPermutation(): break
  
  iterator combination*[T](v:seq[T], r:int):seq[T] =
    let n = v.len
    var a = 1.repeat(r) & 0.repeat(n - r)
    while true:
      var result = newSeq[int]()
      for i in 0..<n:
        if a[i] == 1: result.add(v[i])
      yield result
      if not a.prevPermutation(): break
