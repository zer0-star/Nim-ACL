# verify-helper: PROBLEM https://judge.yosupo.jp/problem/suffixarray

import src/nim_acl/header
import src/nim_acl/string

import std/strutils

let S = nextString()
echo S.suffixarray().join(" ")
