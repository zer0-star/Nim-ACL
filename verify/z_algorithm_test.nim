# verify-helper: PROBLEM https://judge.yosupo.jp/problem/zalgorithm

include src/nim_acl/header
include src/nim_acl/string

import std/strutils

let S = nextString()
echo S.z_algorithm().join(" ")
