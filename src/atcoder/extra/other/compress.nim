when not declared ATCODER_COMPRESS_HPP:
  const ATCODER_COMPRESS_HPP* = 1
  type Compress[T] = seq[T]

  proc build*[T](v:var Compress[T]) =
    v = v.toSet.toSeq.sorted
  proc initCompress*[T](a:varargs[seq[T]]):Compress[T] =
    if a.len == 0:return
    for p in a:
      for x in p: result.add(x)
    result.build
  proc id*[T](c:Compress[T], a:T):int =
    result = c.binarySearch(a)
    assert result != -1, "Error: No such value: " & $a
  proc val*[T](c:Compress[T], i:int):T = c[i]
