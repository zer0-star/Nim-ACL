# https://nyaannyaan.github.io/library/fps/multipoint-evaluation.hpp

when not declared ATCODER_MULTIPOINT_EVALUATION_HPP:
  const ATCODER_MULTIPOINT_EVALUATION_HPP* = 1
  import atcoder/extra/math/formal_power_series
  import atcoder/element_concepts
  type ProductTree[mint] = object
    xs: seq[mint]
    buf: seq[seq[mint]]
    N, xsz: int
    l, r: seq[int]
  proc setLen[T](a: var seq[T], n: int, x: T) =
    if n > a.len:
      a &= x.repeat(n - a.len)
    else:
      a.setLen(n)
  proc initProductTree*[mint: FiniteFieldElem](xs: seq[mint]):ProductTree[mint] =
    result.xs = xs
    result.xsz = xs.len
    var N = 1;
    while N < xs.len: N *= 2
    result.buf.setLen(2 * N)
    result.l.setLen(2 * N, xs.len)
    result.r.setLen(2 * N, xs.len)
    #fps::set_fft();
    when mint.hasFFT:
      for i in 0 ..< result.xsz:
        result.l[i + N] = i
        result.r[i + N] = i + 1
        result.buf[i + N] = @[-xs[i], 1]
      for i in countdown(N - 1, 1):
        result.l[i] = result.l[(i shl 1) or 0]
        result.r[i] = result.r[(i shl 1) or 1]
        if result.buf[(i shl 1) or 0].len == 0:
          continue
        elif result.buf[(i shl 1) or 1].len == 0:
          result.buf[i] = result.buf[(i shl 1) or 0]
        else:
          result.buf[i] = result.buf[(i shl 1) or 0] * result.buf[(i shl 1) or 1]
    else:
      mixin inplace_fft_doubling
      var f: FormalPowerSeries[mint] = newSeqOfCap[mint](N * 2)
      for i in 0 ..< result.xsz:
        result.l[i + N] = i
        result.r[i + N] = i + 1
        result.buf[i + N] = @[-xs[i] + 1, -xs[i] - 1]
      for i in countdown(N - 1, 1):
        result.l[i] = result.l[(i shl 1) or 0]
        result.r[i] = result.r[(i shl 1) or 1]
        if result.buf[(i shl 1) or 0].len == 0:
          continue
        elif result.buf[(i shl 1) or 1].len == 0:
          result.buf[i] = result.buf[(i shl 1) or 0]
        elif result.buf[(i shl 1) or 0].len == result.buf[(i shl 1) or 1].len:
          result.buf[i] = result.buf[(i shl 1) or 0];
          f.setLen(0);
          f = result.buf[(i shl 1) or 1]
          result.buf[i].inplace_fft_doubling()
          f.inplace_fft_doubling()
          for j in 0 ..< result.buf[i].len:
            result.buf[i][j] *= f[j]
        else:
          result.buf[i] = buf[(i shl 1) or 0]
          f = result.buf[(i shl 1) or 1]
          result.buf[i].inplace_fft_doubling()
          f = f.ifft()
          f.resize(buf[i].len, mint(0))
          f = f.ntt()
          for j in 0 ..< result.buf[i].len:
            result.buf[i][j] *= f[j]
      for i in 0 ..< 2 * N:
        result.buf[i] = result.buf[i].ifft()
        result.buf[i].shrink()
  
  proc multipointEvaluationImpl*[mint](f: FormalPowerSeries[mint], xs: seq[mint], ptree: ProductTree[mint]): seq[mint] =
    type fps = FormalPowerSeries[mint]
    var ret = newSeqOfCap[mint](xs.len)
    proc rec(a:fps, idx: int) =
      if ptree.l[idx] == ptree.r[idx]: return
      var a = a
      a = a mod ptree.buf[idx]
      if a.len <= 64:
        for i in ptree.l[idx] ..< ptree.r[idx]:
          ret.add(a.eval(xs[i]))
        return
      rec(a, (idx shl 1) or 0)
      rec(a, (idx shl 1) or 1)
    rec(f, 1)
    return ret

  proc multipointEvaluation*[mint](f: FormalPowerSeries[mint], xs: seq[mint]): seq[mint] =
    if f.len == 0 or xs.len == 0: return newSeq[mint](xs.len)
    return multipointEvaluationImpl(f, xs, initProductTree[mint](xs))
