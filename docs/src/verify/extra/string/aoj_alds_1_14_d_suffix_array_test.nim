# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=ALDS1_14_D

include atcoder/header
#import atcoder/string
import atcoder/extra/string/suffix_array_utils

proc main() =
  let
    S = nextString()
    Q = nextInt()

  var sa = S.initSuffixArray
  for i in 0..<Q:
    let T = nextString()
    let range = sa.lowerUpperBound(T)
    echo if range[0] != range[1]: 1 else: 0

main()
