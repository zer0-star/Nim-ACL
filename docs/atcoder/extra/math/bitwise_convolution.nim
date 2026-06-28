when not declared ATCODER_BITWISE_CONVOLUTION_HPP:
  const ATCODER_BITWISE_CONVOLUTION_HPP* = 1

  # result_k = sum a_i * b_j, i&j=k 
  proc AndConvolution*[T](a, b:seq[T]):seq[T] =
    assert a.len == b.len
    let n = a.len
    var (a, b) = (a, b)
    result = newSeq[T](n)
    # FWT
    block:
      var i = 1
      while i < n:
        for j in 0..<n:
          if (i and j) == 0: a[j] += a[j or i];b[j] += b[j or i]
        i = i shl 1
    for i in 0..<n: result[i] = a[i] * b[i]
    # IFWT
    block:
      var i = 1
      while i < n:
        for j in 0..<n:
          if (i and j) == 0: result[j] -= result[j or i]
        i = i shl 1

  # result_k = sum a_i * b_j, i|j=k 
  proc OrConvolution*[T](a, b:seq[T]):seq[T] =
    assert a.len == b.len
    let n = a.len
    var (a, b) = (a, b)
    result = newSeq[T](n)
    # FWT
    block:
      var i = 1
      while i < n:
        for j in 0..<n:
          if (i and j) == 0: a[i or j] += a[j]; b[i or j] += b[j]
        i = i shl 1
    for i in 0..<n: result[i] = a[i]*b[i]
    # IFWT
    block:
      var i = 1
      while i < n:
        for j in 0..<n:
          if (i and j) == 0: result[j or i] -= result[j]
        i = i shl 1
