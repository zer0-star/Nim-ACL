# Topological Sort {{{
when not declared ATCODER_TOPOLOGICAL_SORT_HPP:
  const ATCODER_TOPOLOGICAL_SORT_HPP* = 1
  import "src/nim_acl/extra/graph/template"
  proc topologicalSort*(g:Graph[int]):seq[int] =
    let N = g.len
    var deg = newSeq[int](N)
    for i in 0..<N:
      for e in g[i]:
        deg[e.dst].inc
    var st = newSeq[int]()
    for i in 0..<N:
      if deg[i] == 0: st.add(i)
    result = newSeq[int]()
    while st.len > 0:
      let p = st.pop()
      result.add(p)
      for e in g[p]:
        deg[e.dst].dec
        if deg[e.dst] == 0: st.add(e.dst)
# }}}
