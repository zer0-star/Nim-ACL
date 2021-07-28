import std/unittest

import std/algorithm, std/sequtils, std/sets, std/tables
import random, sugar
# TODO: includeじゃないとだめなの治す
include atcoder/extra/structure/set_map
{.checks:on.}

#block:
#  type S[T:static[bool], p] = object
#    a:int
#    when T:
#      b:int
#  
#  var a:S[false, (3, 4)]
#  var b:S[true, (4, 5)]
#  
#  echo a
#  echo b
#  
#  proc f():auto =
#    result = S[true, (5, 6)](a:12, b:13)
#  
#  echo f()

test "sortedSet, int":
  var a = initSortedSet(int)
  a.insert(3)
  a.insert(1)
  a.insert(4)
  a.insert(1)
  a.insert(5)
  assert 4 in a
  assert 2 notin a
  a.erase(4)
  assert 4 notin a

test "CountableSortedSet, int":
  var a = initSortedSet(int, true)
  a.insert(3)
  a.insert(1)
  a.insert(4)
  a.insert(1)
  a.insert(5)
  check 4 in a
  check 2 notin a
  check *a{0} == 1
  check *a{1} == 3
  check *a{2} == 4
  check *a{3} == 5
  a.erase(4)
  check 4 notin a
  check *a{0} == 1
  check *a{1} == 3
  check *a{2} == 5
  check 3 in a
  a.erase(3)
  check 3 notin a
  check *a{0} == 1
  check *a{1} == 5

test "CountableSortedSet, int, reverse":
  proc f(a, b:int):bool = a > b
  var a = initSortedSet(int, true, f)
#  var a = initSortedSet(int, true)
  a.insert(3)
  a.insert(1)
  a.insert(4)
  a.insert(1)
  a.insert(5)
  check 4 in a
  check 2 notin a
  check *a{0} == 5
  check *a{1} == 4
  check *a{2} == 3
  check *a{3} == 1
  a.erase(4)
  check 4 notin a
  check *a{0} == 5
  check *a{1} == 3
  check *a{2} == 1
  check 3 in a
  a.erase(3)
  check 3 notin a
  check *a{0} == 5
  check *a{1} == 1

test "sortedMap, strind, int":
  var a = initSortedMap(string, int)
  a["three"] = 3
  a["one"] = 2
  a["four"] = 4
  a["one"] = 1
  a["five"] = 5
  assert "four" in a
  assert a["four"] == 4
  assert "hoge" notin a
  a.erase("four")
  assert "four" notin a

test "sortedMultiSet, int":
  var a = initSortedMultiSet(int)
  a.insert(3)
  a.insert(1)
  a.insert(4)
  a.insert(1)
  a.insert(5)
  assert 1 in a
  assert 7 notin a
  a.erase(1)
  assert 1 in a
  a.erase(1)
  assert 1 notin a

test "sortedMultiMap, string, int":
  var a = initSortedMultiMap(string, int, isCountable = false)
  a.insert(("three", 3))
  a.insert(("one", 100))
  a.insert(("four", 4))
  a.insert(("one", 1))
  a.insert(("five", 5))
  a.insert(("one", 3))
  assert "one" in a
  assert "hundred" notin a
  a.erase("one")
  assert "one" in a
  a.erase("one")
  assert "one" in a
  a.erase("one")
  assert "one" notin a


test "sortedSet, int":
  var rnd = initRand(2021)
#  var st = initSortedSet(int)
  var st = SortedSet(int).default
  var v = newSeq[int]()
  for i in 0..1000:
    let t = rnd.rand(1..2)
    if t == 1: # insert
      let r = rnd.rand(1..30)
      v.add(r)
      v = v.toHashSet.toSeq.sorted
      st.insert(r)
    elif t == 2: # erase
      var r = rnd.rand(1..30)
      if r notin st: continue
      var v2 = newSeq[int]()
      for p in v.mitems:
        if p == r: continue
        v2.add(p)
      swap(v, v2)
      st.erase(r)
    else:
      assert false
    var v2 = newSeq[int]()
    for t in st:
      v2.add(t)
    assert v == v2

test "sortedMap, int":
  var rnd = initRand(2021)
  var st = initSortedMap(int, int, true)
  var v = initTable[int, int]()
  for i in 0..1000:
    let t = rnd.rand(1..2)
    if t == 1:
      let r, s = rnd.rand(1..30)
      if r notin v: v[r] = 0
      v[r] = s
      st[r] = s
    elif t == 2:
      let r = rnd.rand(1..30)
      if r notin st: continue
      v.del(r)
      while r in st: st.erase(r)
    else:
      assert false
    var v2 = newSeq[(int, int)]()
    for k,v in st:
      v2.add((k,v))
    var v3 = newSeq[(int, int)]()
    for k,v in v:
      v3.add((k,v))
    v3.sort
    assert v3 == v2
  var v3 = newSeq[(int, int)]()
  for k,v in v:
    v3.add((k,v))
  v3.sort
  for i in 0..<v.len:
    check v3[i] == *st{i}

test "sortedMultiSet, int":
  var rnd = initRand(2021)
  var st = initSortedMultiSet(int, true)
  var v = newSeq[int]()
  for i in 0..1000:
    let t = rnd.rand(1..2)
    if t == 1: # insert
      let r = rnd.rand(1..30)
      st.insert(r)
      v.add(r)
      v.sort()
    elif t == 2: # erase
      var r = rnd.rand(1..30)
      if r notin st: continue
      var v2 = newSeq[int]()
      for p in v.mitems:
        if p == r: continue
        v2.add(p)
      swap(v, v2)
      while r in st: st.erase(r)
    else:
      assert false
    var v2 = newSeq[int]()
    for t in st:
      v2.add(t)
    assert v == v2
  for i in 0..<v.len:
    check v[i] == *st{i}

test "sortedMultiMap, int":
  var rnd = initRand(2021)
  var st = initSortedMultiMap(int, int)
  var v = newSeq[(int, int)]()
  var s = 0
  for i in 0..1000:
    let t = rnd.rand(1..2)
    if t == 1:
      s.inc
      let r = rnd.rand(1..30)
      v.add((r, s))
      v.sort()
      st.insert((r, s))
    elif t == 2:
      let r = rnd.rand(1..30)
      if r notin st: continue
      var v2 = newSeq[(int, int)]()
      for p in v.mitems:
        if p[0] != r: v2.add(p)
      swap(v, v2)
      while r in st: st.erase(r)
    else:
      assert false
    var v2 = newSeq[(int, int)]()
    for k,v in st:
      v2.add((k,v))
    assert v == v2

test "sortedMapMultiDimension, int":
  var st = initSortedMap(int, SortedMap(int, SortedMap(int, SortedMap(int, int))))
  const B = 10
  for i in 0..<B:
    for j in 0..<B:
      for k in 0..<B:
        for l in 0..<B:
          st[i][j][k][l] = i * j * k * l
  for i in 0..<B:
    for j in 0..<B:
      for k in 0..<B:
        for l in 0..<B:
          assert st[i][j][k][l] == i * j * k * l
