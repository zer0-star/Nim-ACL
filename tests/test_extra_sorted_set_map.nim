discard """
  cmd: "nim cpp -r $file"
"""

import std/unittest

import atcoder/extra/structure/sorted_set_map

test "SortedSet basic":
  var s = initSortedSet[int](countable = true)

  check s.empty()

  s.insert(3)
  s.insert(1)
  s.insert(4)
  s.insert(1)

  check s.len == 3
  check 1 in s
  check 2 notin s
  check 4 in s

  check *s{0} == 1
  check *s{1} == 3
  check *s{2} == 4

  s.erase(3)

  check 3 notin s
  check s.len == 2
  check *s{0} == 1
  check *s{1} == 4

test "SortedMap basic":
  var mp = initSortedMap[string, int](countable = true)

  check mp.empty()

  mp["three"] = 3
  mp["one"] = 100
  mp["one"] = 1
  mp["four"] = 4

  check "one" in mp
  check "two" notin mp

  check mp["one"] == 1
  check mp["four"] == 4

  var xs: seq[(string, int)] = @[]
  for k, v in mp:
    xs.add((k, v))

  check xs == @[("four", 4), ("one", 1), ("three", 3)]

  mp.erase("one")

  check "one" notin mp

test "SortedMultiSet erase removes equal range":
  var s = initSortedMultiSet[int](countable = true)

  s.insert(2)
  s.insert(1)
  s.insert(2)
  s.insert(3)

  check 2 in s
  s.erase(2)
  check 2 notin s
  check s.len == 2

test "custom comparator descending":
  proc desc(a, b:int):bool = a > b

  var s = initSortedSet[int](countable = true, desc)

  s.insert(3)
  s.insert(1)
  s.insert(4)

  check *s{0} == 4
  check *s{1} == 3
  check *s{2} == 1
