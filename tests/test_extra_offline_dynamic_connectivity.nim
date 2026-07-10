discard """
  cmd: "nim cpp -r $file"
"""

import std/unittest
import atcoder/extra/graph/offline_dynamic_connectivity

test "OfflineDynamicConnectivity component counts and same queries":
  var dc = initOfflineDynamicConnectivity(n = 4, q = 5)

  # t = 0: 0-1
  # t = 1: 0-1, 1-2
  # t = 2: 0-1, 1-2, 2-3
  # t = 3: 1-2, 2-3
  # t = 4: 1-2
  dc.addEdgeInterval(0, 3, 0, 1)
  dc.addEdgeInterval(1, 5, 1, 2)
  dc.addEdgeInterval(2, 4, 2, 3)

  var
    comp = newSeq[int](5)
    same03 = newSeq[bool](5)
    same13 = newSeq[bool](5)
    size0 = newSeq[int](5)

  dc.run(proc(t: int, uf: RollbackDSU) =
    comp[t] = uf.componentCount
    same03[t] = uf.same(0, 3)
    same13[t] = uf.same(1, 3)
    size0[t] = uf.size(0)
  )

  check comp == @[3, 2, 1, 2, 3]
  check same03 == @[false, false, true, false, false]
  check same13 == @[false, false, true, true, false]
  check size0 == @[2, 3, 4, 1, 1]

test "OfflineDynamicConnectivity componentCounts helper":
  var dc = initOfflineDynamicConnectivity(n = 3, q = 4)

  dc.addEdgeInterval(0, 2, 0, 1)
  dc.addEdgeInterval(1, 4, 1, 2)

  check dc.componentCounts == @[2, 1, 2, 2]

test "OfflineDynamicConnectivity empty and zero-length intervals":
  var dc = initOfflineDynamicConnectivity(n = 3, q = 3)

  dc.addEdgeInterval(1, 1, 0, 1)

  var comp = newSeq[int](3)

  dc.run(proc(t: int, uf: RollbackDSU) =
    comp[t] = uf.componentCount
  )

  check comp == @[3, 3, 3]

test "OfflineDynamicConnectivity nested rollback behavior":
  var dc = initOfflineDynamicConnectivity(n = 6, q = 6)

  dc.addEdgeInterval(0, 6, 0, 1)
  dc.addEdgeInterval(0, 6, 1, 2)
  dc.addEdgeInterval(2, 5, 3, 4)
  dc.addEdgeInterval(3, 4, 2, 3)

  var comp = newSeq[int](6)
  var same04 = newSeq[bool](6)

  dc.run(proc(t: int, uf: RollbackDSU) =
    comp[t] = uf.componentCount
    same04[t] = uf.same(0, 4)
  )

  check comp == @[4, 4, 3, 2, 3, 4]
  check same04 == @[false, false, false, true, false, false]
