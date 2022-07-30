import std/unittest
import atcoder/string as string_lib
import std/sequtils, std/algorithm
import std/math
include atcoder/extra/forward_compatibility/internal_sugar

proc `<`(a, b:seq[int]):bool =
  var i = 0
  while true:
    if i == b.len: return false
    elif i == a.len: return true
    elif a[i] != b[i]: return a[i] < b[i]
    i.inc

proc sa_naive(s:seq[int]):seq[int] =
  let n = s.len
  var sa = (0..<n).toSeq
  sa.sort() do (l, r:int) -> int:
    cmp[seq[int]](s[l..^1], s[r..^1])
  return sa

proc lcp_naive(s, sa:seq[int]):seq[int] =
  let n = s.len
  assert n > 0
  var lcp = newSeq[int](n - 1)
  for i in 0..<n-1:
    let
      l = sa[i]
      r = sa[i + 1]
    while l + lcp[i] < n and r + lcp[i] < n and s[l + lcp[i]] == s[r + lcp[i]]: lcp[i].inc
  return lcp

proc z_naive(s:seq[int]):seq[int] =
  let n = s.len
  var z = newSeq[int](n)
  for i in 0..<n:
    while i + z[i] < n and s[z[i]] == s[i + z[i]]: z[i].inc
  return z

test "StringTest, Empty":
  check newSeq[int]() == suffix_array("")
  check newSeq[int]() == suffix_array(newSeq[int]())

  check newSeq[int]() == z_algorithm("")
  check newSeq[int]() == z_algorithm(newSeq[int]())

test "StringTest, SALCPNaive":
  for n in 1..5:
    let m = 4^n
    for f in 0..<m:
      var
        s = newSeq[int](n)
        g = f
        max_c = 0
      for i in 0..<n:
        s[i] = g mod 4
        max_c = max(max_c, s[i])
        g = g div 4
      let sa = sa_naive(s)
      check sa == suffix_array(s)
      check sa == suffix_array(s, max_c)
      check lcp_naive(s, sa) == lcp_array(s, sa)

  for n in 1..10:
    let m = 2^n
    for f in 0..<m:
      var
        s = newSeq[int](n)
        g = f
        max_c = 0
      for i in 0..<n:
        s[i] = g mod 2
        max_c = max(max_c, s[i])
        g = g div 2
      let sa = sa_naive(s)
      check sa == suffix_array(s)
      check sa == suffix_array(s, max_c)
      check lcp_naive(s, sa) == lcp_array(s, sa)

test "StringTest, InternalSANaiveNaive":
  for n in 1..5:
    let m = 4^n
    for f in 0..<m:
      var
        s = newSeq[int](n)
        g = f
      for i in 0..<n: 
        s[i] = g mod 4
        g = g div 4

      let sa = string_lib.sa_naive(s)
      check sa_naive(s) == sa

  for n in 1..10:
    let m = 2^n
    for f in 0..<m:
      var s = newSeq[int](n)
      var g = f
      for i in 0..<n:
        s[i] = g mod 2
        g = g div 2

      let sa = string_lib.sa_naive(s)
      check sa_naive(s) == sa

test "StringTest, InternalSADoublingNaive":
  for n in 1..5:
    let m = 4^n
    for f in 0..<m:
      var
        s = newSeq[int](n)
        g = f
      for i in 0..<n: 
        s[i] = g mod 4
        g = g div 4

      let sa = string_lib.sa_doubling(s)
      check sa_naive(s) == sa

  for n in 1..10:
    let m = 2^n
    for f in 0..<m:
      var s = newSeq[int](n)
      var g = f
      for i in 0..<n:
        s[i] = g mod 2
        g = g div 2

      let sa = string_lib.sa_doubling(s)
      check sa_naive(s) == sa

