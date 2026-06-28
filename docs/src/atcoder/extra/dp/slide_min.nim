when not declared ATCODER_SLIDEMIN_HPP:
  const ATCODER_SLIDEMIN_HPP* = 1
  import std/deques

  proc slideMin*[T](v:seq[T], k:int, cut_first: static[bool] = true):seq[T] =
    when cut_first:
      if v.len < k: return
      result = newSeqOfCap[T](v.len - k + 1)
    else:
      result = newSeqOfCap[T](v.len)
      let l = min(k, v.len)
      if l > 1:
        var m = v[0]
        result.add m
        for i in 1 ..< l - 1:
          m = min(m, v[i])
          result.add m
    var
      #deq = newSeqOfCap[int](v.len)
      deq = newSeqUninitialized[int32](v.len)
      head = 0'i32
      tail = 0'i32
    # head ..< tail
    for i in 0'i32 ..< (v.len).int32:
      #while deq.len > 0 and v[deq[^1]] >= v[i]:
      while tail - head > 0 and v[deq[tail - 1]] >= v[i]:
        #discard deq.popLast()
        tail.dec
      #deq.addLast(i)
      deq[tail] = i
      tail.inc
      if i - k + 1 >= 0:
        #result.add(v[deq[0]])
        result.add(v[deq[head]])
        #if deq[0] == i - k + 1: deq.popFirst()
        if deq[head] == i - k + 1: head.inc
  proc slideMax*[T](v:seq[T], k:int, cut_first: static[bool] = true):seq[T] =
    var v = v
    for i in 0..<v.len: v[i] = -v[i]
    result = slideMin(v, k, cut_first)
    for i in 0..<result.len: result[i] = -result[i]
