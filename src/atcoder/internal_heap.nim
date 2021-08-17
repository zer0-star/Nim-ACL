when not declared ATCODER_INTERNAL_HEAP:
  const ATCODER_INTERNAL_HEAP* = 1
  proc push_heap*[T](v: var openArray[T], p:Slice[int]) {.inline.} =
    var i = p.b
    while i > 0:
      var p = (i - 1) shr 1
      if v[p] < v[i]: swap v[p], v[i]
      else: break
      i = p
  proc pop_heap*[T](v: var openArray[T], p:Slice[int]) {.inline.} =
    swap v[0], v[p.b]
    var p = p
    p.b.dec
    var i = 0
    while true:
      var (c0, c1) = (i * 2 + 1, i * 2 + 2)
      if c1 in p:
        if v[c1] > v[i]:
          if v[c0] > v[c1]:
            swap(v[i], v[c0])
            i = c0
          else:
            swap(v[i], v[c1])
            i = c1
        elif v[c0] > v[i]:
          swap(v[i], v[c0])
          i = c0
        else:
          break
      elif c0 in p:
        if v[c0] > v[i]:
          swap(v[i], v[c0])
          i = c0
        else:
          break
      else:
        break
