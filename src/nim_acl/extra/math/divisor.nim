# {{{ divisor
when not declared ATCODER_DEVISOR_HPP:
  const ATCODER_DEVISOR_HPP* = 1
  import algorithm
  proc divisor*(n:int):seq[int] =
    result = newSeq[int]()
    var i = 1
    while i * i <= n:
      if n mod i == 0:
        result.add(i)
        if i * i != n: result.add(n div i)
      i += 1
    result.sort(cmp[int])
# }}}
