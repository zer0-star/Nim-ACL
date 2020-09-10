# verify-helper: PROBLEM https://yukicoder.me/problems/no/741

include src/nim_acl/modint

import strutils, sequtils, math

let
  N = stdin.readLine.parseInt.initModInt()

echo (0 ..< 9).mapIt(N + 9 - it).prod / toSeq(1 .. 9).prod
