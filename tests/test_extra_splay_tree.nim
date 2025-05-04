import std/unittest
import atcoder/extra/structure/splay_tree
import std/random, std/algorithm, std/sequtils

randomize(42)

const
  B = 10
  D = 1000
  C = 1000

when false:
  type P = (int, int)
  proc getP():P = (rand(0 ..< D), rand(0 ..< D))
  proc op(a, b:P):P = (a[0] + b[0], a[1] + b[1])
  proc e():P = (0, 0)
  type Q = int
  proc mapping(f: Q, s:P):P = (f + s[0], f + s[1])
  proc composition(f1, f2: Q):Q = f1 + f2
  proc id():Q = 0
  proc getQ():Q = rand(0 ..< D)
else:
  type P = int
  proc getP():P = rand(0 ..< D)
  proc op(a, b:P):P = max(a, b)
  proc e():P = 0
  type Q = int
  proc mapping(f: Q, s:P):P = f + s
  proc composition(f1, f2: Q):Q = f1 + f2
  proc id():Q = 0
  proc getQ():Q = rand(0 ..< D)

template update_test(st: var SomeSplayTree, v:var seq[P]) =
  if v.len > 0:
    check v == st.toSeq
    let
      i = rand(0 ..< v.len)
      p = getP()
    st[i] = p
    v[i] = p
    check v == st.toSeq

template get_test(st: var SomeSplayTree, v:var seq[P]) =
  if v.len > 0:
    check v == st.toSeq
    let
      i = rand(0 ..< v.len)
    check st[i] == v[i]

template insert_test(st: var SomeSplayTree, v:var seq[P]) =
  var i: int
  let p = getP()
  if v.len > 0:
    i = rand(0 ..< v.len)
  else:
    i = 0
  st.insert_index(i, p)
  v = v[0 ..< i] & p & v[i ..< v.len]
  block:
    let u = st.toSeq
    check v == u
  check v == st.toSeq

template range_test(st: var SomeSplayTree, v:var seq[P]) =
  if v.len > 0:
    var
      i = rand(0 ..< v.len)
      j = rand(0 ..< v.len)
    if i > j: swap(i, j)
    check st[i .. j] == v[i .. j].foldl(op(a, b))

template erase_test(st: var SomeSplayTree, v: var seq[P]) =
  if v.len > 0:
    let
      i = rand(0 ..< v.len)
    st.erase_index(i)
    v = v[0 ..< i] & v[i + 1 ..< v.len]
    check v == st.toSeq
template reverse_test(st: var SomeSplayTree, v: var seq[P]) =
  if v.len > 0:
    var
      i = rand(0 ..< v.len)
      j = rand(0 ..< v.len)
    if i > j: swap(i, j)
    st.reverse(i .. j)
    v = v[0 ..< i] & v[i .. j].reversed & v[j + 1 ..< v.len]
    check v == st.toSeq
template apply_test(st: var SomeSplayTree, v: var seq[P]) =
  if v.len > 0:
    var
      i = rand(0 ..< v.len)
      j = rand(0 ..< v.len)
      f = getQ()
    if i > j: swap(i, j)
    st.apply(i .. j, f)
    for k in i .. j: v[k] = mapping(f, v[k])
    #check v == st.toSeq

block:
  proc op0(a, b:P):P = a + b
  proc e0():P = 0
  proc mapping0(f: Q, s:P):P = f + s
  proc pp0(a:Q, c:int): Q = a * c
  proc composition0(f1, f2: Q):Q = f1 + f2
  proc id0():Q = 0
  proc getQ0():Q = rand(0 ..< D)
  
  test "LazySplayTreeWithP":
    var
      v = @[3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5, 8, 9, 7, 9]
      st = initLazySplayTree[P, Q](op0, mapping0, composition0, pp0, e0(), id0())
  
    st.build(v)
    for _ in 0 ..< B:
      block:
        var i, j = rand(0 ..< v.len)
        if i > j: swap i, j
        let f = getQ0()
        st.apply(i .. j, f)
        for k in i .. j: v[k] = mapping0(f, v[k])
      block:
        var i, j = rand(0 ..< v.len)
        if i > j: swap i, j
  
        check st.prod(i .. j) == v[i .. j].foldl(op0(a, b))

test "SplayTree":
  var
    st = initSplayTree[P]()
    v: seq[P]
  for i in 0 ..< B: v.add getP()
  st.build(v)
  for _ in 0 ..< C:
    let t = rand(0 ..< 4)
    case t
    of 0:
      insert_test(st, v)
    of 1:
      erase_test(st, v)
    of 2:
      get_test(st, v)
    of 3:
      update_test(st, v)
    else:
      doAssert false

test "SplayTreeWithProd":
  var
    st = initSplayTree[P](op, e())
    v: seq[P]
  for i in 0 ..< B: v.add getP()
  st.build(v)
  for _ in 0 ..< C:
    let t = rand(0 ..< 5)
    case t
    of 0:
      insert_test(st, v)
    of 1:
      erase_test(st, v)
    of 2:
      get_test(st, v)
    of 3:
      update_test(st, v)
    of 4:
      range_test(st, v)
    else:
      doAssert false
test "ReversibleSplayTree":
  var
    st = initReversibleSplayTree[P](op, e())
    v: seq[P]
  for i in 0 ..< B: v.add getP()
  st.build(v)
  for _ in 0 ..< C:
    let t = rand(0 ..< 6)
    case t
    of 0:
      insert_test(st, v)
    of 1:
      erase_test(st, v)
    of 2:
      get_test(st, v)
    of 3:
      update_test(st, v)
    of 4:
      range_test(st, v)
    of 5:
      reverse_test(st, v)
    else:
      doAssert false

test "LazySplayTree":
  var
    st = initLazySplayTree[P, Q](op, mapping, composition, e(), id())
    v: seq[P]
  for i in 0 ..< B: v.add getP()
  st.build(v)
  for _ in 0 ..< C:
    let t = rand(0 ..< 6)
    case t
    of 0:
      insert_test(st, v)
    of 1:
      erase_test(st, v)
    of 2:
      get_test(st, v)
    of 3:
      update_test(st, v)
    of 4:
      range_test(st, v)
    of 5:
      apply_test(st, v)
    else:
      doAssert false

test "LazyReversibleSplayTree":
  var
    st = initLazyReversibleSplayTree[P, Q](op, mapping, composition, e(), id())
    v: seq[P]
  for i in 0 ..< B: v.add getP()
  st.build(v)
  for _ in 0 ..< C:
    let t = rand(0 ..< 7)
    case t
    of 0:
      insert_test(st, v)
    of 1:
      erase_test(st, v)
    of 2:
      get_test(st, v)
    of 3:
      update_test(st, v)
    of 4:
      range_test(st, v)
    of 5:
      reverse_test(st, v)
    of 6:
      apply_test(st, v)
    else:
      doAssert false


