---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: atcoder/extra/math/characteristic_polynomial.nim
    title: atcoder/extra/math/characteristic_polynomial.nim
  - icon: ':warning:'
    path: atcoder/extra/math/characteristic_polynomial.nim
    title: atcoder/extra/math/characteristic_polynomial.nim
  - icon: ':warning:'
    path: atcoder/extra/math/characteristic_polynomial.nim
    title: atcoder/extra/math/characteristic_polynomial.nim
  - icon: ':warning:'
    path: atcoder/extra/math/characteristic_polynomial.nim
    title: atcoder/extra/math/characteristic_polynomial.nim
  - icon: ':warning:'
    path: atcoder/extra/math/kitamasa.nim
    title: atcoder/extra/math/kitamasa.nim
  - icon: ':warning:'
    path: atcoder/extra/math/kitamasa.nim
    title: atcoder/extra/math/kitamasa.nim
  - icon: ':warning:'
    path: atcoder/extra/math/kitamasa.nim
    title: atcoder/extra/math/kitamasa.nim
  - icon: ':warning:'
    path: atcoder/extra/math/kitamasa.nim
    title: atcoder/extra/math/kitamasa.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/math/matrix.nim
    title: atcoder/extra/math/matrix.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/math/matrix.nim
    title: atcoder/extra/math/matrix.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/math/matrix.nim
    title: atcoder/extra/math/matrix.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/math/matrix.nim
    title: atcoder/extra/math/matrix.nim
  - icon: ':warning:'
    path: atcoder/extra/math/simplex_old.nim
    title: atcoder/extra/math/simplex_old.nim
  - icon: ':warning:'
    path: atcoder/extra/math/simplex_old.nim
    title: atcoder/extra/math/simplex_old.nim
  - icon: ':warning:'
    path: atcoder/extra/math/simplex_old.nim
    title: atcoder/extra/math/simplex_old.nim
  - icon: ':warning:'
    path: atcoder/extra/math/simplex_old.nim
    title: atcoder/extra/math/simplex_old.nim
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/extra/math/yosupo_system_of_linear_equations_test.nim
    title: verify/extra/math/yosupo_system_of_linear_equations_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/math/yosupo_system_of_linear_equations_test.nim
    title: verify/extra/math/yosupo_system_of_linear_equations_test.nim
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.8/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.8/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_OPERATOR_HPP:\n  const ATCODER_OPERATOR_HPP* =\
    \ 1\n  import macros, tables\n\n  macro getOperator*(head:typedesc, body: untyped):untyped\
    \ =\n    result = newStmtList()\n    var\n      T = head\n      t = initTable[string,\
    \ NimNode]()\n      s = newStmtList()\n      nameStrs = [\"zero\", \"unit\", \"\
    add\", \"subt\", \"mult\", \"divide\", \"isZero\"]\n    for s in nameStrs:\n \
    \     t[s] = quote do:\n        0\n    var\n      hasZero, hasUnit, hasAdd, hasSubt,\
    \ hasMult, hasDiv, hasIsZero = 0\n    proc getnameStr(name:NimNode):string =\n\
    \      var nameStr = $name\n      case nameStr:\n        of \"zero\":\n      \
    \    hasZero = 1\n          return \"zero\"\n        of \"unit\":\n          hasUnit\
    \ = 1\n          return \"unit\"\n        of \"add\", \"+\", \"plus\":\n     \
    \     hasAdd = 1\n          return \"add\"\n        of \"subt\", \"-\", \"minus\"\
    :\n          hasSubt = 1\n          return \"subt\"\n        of \"mult\", \"*\"\
    , \"multiply\", \"product\":\n          hasMult = 1\n          return \"mult\"\
    \n        of \"div\", \"divide\", \"/\":\n          hasDiv = 1\n          return\
    \ \"divide\"\n        of \"isZero\", \"iszero\":\n          hasIsZero = 1\n  \
    \        return \"isZero\"\n        else:\n          doAssert false, \"Undefined\
    \ Operator\"\n\n    for l in body:\n      var\n        name, body, params:NimNode\n\
    \      params = newNimNode(nnkFormalParams).add T\n      if l.kind == nnkAsgn:\n\
    \        name = l[0][0]\n        body = l[1]\n        for i, l in l[0]:\n    \
    \      if i == 0: continue # name\n          if l.kind == nnkExprColonExpr:\n\
    \            params.add newIdentDefs(l[0], T)\n          else:\n            params.add\
    \ newIdentDefs(l, T)\n      else:\n        for i,l in l[3]:\n          if i ==\
    \ 0:\n            continue\n          else:\n            params.add l\n      \
    \  name = l[0]\n        body = l[6]\n      var nameStr = getnameStr(name)\n  \
    \    if nameStr == \"isZero\":\n        params[0] = ident(\"bool\")\n      name\
    \ = ident(nameStr)\n      var p = newNimNode(nnkLambda).add(\n        newEmptyNode(),\n\
    \        newEmptyNode(), \n        newEmptyNode(), \n        params, \n      \
    \  newEmptyNode(), \n        newEmptyNode(), \n        body)\n      t[nameStr]\
    \ = p\n    var\n      zeroOp = t[\"zero\"]\n      unitOp = t[\"unit\"]\n     \
    \ addOp = t[\"add\"]\n      subtOp = t[\"subt\"]\n      multOp = t[\"mult\"]\n\
    \      divOp = t[\"divide\"]\n      isZeroOp = t[\"isZero\"]\n    s.add quote\
    \ do:\n      (hasZero: `hasZero`, zeroOp: `zeroOp`, \n      hasUnit: `hasUnit`,\
    \ unitOp: `unitOp`, \n      hasAdd: `hasAdd`, addOp: `addOp`, \n      hasSubt:\
    \ `hasSubt`, subtOp:`subtOp`, \n      hasMult: `hasMult`, multOp:`multOp`, \n\
    \      hasDiv: `hasDiv`, divOp:`divOp`, \n      hasIsZero: `hasIsZero`, isZeroOp:`isZeroOp`)\n\
    \    result.add newBlockStmt(s)\n    return\n  \n  type OperatorType*[hZ, Z, hU,\
    \ U, hA, A, hS, S, hM, M, hD, D, hIZ, IZ] = tuple[\n    hasZero: hZ, zeroOp: Z,\
    \ \n    hasUnit: hU, unitOp: U, \n    hasAdd: hA, addOp: A, \n    hasSubt: hS,\
    \ subtOp: S, \n    hasMult: hM, multOp: M, \n    hasDiv: hD, divOp: D, \n    hasIsZero:\
    \ hIZ, isZeroOp:IZ\n  ]\n  \n  template zero*(p: OperatorType):auto =\n    static:\n\
    \      doAssert p[0] == 1, \"no zero function\"\n    p[1]()\n  template unit*(p:\
    \ OperatorType):auto =\n    static:\n      doAssert p[2] == 1, \"no unit function\"\
    \n    p[3]()\n  template add*[T](p: OperatorType, a, b:T):T =\n    static:\n \
    \     doAssert p[4] == 1, \"no add function\"\n    p[5](a, b)\n  template subt*[T](p:\
    \ OperatorType, a, b:T):T =\n    static:\n      doAssert p[6] == 1, \"no subt\
    \ function\"\n    p[7](a, b)\n  template mult*[T](p: OperatorType, a, b:T):T =\n\
    \    static:\n      doAssert p[8] == 1, \"no mult function\"\n    p[9](a, b)\n\
    \  template `div`*[T](p: OperatorType, a, b:T):T =\n    static:\n      doAssert\
    \ p[10] == 1, \"no div function\"\n    p[11](a, b)\n  template isZero*[T](p: OperatorType,\
    \ a:T):bool =\n    static:\n      doAssert p[12] == 1, \"no isZero function\"\n\
    \    p[13](a)\n\n\n  template getDefaultOperator*(T:typedesc):tuple =\n    getOperator(T):\n\
    \      proc zero() = T(0)\n      proc unit() = T(1)\n      proc add(a, b:T):T\
    \ = a + b\n      proc subt(a, b:T):T = a - b\n      proc mult(a, b:T):T = a *\
    \ b\n      proc divide(a, b:T):T = T(a / b)\n      proc isZero(a:T):bool =\n \
    \       when T is SomeFloat:\n          a < 0.0000001\n        else:\n       \
    \   a == T(0)\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/other/operator.nim
  requiredBy:
  - atcoder/extra/math/characteristic_polynomial.nim
  - atcoder/extra/math/characteristic_polynomial.nim
  - atcoder/extra/math/simplex_old.nim
  - atcoder/extra/math/simplex_old.nim
  - atcoder/extra/math/kitamasa.nim
  - atcoder/extra/math/kitamasa.nim
  - atcoder/extra/math/matrix.nim
  - atcoder/extra/math/matrix.nim
  - atcoder/extra/math/characteristic_polynomial.nim
  - atcoder/extra/math/characteristic_polynomial.nim
  - atcoder/extra/math/simplex_old.nim
  - atcoder/extra/math/simplex_old.nim
  - atcoder/extra/math/kitamasa.nim
  - atcoder/extra/math/kitamasa.nim
  - atcoder/extra/math/matrix.nim
  - atcoder/extra/math/matrix.nim
  timestamp: '2022-07-30 23:50:20+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/extra/math/yosupo_system_of_linear_equations_test.nim
  - verify/extra/math/yosupo_system_of_linear_equations_test.nim
documentation_of: atcoder/extra/other/operator.nim
layout: document
redirect_from:
- /library/atcoder/extra/other/operator.nim
- /library/atcoder/extra/other/operator.nim.html
title: atcoder/extra/other/operator.nim
---
