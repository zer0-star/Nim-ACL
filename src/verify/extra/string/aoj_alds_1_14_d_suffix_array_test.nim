# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=ALDS1_14_D

include "template/template.nim"
include "string/suffix_array.nim"

proc main() =
  let
    S = nextString()
    Q = nextInt()

  var sa = initSuffixArray(S);
  for i in 0..<Q:
    let T = nextString()
    let range = sa.lowerUpperBound(T)
    echo if range[0] != range[1]: 1 else: 0

main()
