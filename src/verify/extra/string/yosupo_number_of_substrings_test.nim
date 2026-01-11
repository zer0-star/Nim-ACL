# verify-helper: PROBLEM https://judge.yosupo.jp/problem/number_of_substrings

include atcoder/header
import atcoder/extra/string/suffix_automaton

proc main() =
  let s = nextString()
  var sa = initSuffixautomaton[char](s)
  var idx = sa.toposort()
  let n = sa.x.len
  var cnt = newSeq[int](n)
  var ans = -1
  cnt[0] = 1
  for i in idx:
    ans += cnt[i]
    for k,v in sa[i].to:
      cnt[v] += cnt[i]
  
  echo ans

main()
