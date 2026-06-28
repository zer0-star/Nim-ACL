when not declared ATCODER_INTERNAL_CSR_HPP:
  const ATCODER_INTERNAL_CSR_HPP* = 1

  type csr*[E] = object
    start*: seq[int]
    elist*: seq[E]
  proc initCsr*[E](n:int, edges:seq[(int, E)]):csr[E] =
    var start = newSeq[int](n + 1)
    var elist = newSeq[E](edges.len)
    for e in edges: start[e[0] + 1].inc
    for i in 1..n: start[i] += start[i - 1]
    var counter = start
    for e in edges:
      elist[counter[e[0]]] = e[1]
      counter[e[0]].inc
    return csr[E](start:start, elist:elist)
