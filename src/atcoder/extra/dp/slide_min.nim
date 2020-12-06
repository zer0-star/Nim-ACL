import deques

# slide min {{{
proc slideMin[T](v:seq[T], k:int):seq[T] =
  var deq = initDeque[T]()
  result = newSeq[T]()
  for i in 0..<v.len:
    while deq.len > 0 and v[deq[^1]] >= v[i]:
      discard deq.popLast()
    deq.addLast(i)
    if i - k + 1 >= 0:
      result.add(v[deq[0]])
      if deq[0] == i - k + 1: deq.popFirst()
# }}}
