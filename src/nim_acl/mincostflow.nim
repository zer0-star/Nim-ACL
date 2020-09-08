{.hints:off checks:off assertions:on checks:off}
# header {{{
import algorithm, sequtils, tables, macros, math, sets, strutils, streams, strformat, sugar
when defined(MYDEBUG):
  import header

proc scanf(formatstr: cstring){.header: "<stdio.h>", varargs.}
proc getchar(): char {.header: "<stdio.h>", varargs.}
proc nextInt(base:int = 0): int =
  scanf("%lld",addr result)
  result -= base
proc nextFloat(): float = scanf("%lf",addr result)
proc nextString(): string =
  var get = false;result = ""
  while true:
    var c = getchar()
    if int(c) > int(' '): get = true;result.add(c)
    elif get: break
template `max=`*(x,y:typed):void = x = max(x,y)
template `min=`*(x,y:typed):void = x = min(x,y)
template inf(T): untyped = 
  when T is SomeFloat: T(Inf)
  elif T is SomeInteger: ((T(1) shl T(sizeof(T)*8-2)) - (T(1) shl T(sizeof(T)*4-1)))
  else: assert(false)

# }}}


when not defined ATCODER_MINCOSTFLOW_HPP:
  const ATCODER_MINCOSTFLOW_HPP = 1

  import heapqueue, sequtils

