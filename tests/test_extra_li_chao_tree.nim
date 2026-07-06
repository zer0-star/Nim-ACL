
discard """
  cmd: "nim cpp -r $file"
"""

import atcoder/extra/structure/li_chao_tree

block:
  const INF = int.high div 4
  var cht = initLiChaoTree[int](@[0, 1, 2, 3, 4, 5], INF)

  cht.update(2, 3)    # 2x + 3
  cht.update(-1, 10)  # -x + 10
  cht.update(0, 7)    # 7

  for i in 0..5:
    let x = i
    let expected = min(min(2 * x + 3, -x + 10), 7)
    doAssert cht.query(i) == expected

block:
  const INF = int.high div 4
  var cht = initLiChaoTree[int](@[0, 1, 2, 3, 4, 5], INF)

  cht.update(0, 100)
  cht.update(0, 1, 2..4)

  doAssert cht.query(0) == 100
  doAssert cht.query(1) == 100
  doAssert cht.query(2) == 1
  doAssert cht.query(3) == 1
  doAssert cht.query(4) == 1
  doAssert cht.query(5) == 100
