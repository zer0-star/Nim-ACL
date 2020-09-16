# verify-helper: PROBLEM https://judge.yosupo.jp/problem/suffixarray

import src/nim_acl/header
import src/nim_acl/string

import sequtils, strutils, sugar

let S = nextString()
echo S.suffixarray().join(" ")
