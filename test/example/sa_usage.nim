import atcoder/string

let s = "missisippi"
let sa = suffix_array(s)

let answer = [
  "i",
  "ippi",
  "isippi",
  "issisippi",
  "missisippi",
  "pi",
  "ppi",
  "sippi",
  "sisippi",
  "ssisippi",
]

assert sa.len == answer.len
for i in 0..<sa.len:
  assert s[sa[i]..^1] == answer[i]