test "StringTest, InternalSAISNaive":
  for n in 1..5:
    let m = 4^n
    for f in 0..<m:
      var
        s = newSeq[int](n)
        g = f
      for i in 0..<n: 
        s[i] = g mod 4
        g = g div 4

      let sa = string_lib.sa_is(s, s.max, -1, -1)
      check sa_naive(s) == sa

  for n in 1..10:
    let m = 2^n
    for f in 0..<m:
      var s = newSeq[int](n)
      var g = f
      for i in 0..<n:
        s[i] = g mod 2
        g = g div 2

      let sa = string_lib.sa_is(s, s.max, -1, -1)
      check sa_naive(s) == sa

test "StringTest, SAAllATest":
  for n in 1..100:
    let s = newSeq[int](10)
    check sa_naive(s) == suffix_array(s)
    check sa_naive(s) == suffix_array(s, 10)
    check sa_naive(s) == suffix_array(s, 12)

test "StringTest, SAAllABTest":
  for n in 1..100:
#    var s = lc[i mod 2 | (i <- 0..<n), int]
    let s = collect(newSeq):
      for i in 0..<n:
        i mod 2
    check sa_naive(s) == suffix_array(s)
    check sa_naive(s) == suffix_array(s, 3)
  for n in 1..100:
#    var s = lc[1 - i mod 2 | (i <- 0..<n), int]
    let s = collect(newSeq):
      for i in 0..<n:
        1 - i mod 2
    check sa_naive(s) == suffix_array(s)
    check sa_naive(s) == suffix_array(s, 3)

test "StringTest, SA":
  let s = "missisippi"

  let sa = suffix_array(s)

  let answer = [
    "i",       # 9
    "ippi",    # 6
    "isippi",    # 4
    "issisippi",   # 1
    "missisippi",  # 0
    "pi",      # 8
    "ppi",     # 7
    "sippi",     # 5
    "sisippi",   # 3
    "ssisippi",  # 2
  ]

  check answer.len == sa.len

  for i in 0..<sa.len:
    check answer[i] == s.substr(sa[i])

test "StringTest, SASingle":
  check @[0] == suffix_array(@[0])
  check @[0] == suffix_array(@[-1])
  check @[0] == suffix_array(@[1]);
  check @[0] == suffix_array(@[int.low])
  check @[0] == suffix_array(@[int.high])

test "StringTest, LCP":
  let s = "aab"
  let sa = suffix_array(s)
  check @[0, 1, 2] == sa
  let lcp = lcp_array(s, sa)
  check @[1, 0] == lcp

  check lcp == lcp_array(@[0'i32, 0'i32, 1'i32], sa)
  check lcp == lcp_array(@[-100'i32, -100'i32, 100'i32], sa)
  check lcp == lcp_array(@[int32.low, int32.low, int32.high], sa)

  check lcp == lcp_array(@[int64.low, int64.low, int64.high], sa)

  check lcp == lcp_array(@[uint32.low, uint32.low, uint32.high], sa)
  check lcp == lcp_array(@[uint64.low, uint64.low, uint64.high], sa)

test "StringTest, ZAlgo":
  let
    s = "abab"
    z = z_algorithm(s)
  check @[4, 0, 2, 0] == z
  check @[4, 0, 2, 0] == z_algorithm(@[1, 10, 1, 10])
  check z_naive(@[0, 0, 0, 0, 0, 0, 0]) == z_algorithm(@[0, 0, 0, 0, 0, 0, 0])

test "StringTest, ZNaive":
  for n in 1..6:
    let m = 4^n
    for f in 0..<m:
      var s = newSeq[int](n)
      var g = f
      for i in 0..<n:
        s[i] = g mod 4
        g = g div 4
      check z_naive(s) == z_algorithm(s)
  for n in 1..10:
    let m = 2^n
    for f in 0..<m:
      var s = newSeq[int](n)
      var g = f
      for i in 0..<n:
        s[i] = g mod 2
        g = g div 2
      check z_naive(s) == z_algorithm(s)
