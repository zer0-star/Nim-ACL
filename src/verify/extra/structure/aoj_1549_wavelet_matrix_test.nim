# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=1549

include atcoder/header

import atcoder/extra/structure/wavelet_matrix

let n = nextInt()
const OFS = 10^6
var a = newSeqWith(n, nextInt() + OFS)
var wm = initCompressedWaveletMatrix(a, 17)

let q = nextInt()
for i in 0..<q:
  let
    l = nextInt()
    r = nextInt() + 1
    d = nextInt() + OFS
  var ans = OFS * 2
  if wm.rank(d, l) < wm.rank(d, r):
    ans = 0
  else:
    let succ = wm.next_value(l ..< r, d)
    if succ != -1: ans.min= abs(succ - d)
    let pred = wm.prev_value(l ..< r, d)
    if pred != -1: ans.min= abs(pred - d)
  echo ans
