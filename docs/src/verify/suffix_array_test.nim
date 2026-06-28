# verify-helper: PROBLEM https://judge.yosupo.jp/problem/suffixarray

import atcoder/header
import atcoder/string

import std/strutils

let S = nextString()
echo S.suffixarray().join(" ")
