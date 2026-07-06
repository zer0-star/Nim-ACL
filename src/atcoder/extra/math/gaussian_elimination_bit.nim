when not declared ATCODER_GAUSSIAN_ELIMINATION_HPP:
  const ATCODER_GAUSSIAN_ELIMINATION_HPP* = 1
  proc base*[T](a:seq[T], n:int):tuple[base:seq[T], pivot:seq[int], rest: seq[T]] =
    ## 0 ..< nでのビットの基底を求める(ガロア体と見ることができる？)
    ## base: 得られた基底
    ## pivot: base[i]のpivot[i]番目のビットは1になっていて、他のbase[j]については全部0になっている
    ## rest: 0 ..< nの範囲に収まらなかったもの。(0 ..< nのビットは全部0になっている)
    var
      a = a
      base: seq[T]
      pivot: seq[int]
    for p in 0 ..< n:
      var
        i0 = pivot.len
        i = i0
      while i < a.len:
        if a[i][p] == 1:
          swap a[i], a[i0]
          break
        i.inc
      if i == a.len: continue
      doAssert a[i0][p] == 1
      pivot.add p
      for j in 0 ..< a.len:
        if i0 == j: continue
        if a[j][p] == 1:
          a[j] = a[j] xor a[i0]
    for i in 0 ..< pivot.len:
      base.add a[i]
    var rest = a[pivot.len .. ^1]
    return (base, pivot, rest)
