import std/unittest

import std/algorithm, std/sequtils, std/sets, std/tables
import random
# TODO: includeじゃないとだめなの治す
import atcoder/extra/structure/set_map
#{.checks:on.}

test "sortedSet, int":
  var a = initSortedSet[int]()
  check a.empty()
  a.checkTree()
  a.insert(3)
  a.checkTree()
  a.insert(1)
  a.checkTree()
  a.insert(4)
  a.checkTree()
  a.insert(1)
  a.checkTree()
  a.insert(5)
  a.checkTree()
  check 4 in a
  var it = a.find(4)
  check it != a.end() and *it == 4
  check 2 notin a
  check a.find(2) == a.end()
  a.erase(4)
  check 4 notin a
  check a.find(4) == a.end()
  a.checkTree()

test "CountableSortedSet, int":
  var a = initSortedSet[int](true)
  check a.empty()
  a.checkTree()
  a.insert(3)
  a.checkTree()
  a.insert(1)
  a.checkTree()
  a.insert(4)
  a.checkTree()
  a.insert(1)
  a.checkTree()
  a.insert(5)
  a.checkTree()
  check 4 in a
  var it = a.find(4)
  check it != a.end() and *it == 4
  check 2 notin a
  check a.find(2) == a.end()
  check *a{0} == 1
  check *a{1} == 3
  check *a{2} == 4
  check *a{3} == 5
  for i in 0..<a.len:
    check a{i}.index == i
  a.erase(4)
  a.checkTree()
  check 4 notin a
  check a.find(4) == a.end()
  check *a{0} == 1
  check *a{1} == 3
  check *a{2} == 5
  for i in 0..<a.len:
    check a{i}.index == i
  check 3 in a
  a.erase(3)
  a.checkTree()
  check 3 notin a
  check *a{0} == 1
  check *a{1} == 5

test "CountableSortedSet, int, reverse":
  proc f(a, b:int):bool = a > b
  var a = initSortedSet[int](true, f)
  check a.empty()
#  var a = initSortedSet(int, true)
  a.checkTree()
  a.insert(3)
  a.checkTree()
  a.insert(1)
  a.checkTree()
  a.insert(4)
  a.checkTree()
  a.insert(1)
  a.checkTree()
  a.insert(5)
  a.checkTree()
  check 4 in a
  check a.find(4) != a.end()
  check 2 notin a
  check a.find(2) == a.end()
  check *a{0} == 5
  check *a{1} == 4
  check *a{2} == 3
  check *a{3} == 1
  for i in 0..<a.len:
    check a{i}.index == i
  a.erase(4)
  a.checkTree()
  check 4 notin a
  check *a{0} == 5
  check *a{1} == 3
  check *a{2} == 1
  for i in 0..<a.len:
    check a{i}.index == i
  check 3 in a
  a.checkTree()
  a.erase(3)
  a.checkTree()
  check 3 notin a
  check *a{0} == 5
  check *a{1} == 1

test "sortedMap, strind, int":
  var a = initSortedMap[string, int]()
  check a.empty()
  a["three"] = 3
  a.checkTree()
  a["one"] = 2
  a.checkTree()
  a["four"] = 4
  a.checkTree()
  a["one"] = 1
  a.checkTree()
  a["five"] = 5
  a.checkTree()
  check "four" in a
  check a["four"] == 4
  check "hoge" notin a
  a.erase("four")
  a.checkTree()
  check "four" notin a

test "sortedMultiSet, int":
  var a = initSortedMultiSet[int](countable = true)
  a.checkTree()
  check a.empty()
  a.insert(3)
  a.checkTree()
  a.insert(1)
  a.checkTree()
  a.insert(4)
  a.checkTree()
  a.insert(1)
  a.checkTree()
  a.insert(5)
  a.checkTree()
  check 1 in a
  check 7 notin a
  a.erase(1)
  check 1 notin a

test "sortedMultiMap, string, int":
  var a = initSortedMultiMap[string, int](countable = true)
  check a.empty()
  a.checkTree()
  a.insert(("three", 3))
  a.checkTree()
  a.insert(("one", 100))
  a.checkTree()
  a.insert(("four", 4))
  a.checkTree()
  a.insert(("one", 1))
  a.checkTree()
  a.insert(("five", 5))
  a.checkTree()
  a.insert(("one", 3))
  a.checkTree()
  check "one" in a
  check "hundred" notin a
  a.erase("one")
  a.checkTree()
  check "one" notin a


