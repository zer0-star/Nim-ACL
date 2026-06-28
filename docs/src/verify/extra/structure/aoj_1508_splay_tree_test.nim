# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=1508

include atcoder/header

import atcoder/extra/structure/splay_tree
import sugar

block:
  let n, q = nextInt()

  var st = initSplayTree((a:int, b:int)=>min(a, b), 0)
  type Node = st.Node

  st.build(newSeqWith(n, nextInt()))

  for i in 0..<q:
    let x, y, z = nextInt()
#    echo st.count(root)
    case x:
      of 0:
        var (p, q, r) = st.split_index3(st.root, y, z + 1)
        let d = z + 1 - y
        var (q0, q1) = st.split_index(q, d - 1)
#        doAssert st.count(q) == d
        st.root = st.merge(p, q1, q0, r)
      of 1:
        echo st.prod(y..z)
      else:
        # type 1
#        st.set_element(root, y, z)
        st[y] = z
        # type 2
#        var (p, q, r) = st.split3(root, y, y + 1)
#        root = st.merge(p, st.initNode(z), r)
        # type 3
#        st.erase(st.get_node(y))
#        st.insert(y, z)
