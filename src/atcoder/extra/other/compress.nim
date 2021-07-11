when not declared ATCODER_COMPRESS_HPP:
  const ATCODER_COMPRESS_HPP* = 1
  type Compless[T] = seq[T]

  proc initCompress*[T](a:varargs[seq[T]]):seq[T] =
    var v = newSeq[int]()
    for p in a:
      for x in p: v.add(x)
    v = v.toSet.toSeq.sorted
    return v

  proc id*[T](c:Compless[T], a:T):int =
    result = c.binarySearch(a)
    assert result != -1, "Error: No such value: " & $a
  proc val*[T](c:Compless[T], i:int):T = c[i]
