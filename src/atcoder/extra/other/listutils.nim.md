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
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_LIST_UTILS_HPP:\n  const ATCODER_LIST_UTILS_HPP*\
    \ = 1\n  import lists\n\n  proc split*[T](f:var DoublyLinkedList[T], nd:DoublyLinkedNode[T]):DoublyLinkedList[T]\
    \ =\n    result = initDoublyLinkedList[T]()\n    result.tail = f.tail\n    result.head\
    \ = nd\n    f.tail = nd.prev\n    if f.head == nd:\n      f.head = nil\n     \
    \ f.tail = nil\n    if nd.prev != nil:\n      nd.prev.next = nil\n    nd.prev\
    \ = nil\n\n  proc merge*[T](f, t:var DoublyLinkedList[T]) =\n    if f.tail ==\
    \ nil:\n      doAssert(f.head == nil)\n      f.head = t.head\n      f.tail = t.tail\n\
    \    else:\n      f.tail.next = t.head\n      t.head.prev = f.tail\n      f.tail\
    \ = t.tail\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/other/listutils.nim
  requiredBy: []
  timestamp: '2021-03-01 01:28:35+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/other/listutils.nim
layout: document
redirect_from:
- /library/atcoder/extra/other/listutils.nim
- /library/atcoder/extra/other/listutils.nim.html
title: atcoder/extra/other/listutils.nim
---
