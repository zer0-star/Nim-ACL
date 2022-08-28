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

 
  proc unguarded_partition[T](a:var openArray[T], first, last:int, target:T, comp: proc(a, b:T):bool):int =
    var
      l = first
      r = last - 1
    # i in 0 .. lではa[i] < target
    # i in r ..< a.lenではtarget <= a[i]
    while l < r:
      while l < r and not comp(target, a[l]): l.inc
      while l < r and comp(target, a[r]): r.dec
      if l < r: swap a[l], a[r]
    return r
  
  proc nth_element*[T](a:var openArray[T], first, nth, last: int, comp:proc(a, b:T):bool = (proc(a, b:T):bool = a < b)) =
    proc insertion_sort(a:var openArray[T], first, last:int) =
      for i in first ..< last:
        for j in i + 1 ..< last:
          if comp(a[j], a[i]): swap a[i], a[j]
    proc median[T](a, b, c:T, comp:proc(a, b:T):bool):T =
      if comp(a, b):
        if comp(b, c): return b
        elif comp(a, c): return c
        else: return a
      else: # a >= b
        if comp(b, c):
          if comp(a, c): return a
          else: return c
        else: # b >= c
          return b

    var (first, last) = (first, last)
    while last - first > 3:
      let m = median(a[first], a[first + ((last - first) shr 1)], a[last - 1], comp)
      var cut = a.unguarded_partition(first, last, m, comp)
      if cut == last - 1: break # all equal
      if cut <= nth:
        first = cut
      else:
        last = cut
    a.insertion_sort(first, last)

  proc nth_element*[T](a:var openArray[T], nth: int, comp:proc(a, b:T):bool = (proc(a, b:T):bool = a < b)) =
    nth_element(a, 0, nth, a.len, comp)
