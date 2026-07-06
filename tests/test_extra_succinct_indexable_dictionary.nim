
discard """
  cmd: "nim cpp -r $file"
"""

import atcoder/extra/structure/succinct_indexable_dictionary

block:
  var sid = initSuccinctIndexableDictionary(70)

  for k in [0, 1, 31, 32, 69]:
    sid.set(k)

  sid.build()

  doAssert sid[0]
  doAssert sid[1]
  doAssert not sid[2]
  doAssert sid[31]
  doAssert sid[32]
  doAssert not sid[33]
  doAssert sid[69]

  doAssert sid.rank(0) == 0
  doAssert sid.rank(1) == 1
  doAssert sid.rank(2) == 2
  doAssert sid.rank(31) == 2
  doAssert sid.rank(32) == 3
  doAssert sid.rank(33) == 4
  doAssert sid.rank(70) == 5

  doAssert sid.rank(true, 70) == 5
  doAssert sid.rank(false, 70) == 65

block:
  var sid = initSuccinctIndexableDictionary(32)

  sid.set(31)
  sid.build()

  doAssert sid.rank(32) == 1
  doAssert sid.rank(false, 32) == 31
