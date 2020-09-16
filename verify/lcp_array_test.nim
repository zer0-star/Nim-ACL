# verify-helper: PROBLEM https://judge.yosupo.jp/problem/number_of_substrings

include src/nim_acl/header
import src/nim_acl/string

let
  S = nextString()
  sa = S.suffixarray()
  lcp = S.lcp_array(sa)
  n = S.len

var ans = n * (n + 1) div 2
for v in lcp: ans -= v
echo ans
