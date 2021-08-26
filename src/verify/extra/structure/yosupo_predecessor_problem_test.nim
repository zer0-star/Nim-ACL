# verify-helper: PROBLEM https://judge.yosupo.jp/problem/predecessor_problem

include atcoder/header
import atcoder/extra/structure/set_map

var st = initSortedSet(int)

let N, Q = nextInt()
let T = nextString()
for i in 0..<N:
  if T[i] == '1': st.insert(i)
for _ in 0..<Q:
  let c, k = nextInt()
  if c == 0:
    st.insert(k)
  elif c == 1:
    st.erase(k)
  elif c == 2:
    if k in st:
      echo 1
    else:
      echo 0
  elif c == 3:
    var it = st.lower_bound(k)
    if it == st.end():
      echo -1
    else:
      echo *it
  elif c == 4:
    var it = st.upper_bound(k)
    if it == st.begin():
      echo -1
    else:
      it.dec
      echo *it
