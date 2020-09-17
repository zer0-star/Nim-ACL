# verify-helper: PROBLEM https://yukicoder.me/problems/no/741

include atcoder/modint

import std/strutils, std/sequtils, std/math

let
  N = stdin.readLine.parseInt.initModInt()

echo (0 ..< 9).mapIt(N + 9 - it).prod / toSeq(1 .. 9).prod
