discard """
  cmd: "nim cpp -r $file"
"""

import std/unittest
import atcoder/extra/structure/mex_set

test "MexSet basic":
  var s = initMexSet(5)

  check s.empty
  check s.mex == 0

  check s.insert(0)
  check s.mex == 1

  check not s.insert(0)
  check s.count(0) == 2
  check s.mex == 1

  check s.insert(1)
  check s.insert(2)
  check s.mex == 3

  check s.erase(0)
  check s.count(0) == 1
  check s.mex == 3

  check s.erase(0)
  check s.count(0) == 0
  check s.mex == 0

test "MexSet reaches sentinel":
  var s = initMexSet(5)

  for x in 0 .. 5:
    s.incl(x)

  check s.mex == 6
  check s.len == 6

  s.excl(3)

  check s.mex == 3

test "MexSet ignores irrelevant values":
  var s = initMexSet(3)

  check not s.insert(-1)
  check not s.insert(100)
  check not s.erase(-1)
  check not s.erase(100)

  check s.mex == 0
  check s.len == 0

test "MexSet constructor and clear":
  var s = initMexSet(6, @[0, 1, 1, 3, 4])

  check s.mex == 2
  check s.count(1) == 2
  check 3 in s
  check 2 notin s

  s.clear()

  check s.empty
  check s.mex == 0
  check s.count(1) == 0
