import std/unittest
import atcoder/extra/structure/set_map

test "sortedSet, int":
  var a = initSortedSet[int]()
  a.insert(3)
  a.insert(1)
  a.insert(4)
  a.insert(1)
  a.insert(5)
  check a{0} == 1
  check a{1} == 3
  check a{2} == 4
  check a{3} == 5
  a.erase(1)
  check a{1} == 4
  check a{2} == 5

test "sortedMap, strind, int":
  var a = initSortedMap[string, int]()
  a["three"] = 3
  a["one"] = 2
  check a{0} == ("one", 2)
  a["four"] = 4
  a["one"] = 1
  a["five"] = 5
  check a{0} == ("five", 5)
  check a{1} == ("four", 4)
  check a{2} == ("one", 1)
  check a{3} == ("three", 3)

test "sortedMultiSet, int":
  var a = initSortedMultiSet[int]()
  a.insert(3)
  a.insert(1)
  a.insert(4)
  a.insert(1)
  a.insert(5)
  check a{0} == 1
  check a{1} == 1
  check a{2} == 3
  check a{3} == 4
  check a{4} == 5
  a.erase(1)
  check a{0} == 1
  check a{1} == 3
  check a{2} == 4
  check a{3} == 5

test "sortedMultiMap, strind, int":
  var a = initSortedMultiMap[string, int]()
  a.insert(("three", 3))
  a.insert(("one", 100))
  a.insert(("four", 4))
  a.insert(("one", 1))
  a.insert(("five", 5))
  a.insert(("one", 3))
  check a{0} == ("five", 5)
  check a{1} == ("four", 4)
  check a{2} == ("one", 100)
  check a{3} == ("one", 1)
  check a{4} == ("one", 3)
  check a{5} == ("three", 3)
