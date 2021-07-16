---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':x:'
    path: atcoder/extra/header/chaemon_header.nim
    title: atcoder/extra/header/chaemon_header.nim
  - icon: ':x:'
    path: atcoder/extra/header/chaemon_header.nim
    title: atcoder/extra/header/chaemon_header.nim
  _extendedVerifiedWith:
  - icon: ':x:'
    path: verify/extra/structure/yosupo_dynamic_tree_vertex_set_path_composite_link_cut_tree_test.nim
    title: verify/extra/structure/yosupo_dynamic_tree_vertex_set_path_composite_link_cut_tree_test.nim
  - icon: ':x:'
    path: verify/extra/structure/yosupo_dynamic_tree_vertex_set_path_composite_link_cut_tree_test.nim
    title: verify/extra/structure/yosupo_dynamic_tree_vertex_set_path_composite_link_cut_tree_test.nim
  - icon: ':x:'
    path: verify/extra/structure/yosupo_point_set_range_composite_reversible_splay_tree_test.nim
    title: verify/extra/structure/yosupo_point_set_range_composite_reversible_splay_tree_test.nim
  - icon: ':x:'
    path: verify/extra/structure/yosupo_point_set_range_composite_reversible_splay_tree_test.nim
    title: verify/extra/structure/yosupo_point_set_range_composite_reversible_splay_tree_test.nim
  _isVerificationFailed: true
  _pathExtension: nim
  _verificationStatusIcon: ':x:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_READER_HPP:\n  const ATCODER_READER_HPP* = 1\n\
    \  import streams, strutils, sequtils\n#  proc scanf*(formatstr: cstring){.header:\
    \ \"<stdio.h>\", varargs.}\n  #proc getchar(): char {.header: \"<stdio.h>\", varargs.}\n\
    #  proc nextInt*(): int = scanf(\"%lld\",addr result)\n#  proc nextFloat*(): float\
    \ = scanf(\"%lf\",addr result)\n  proc nextString*(f:auto = stdin): string =\n\
    \    var get = false\n    result = \"\"\n    while true:\n      let c = f.readChar\n\
    \      if c.int > ' '.int:\n        get = true\n        result.add(c)\n      elif\
    \ get: return\n  proc nextInt*(f:auto = stdin): int = parseInt(f.nextString)\n\
    \  proc nextFloat*(f:auto = stdin): float = parseFloat(f.nextString)\n#  proc\
    \ nextString*():string = stdin.nextString()\n\n  proc toStr*[T](v:T):string =\n\
    \    proc `$`[T](v:seq[T]):string =\n      v.mapIt($it).join(\" \")\n    return\
    \ $v\n  \n  proc print0*(x: varargs[string, toStr]; sep:string):string{.discardable.}\
    \ =\n    result = \"\"\n    for i,v in x:\n      if i != 0: addSep(result, sep\
    \ = sep)\n      add(result, v)\n    result.add(\"\\n\")\n    stdout.write result\n\
    \  \n  var print*:proc(x: varargs[string, toStr])\n  print = proc(x: varargs[string,\
    \ toStr]) =\n    discard print0(@x, sep = \" \")\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/other/reader.nim
  requiredBy:
  - atcoder/extra/header/chaemon_header.nim
  - atcoder/extra/header/chaemon_header.nim
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_ALL_WA
  verifiedWith:
  - verify/extra/structure/yosupo_dynamic_tree_vertex_set_path_composite_link_cut_tree_test.nim
  - verify/extra/structure/yosupo_dynamic_tree_vertex_set_path_composite_link_cut_tree_test.nim
  - verify/extra/structure/yosupo_point_set_range_composite_reversible_splay_tree_test.nim
  - verify/extra/structure/yosupo_point_set_range_composite_reversible_splay_tree_test.nim
documentation_of: atcoder/extra/other/reader.nim
layout: document
redirect_from:
- /library/atcoder/extra/other/reader.nim
- /library/atcoder/extra/other/reader.nim.html
title: atcoder/extra/other/reader.nim
---
