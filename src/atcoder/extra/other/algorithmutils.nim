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

  proc median[T](a, b, c:T):T =
    if a <= b:
      if b <= c: return b
      elif a <= c: return c
      else: return a
    else: # a > b
      if b <= c:
        if a <= c: return a
        else: return c
      else: # b > c
        return b
  
  proc unguarded_partition[T](a:var openArray[T], first, last:int, target:T):int =
    var
      l = first
      r = last - 1
    # i in 0 .. lではa[i] < target
    # i in r ..< a.lenではtarget <= a[i]
    while l < r:
      while l < r and a[l] <= target: l.inc
      while l < r and target < a[r]: r.dec
      if l < r: swap a[l], a[r]
    return r
  
  proc nth_element*[T](a:var openArray[T], first, nth, last: int) =
    proc insertion_sort(a:var openArray[T], first, last:int) =
      for i in first ..< last:
        for j in i + 1 ..< last:
          if a[j] < a[i]: swap a[i], a[j]
    var (first, last) = (first, last)
    while last - first > 3:
      let m = median(a[first], a[first + ((last - first) shr 1)], a[last - 1])
      var cut = a.unguarded_partition(first, last, m)
      if cut == last - 1: break # all equal
      if cut <= nth:
        first = cut
      else:
        last = cut
    a.insertion_sort(first, last)

  proc nth_element*[T](a:var openArray[T], nth: int) =
    nth_element(a, 0, nth, a.len)