#include <algorithm>
#include <cassert>
#include <limits>
#include <queue>
#include <vector>

  type edge[Cap, Cost] = object
    dst, rev:int
    cap:Cap
    cost:Cost

  type mcf_graph[Cap, Cost] = object
    n:int
    pos:seq[(int,int)]
    g:seq[seq[edge[Cap, Cost]]]

  type edge_info[Cap, Cost] = object
    src, dst:int
    cap, flow: Cap
    cost: Cost

  proc initMCFGraph[Cap, Cost](n:int):auto = mcf_graph[Cap, Cost](n:n, g:newSeq[seq[edge[Cap, Cost]]](n))

  proc add_edge[Cap, Cost](self: var mcf_graph[Cap, Cost], src:int, dst:int, cap:Cap, cost:Cost):int {.discardable.} =
    assert src in 0..<self.n
    assert dst in 0..<self.n
    let m = self.pos.len
    self.pos.add((src, self.g[src].len))
    self.g[src].add(edge[Cap, Cost](dst:dst, rev:self.g[dst].len, cap:cap, cost:cost))
    self.g[dst].add(edge[Cap, Cost](dst:src, rev:self.g[src].len - 1, cap:Cap(0), cost: -cost))
    return m

  proc get_edge[Cap, Cost](self: mcf_graph[Cap, Cost], i:int):edge_info[Cap, Cost] =
    let m = self.pos.len
    assert 0 <= i and i < m
    let e = self.g[self.pos[i][0]][self.pos[i][1]]
    let re = self.g[e.dst][e.rev]
    return edge_info[Cap, Cost](src:self.pos[i][0], dst:e.dst, cap:e.cap + re.cap, flow:re.cap, cost:e.cost)

  proc edges[Cap, Cost](self: mcf_graph[Cap, Cost]):seq[edge_info[Cap, Cost]] =
    let m = self.pos.len
    result = newSeq[edge_info[Cap, Cost]](m)
    for i in 0..<m:
      result[i] = self.get_edge(i)

  proc flow[Cap, Cost](self: var mcf_graph[Cap, Cost], s,t:int):(Cap, Cost) =
    self.flow(s, t, Cap.high)
  proc flow[Cap, Cost](self: var mcf_graph[Cap, Cost], s,t:int, flow_limit:Cap):(Cap, Cost) =
    self.slope(s, t, flow_limit)[^1]
  proc slope[Cap, Cost](self: var mcf_graph[Cap, Cost], s,t:int):(Cap, Cost) =
    self.slope(s, t, Cap.high)

  type Q[Cost] = object
    key:Cost
    dst:int
  proc `<`[Cost](l,r:Q[Cost]):bool = l.key < r.key

  proc slope[Cap, Cost](self: var mcf_graph[Cap, Cost], s, t:int, flow_limit:Cap):seq[(Cap, Cost)] =
    assert s in 0..<self.n
    assert t in 0..<self.n
    assert s != t
    # variants (C = maxcost):
    # -(n-1)C <= dual[s] <= dual[i] <= dual[t] = 0
    # reduced cost (= e.cost + dual[e.src] - dual[e.to]) >= 0 for all edge
    var
      dual = newSeqWith(self.n, Cost(0))
      dist = newSeq[Cost](self.n)
      pv, pe = newSeq[int](self.n)
      vis = newSeq[bool](self.n)
    proc dual_ref(self:var mcf_graph[Cap, Cost]):bool =
      dist.fill(Cost.high)
      pv.fill(-1)
      pe.fill(-1)
      vis.fill(false)
      var que = initHeapQueue[Q[Cost]]()
      dist[s] = 0
      que.push(Q[Cost](key:Cost(0), dst:s))
      while que.len > 0:
        let v = que.pop().dst
        if vis[v]: continue
        vis[v] = true
        if v == t: break
        # dist[v] = shortest(s, v) + dual[s] - dual[v]
        # dist[v] >= 0 (all reduced cost are positive)
        # dist[v] <= (n-1)C
        for i in 0..<self.g[v].len:
          let e = self.g[v][i]
          if vis[e.dst] or e.cap == 0: continue
          # |-dual[e.dst] + dual[v]| <= (n-1)C
          # cost <= C - -(n-1)C + 0 = nC
          let cost = e.cost - dual[e.dst] + dual[v]
          if dist[e.dst] - dist[v] > cost:
            dist[e.dst] = dist[v] + cost
            pv[e.dst] = v
            pe[e.dst] = i
            que.push(Q[Cost](key:dist[e.dst], dst:e.dst))
      if not vis[t]:
        return false

      for v in 0..<self.n:
        if not vis[v]: continue
        # dual[v] = dual[v] - dist[t] + dist[v]
        #     = dual[v] - (shortest(s, t) + dual[s] - dual[t]) + (shortest(s, v) + dual[s] - dual[v])
        #     = - shortest(s, t) + dual[t] + shortest(s, v)
        #     = shortest(s, v) - shortest(s, t) >= 0 - (n-1)C
        dual[v] -= dist[t] - dist[v]
      return true
    var
      flow = Cap(0)
      cost = Cost(0)
      prev_cost = -1
    result = newSeq[(Cap, Cost)]()
    result.add((flow, cost))
    while flow < flow_limit:
      if not self.dual_ref(): break
      var c = flow_limit - flow
      var v = t
      while v != s:
        c = min(c, self.g[pv[v]][pe[v]].cap)
        v = pv[v]
      v = t
      while v != s:
        var e = self.g[pv[v]][pe[v]].addr
        e[].cap -= c
        self.g[v][e[].rev].cap += c
        v = pv[v]
      let d = -dual[s]
      flow += c
      cost += c * d
      if prev_cost == d:
        discard result.pop()
      result.add((flow, cost))
      prev_cost = cost

# namespace atcoder

#endif  # ATCODER_MINCOSTFLOW_HPP

let n, k = nextInt()
var g = initMCFGraph[int,int](n * 2 + 2)
let (s, t) = (n * 2, n * 2 + 1)
let BIG = 1000000000

g.add_edge(s, t, n * k, BIG)

for i in 0..<n:
  g.add_edge(s, i, k, 0)
  g.add_edge(n + i, t, k, 0)

for i in 0..<n:
  for j in 0..<n:
    let a = nextInt()
    g.add_edge(i, n + j, 1, BIG - a)

var result = g.flow(s, t, n * k)
echo n * k * BIG - result[1]

var grid = newSeqWith(n, '.'.repeat(n))
let es = g.edges()
for e in es:
  if e.src == s or e.dst == t or e.flow == 0: continue
  grid[e.src][e.dst - n] = 'X'

for i in 0..<n:
  echo grid[i]
