include atcoder/header
import atcoder/string

let
  s = nextString()
  sa = suffix_array(s)
var answer = s.len * (s.len + 1) div 2
for x in lcp_array(s, sa):
  answer -= x
echo answer
