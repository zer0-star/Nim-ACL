---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.8/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.8/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_SIMPLEX_HPP:\n  const ATCODER_SIMPLEX_HPP* = 1\n\
    \  type TwoStageSimplexResult* = enum\n    OPTIMAL, UNBOUNDED, NOSOLUTION, UNKNOWN\n\
    \  import std/sequtils, std/math\n  \n  proc twoStageSimplex*[T](A: seq[seq[T]],\
    \ b, c:seq[T]):tuple[status:TwoStageSimplexResult, v:T ,x:seq[T]] =\n    var EPS\
    \ = T.getEps()\n    #if sizeof(T) == 16:\n    #  EPS = T(1) / T(10^11)\n    #elif\
    \ sizeof(T) == 8:\n    #  EPS = T(1) / T(10^9)\n\n\n    var\n      (A, b, c) =\
    \ (A, b, c)\n      (N, M) = (A.len, A[0].len)\n      a = newSeqWith(N + 2, newSeqWith(M\
    \ + N + 1, T(0)))\n      s = newSeq[int](N + 2)\n\n    for i in 0 ..< N:\n   \
    \   let u = b[i] < -EPS\n      if u:\n        b[i] = -b[i]\n        for j in 0\
    \ ..< M:\n          A[i][j] = -A[i][j]\n    for j in 0 ..< M: a[N + 1][j] = c[j].clone()\n\
    \    for i in 0 ..< N:\n      for j in 0 ..< M:\n        a[i+1][j] = A[i][j].clone()\n\
    \    for i in 0 ..< N: a[i+1][M+N] = b[i].clone() # add helper table\n    for\
    \ i in 0 ..< N: a[ 0 ][i+M] = T(1)\n    for i in 0 ..< N: a[i+1][i+M] = T(1)\n\
    \    for i in 0 ..< N: s[i+1]      = i+M\n    for i in 1 .. N:\n      for j in\
    \ 0 .. N + M:\n        a[0][j] -= a[i][j]\n    proc print() =\n      echo \"s\
    \ = \", s\n      echo \"a = \"\n      for i in 0 ..< a.len:\n        echo a[i].join(\"\
    \\t\")\n\n    proc solve():TwoStageSimplexResult =\n      proc solve_sub():TwoStageSimplexResult\
    \ =\n        proc pivot(p, q:int) =\n          for j in 0 .. N:\n            for\
    \ k in countdown(M, 0):\n              if j != p and k != q:\n               \
    \ a[j][k] -= a[p][k] * a[j][q] / a[p][q]\n          for j in 0 .. N:\n       \
    \     if j != p: a[j][q] = T(0)\n          for k in 0 .. M:\n            if k\
    \ != q:\n              a[p][k] = a[p][k] / a[p][q]\n          a[p][q] = T(1)\n\
    \          s[p] = q\n\n        var p, q: int\n        while true:\n          q\
    \ = 0\n          while q < M and a[0][q] >= -EPS: q.inc\n          if q >= M:\
    \ break\n          p = 0\n          while p <= N and a[p][q] <= EPS: p.inc\n \
    \         if p > N:\n            break\n          for i in p + 1 ..< N: # bland's\
    \ care for cyclation\n            if a[i][q] > EPS:\n              let\n     \
    \           l = a[i][M] / a[i][q]\n                r = a[p][M] / a[p][q]\n   \
    \           if l + EPS < r or (l < r + EPS and s[i] < s[q]): p = i\n         \
    \ pivot(p, q)\n        if q >= M: return OPTIMAL\n        else:   return UNBOUNDED\n\
    \n      M += N\n      N += 1\n      discard solve_sub() # solve stage one\n  \
    \    if -a[0][M] > EPS: return NOSOLUTION\n      N -= 1; M -= N\n      swap a[0],\
    \ a[^1]\n      discard a.pop() # modify table\n      for i in 0 .. N:\n      \
    \  #swap a[i][M], a[i][^1]\n        block:\n          var tmp = a[i][M].clone()\n\
    \          a[i][M] = a[i][^1].clone()\n          a[i][^1] = tmp\n        a[i].setLen(M\
    \ + 1)\n  \n      return solve_sub() # solve stage two\n  \n    result.status\
    \ = solve()\n    if result.status == OPTIMAL:\n      var x: seq[T] \n      proc\
    \ solution():T =\n        x = newSeqWith(M, T(0))\n        for i in 0 ..< N:\n\
    \          if s[i + 1] in 0 ..< x.len:\n            x[s[i+1]] = a[i+1][^1]\n \
    \         else:\n            discard\n        return -a[0][M]\n      result.v\
    \ = solution()\n      result.x = x\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/math/simplex.nim
  requiredBy: []
  timestamp: '2022-10-23 18:37:31+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/math/simplex.nim
layout: document
redirect_from:
- /library/atcoder/extra/math/simplex.nim
- /library/atcoder/extra/math/simplex.nim.html
title: atcoder/extra/math/simplex.nim
---
