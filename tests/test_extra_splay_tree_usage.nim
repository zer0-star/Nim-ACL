discard """
  cmd: "nim cpp -r $file"
"""

import std/unittest
import atcoder/extra/structure/splay_tree

test "SplayTree sequence operations":
  var st = initSplayTree[int]()

  st.build(@[1, 2, 3])
  check st.toSeq == @[1, 2, 3]

  check st[1] == 2

  st[1] = 20
  check st.toSeq == @[1, 20, 3]

  st.insert_index(1, 10)
  check st.toSeq == @[1, 10, 20, 3]

  st.erase_index(2)
  check st.toSeq == @[1, 10, 3]

  st.check_tree()
