# verification-helper: PROBLEM https://judge.yosupo.jp/problem/number_of_substrings

include atcoder/header

import atcoder/extra/string/suffix_automaton

proc main() =
  let text = nextString()
  let automaton = initSuffixAutomaton(text)

  echo automaton.distinctSubstringCount()

main()
