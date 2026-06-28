# verify-helper: PROBLEM https://judge.yosupo.jp/problem/range_chmin_chmax_add_range_sum

import atcoder/header, std/sequtils
import atcoder/extra/structure/range_chmin_chmax_add_range_sum

let
  N, Q = nextInt()
  a = newSeqWith(N, nextInt())
var st = initRangeChminChmaxAddRangeSum[int](a)

for i in 0 ..< Q:
  let t, l, r = nextInt()
  if t == 0:
    let b = nextInt()
    st.chmin(l ..< r, b)
  elif t == 1:
    let b = nextInt()
    st.chmax(l ..< r, b)
  elif t == 2:
    let b = nextInt()
    st.add(l ..< r, b)
  elif t == 3:
    echo st[l ..< r]
  else:
    doAssert false



  #[ Usage:
  using RCCARS = RangeChminChmaxAddRangeSum<long long, (1LL << 60)>;
  
  vector<RCCARS::S> init;
  for (long long a : A) init.push_back(RCCARS::Gen(a));
  
  RCCARS::segtree segtree(init);
  
  segtree.apply(l, r, RCCARS::Chmin(b));
  segtree.apply(l, r, RCCARS::Chmax(b));
  segtree.apply(l, r, RCCARS::Add(b));
  
  long long ret = segtree.prod(l, r).sum;
  ]#
