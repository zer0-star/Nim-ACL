# verify-helper: PROBLEM https://judge.yosupo.jp/problem/zalgorithm

include atcoder/header
import atcoder/string

import std/strutils

let S = nextString()
echo S.z_algorithm().join(" ")
