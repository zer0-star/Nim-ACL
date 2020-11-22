# segment graph {{{
when not declared ATCODER_SEGMENT_GRAPH_HPP:
  const ATCODER_SEGMENT_GRAPH_HPP* = 1
  import atcoder/extra/other/floatutils
  import atcoder/extra/geometry/geometry_template
  # http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=1033
  # deduplication of line segments
  proc merge_segments*[Real](segs: var seq[Segment[Real]]) =
    proc merge_if_able(s1: var Segment[Real], s2: Segment[Real]):bool =
      if abs(cross(s1.b - s1.a, s2.b - s2.a)) >~ 0.Real: return false
      if ccw(s1.a, s2.a, s1.b) == 1 or ccw(s1.a, s2.a, s1.b) == -1: return false
      if ccw(s1.a, s1.b, s2.a) == -2 or ccw(s2.a, s2.b, s1.a) == -2: return false
      s1 = initSegment(min(s1.a, s2.a), max(s1.b, s2.b))
      return true
  
    for i in 0..<segs.len:
      if segs[i].b <~ segs[i].a: swap(segs[i].a, segs[i].b)
    for i in 0..<segs.len:
      var j = i + 1
      while j < segs.len:
        if merge_if_able(segs[i], segs[j]):
          segs[j] = segs.pop()
          j.dec
        j.inc
  # http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=1033
  # construct a graph with the vertex of the intersection of any two line segments
  proc segment_arrangement*[Real](segs: seq[Segment[Real]]):(seq[Point[Real]], seq[seq[int]]) =
    var ps = newSeq[Point[Real]]()
    let N = segs.len
    for i in 0..<N:
      ps.add(segs[i].a)
      ps.add(segs[i].b)
      for j in i+1..<N:
        let 
          p1 = segs[i].b - segs[i].a
          p2 = segs[j].b - segs[j].a
        if cross(p1, p2) == 0: continue
        if intersect(segs[i], segs[j]):
          ps.add(crosspoint(segs[i], segs[j]))
  # psをdeduplicateしたい。。。
#    ps.sort(cmp[Point])
    ps.sort() do (a, b:Point[Real])->int:
      if a <~ b: return -1
      elif a >~ b:return 1
      else: return 0
    block:
      var h, i = 0
      while i < ps.len:
        var j = i
        while j < ps.len and ps[i] == ps[j]: j.inc
        swap(ps[h], ps[i])
        i = j
        h.inc
      ps.setLen(h)
  
    let M = ps.len
    var g = newSeq[seq[int]](M)
    for i in 0..<N:
      var vec = newSeq[int]()
      for j in 0..<M:
        if intersect(segs[i], ps[j]):
          vec.add(j)
      for j in 1..<vec.len:
        g[vec[j - 1]].add(vec[j])
        g[vec[j]].add(vec[j - 1])
    return (ps, g)
  # }}}