test "sortedSet, int":
  var rnd = initRand(2021)
  var st = initSortedSet[int]()
  #var st = SortedSet(int).default
  check st.empty()
  var v = newSeq[int]()
  for i in 0..1000:
    let t = rnd.rand(1..2)
    if t == 1: # insert
      let r = rnd.rand(1..30)
      v.add(r)
      v = v.toHashSet.toSeq.sorted
      st.insert(r)
      st.checkTree()
    elif t == 2: # erase
      var r = rnd.rand(1..30)
      if r notin st: continue
      var v2 = newSeq[int]()
      for p in v.mitems:
        if p == r: continue
        v2.add(p)
      swap(v, v2)
      st.erase(r)
      st.checkTree()
    else:
      check false
    var v2 = newSeq[int]()
    for t in st:
      v2.add(t)
    check v == v2

test "sortedMap, int":
  var rnd = initRand(2021)
  var st = initSortedMap[int, int](true)
  check st.empty()
  st.checkTree()
  var v = initTable[int, int]()
  for i in 0..1000:
    let t = rnd.rand(1..2)
    if t == 1:
      let r, s = rnd.rand(1..30)
      if r notin v: v[r] = 0
      v[r] = s
      st[r] = s
      st.checkTree()
    elif t == 2:
      let r = rnd.rand(1..30)
      if r notin st: continue
      v.del(r)
      while r in st: st.erase(r); st.checkTree()
    else:
      check false
    var v2 = newSeq[(int, int)]()
    for k,v in st:
      v2.add((k,v))
    var v3 = newSeq[(int, int)]()
    for k,v in v:
      v3.add((k,v))
    v3.sort
    check v3 == v2
  var v3 = newSeq[(int, int)]()
  for k,v in v:
    v3.add((k,v))
  v3.sort
  for i in 0..<v.len:
    check v3[i] == *st{i}
    check st{i}.index == i

test "sortedMultiSet, int":
  var rnd = initRand(2021)
  var st = initSortedMultiSet[int](true)
  check st.empty()
  var v = newSeq[int]()
  for i in 0..1000:
    let t = rnd.rand(1..2)
    if t == 1: # insert
      let r = rnd.rand(1..30)
      st.insert(r)
      st.checkTree()
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
      st.erase(r)
      #while r in st: st.erase(r);st.checkTree()
    else:
      check false
    var v2 = newSeq[int]()
    for t in st:
      v2.add(t)
    check v == v2
  for i in 0..<v.len:
    check v[i] == *st{i}
    check st{i}.index == i

test "sortedMultiMap, int":
  var rnd = initRand(2021)
  var st = initSortedMultiMap[int, int](countable = true)
  check st.empty()
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
      st.checkTree()
    elif t == 2:
      let r = rnd.rand(1..30)
      if r notin st: continue
      var v2 = newSeq[(int, int)]()
      for p in v.mitems:
        if p[0] != r: v2.add(p)
      swap(v, v2)
      while r in st: st.erase(r);st.checkTree()
    else:
      check false
    var v2 = newSeq[(int, int)]()
    for k,v in st:
      v2.add((k,v))
    check v == v2

# TODO: MapのMapができない。昔はできていた。test環境外では動く。unittestが悪いっぽい
#test "sortedMapMultiDimension, int":
#  var st = initSortedMap[int, SortedMap(int, SortedMap(int, SortedMap(int, int)))]()
#  check st.empty()
#  const B = 10
#  for i in 0..<B:
#    for j in 0..<B:
#      for k in 0..<B:
#        for l in 0..<B:
#          st[i][j][k][l] = i * j * k * l
#  for i in 0..<B:
#    for j in 0..<B:
#      for k in 0..<B:
#        for l in 0..<B:
#          check st[i][j][k][l] == i * j * k * l

test "sortedMultiSet, erase range":
  var st = initSortedMultiSet[int](countable = true)
  for b in [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]:
    st.insert(b)
  check $st == "{1, 1, 2, 3, 3, 4, 5, 5, 5, 6, 9}"
  st.erase(5)
  check $st == "{1, 1, 2, 3, 3, 4, 6, 9}"
