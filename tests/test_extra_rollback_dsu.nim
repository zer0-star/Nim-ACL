discard """
  cmd: "nim cpp -r $file"
"""

import std/unittest
import std/algorithm
import atcoder/extra/structure/rollback_dsu

proc sortedGroups(gs: seq[seq[int]]): seq[seq[int]] =
  result = gs

  for g in result.mitems:
    g.sort()

  result.sort(proc(a, b: seq[int]): int =
    cmp(a[0], b[0])
  )

test "RollbackDSU basic merge and rollback":
  var uf = initRollbackDSU(5)

  check uf.len == 5
  check uf.componentCount == 5
  check uf.snapshot == 0

  check uf.merge(0, 1) == true
  check uf.merge(2, 3) == true

  check uf.same(0, 1)
  check uf.same(2, 3)
  check not uf.same(0, 2)
  check uf.size(0) == 2
  check uf.componentCount == 3

  let s = uf.snapshot

  check uf.merge(1, 2) == true
  check uf.same(0, 3)
  check uf.size(0) == 4
  check uf.componentCount == 2

  uf.rollback(s)

  check uf.same(0, 1)
  check uf.same(2, 3)
  check not uf.same(0, 2)
  check uf.size(0) == 2
  check uf.size(2) == 2
  check uf.componentCount == 3

  uf.rollback(0)

  for i in 0 ..< 5:
    check uf.leader(i) == i
    check uf.size(i) == 1

  check uf.componentCount == 5
  check uf.snapshot == 0

test "RollbackDSU undo failed merge":
  var uf = initRollbackDSU(3)

  check uf.merge(0, 1) == true

  let s = uf.snapshot

  check uf.merge(0, 1) == false
  check uf.snapshot == s + 1
  check uf.componentCount == 2
  check uf.same(0, 1)

  check uf.undo() == false
  check uf.snapshot == s
  check uf.componentCount == 2
  check uf.same(0, 1)

  check uf.undo() == true
  check uf.snapshot == 0
  check uf.componentCount == 3
  check not uf.same(0, 1)

test "RollbackDSU nested snapshots":
  var uf = initRollbackDSU(6)

  let s0 = uf.snapshot

  discard uf.merge(0, 1)
  discard uf.merge(1, 2)

  let s1 = uf.snapshot

  discard uf.merge(3, 4)

  let s2 = uf.snapshot

  discard uf.merge(2, 3)

  check uf.same(0, 4)
  check uf.componentCount == 2

  uf.rollback(s2)

  check not uf.same(0, 4)
  check uf.same(3, 4)
  check uf.componentCount == 3

  uf.rollback(s1)

  check uf.same(0, 2)
  check not uf.same(3, 4)
  check uf.componentCount == 4

  uf.rollback(s0)

  for i in 0 ..< 6:
    check uf.size(i) == 1

  check uf.componentCount == 6

test "RollbackDSU groups":
  var uf = initRollbackDSU(5)

  discard uf.merge(0, 1)
  discard uf.merge(3, 4)

  check sortedGroups(uf.groups) == @[@[0, 1], @[2], @[3, 4]]

  let s = uf.snapshot

  discard uf.merge(1, 4)

  check sortedGroups(uf.groups) == @[@[0, 1, 3, 4], @[2]]

  uf.rollback(s)

  check sortedGroups(uf.groups) == @[@[0, 1], @[2], @[3, 4]]
