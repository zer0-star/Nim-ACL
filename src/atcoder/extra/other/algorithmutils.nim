when not declared ATCODER_ALGORITHM_UTILS_HPP:
  const ATCODER_ALGORITHM_UTILS_HPP* = 1
  import std/algorithm
  import atcoder/extra/other/itertools as itertools

  iterator permutation*[T](v:seq[T]):seq[T] =
    for value in itertools.permutations(v):
      yield value

  iterator combination*[T](v:seq[T], r:int):seq[T] =
    for value in itertools.combinations(v, r):
      yield value

  proc copy*[T](a:seq[T], p:Slice[int], b:var seq[T], i = 0) =
    for j in p:
      b[i + j - p.a] = a[j]
  proc reverse*[T](a:var seq[T], p:Slice[int]) = a.reverse(p.a, p.b)

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

  # https://cpprefjp.github.io/reference/algorithm/nth_element.html

  proc nth_element*[T](a:var openArray[T], first, nth, last: int, comp:proc(a, b:T):bool) =
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

  proc nth_element*[T](a:var openArray[T], first, nth, last: int) =
    proc defaultLess(a, b:T):bool =
      a < b
    nth_element(a, first, nth, last, defaultLess)

  proc nth_element*[T](a:var openArray[T], nth: int, comp:proc(a, b:T):bool) =
    nth_element(a, 0, nth, a.len, comp)

  proc nth_element*[T](a:var openArray[T], nth: int) =
    proc defaultLess(a, b:T):bool =
      a < b
    nth_element(a, 0, nth, a.len, defaultLess)
  
  # https://cpprefjp.github.io/reference/algorithm/set_union.html
  proc setUnion*[T](u, v: seq[T]):seq[T] =
    result = newSeq[T]()
    var (i,j) = (0,0)
    while true:
      if i < u.len:
        if j < v.len:
          if u[i] < v[j]:result.add(u[i]);i+=1
          elif u[i] > v[j]:result.add(v[j]);j+=1
          else: result.add(v[j]);i+=1;j+=1
        else:
          result.add(u[i]);i+=1
      else:
        if j < v.len:
          result.add(v[j]);j+=1
        else:
          break



