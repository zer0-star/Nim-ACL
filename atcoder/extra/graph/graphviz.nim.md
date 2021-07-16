---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/extra/graph/graph_template.nim
    title: atcoder/extra/graph/graph_template.nim
  - icon: ':question:'
    path: atcoder/extra/graph/graph_template.nim
    title: atcoder/extra/graph/graph_template.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "import atcoder/extra/graph/graph_template\nimport std/os\n\n#dot -Tpng graph.dot\
    \ -o graph.png\ntemplate graphviz*[G:Graph](g:G, fname = \"graph.pdf\", base =\
    \ 0) =\n  when declared DEBUG:\n    when DEBUG:\n      var weighted=false;#,directed=true;\n\
    \      for u in 0..<g.len:\n        for i in 0..<g[u].len:\n          if g[u][i].weight\
    \ != 1: weighted = true\n      var f = open(\"graph.dot\", fmWrite)\n      f.writeLine(\"\
    digraph G{\")\n      f.writeLine(\"\\tnode [style=rounded];\")\n      for u in\
    \ 0..<g.len:\n        f.writeLine(\"\\t\" & $u & \"[label=\" & $(u + base) & \"\
    ];\")\n      for u in 0..<g.len:\n        for e in g[u]:\n          if e.rev !=\
    \ -1 and u > e.dst:continue # loop?\n          f.write(\"\\t\" & $u & \"->\" &\
    \ $e.dst)\n          f.write(\"[\")\n          if e.rev != -1:f.write(\"arrowhead=none,\"\
    )\n          else: f.write(\"arrowhead=normal,\")\n          if weighted:f.write(\"\
    label=\" & $e.weight & \",\")\n          f.writeLine(\"];\")\n      f.writeLine(\"\
    }\")\n      f.close()\n      var command = \"dot -Tpdf -Gsize=10,10\\\\! -Gdpi=100\
    \ graph.dot -o \"\n    #  sprintf(command,\"dot -Tpng graph.dot -o graph%d.png\"\
    ,ct);\n      command &= fname;\n      discard execShellCmd(command)\n      discard\
    \ execShellCmd(\"evince \" & fname)\n"
  dependsOn:
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/graph/graph_template.nim
  isVerificationFile: false
  path: atcoder/extra/graph/graphviz.nim
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/graph/graphviz.nim
layout: document
redirect_from:
- /library/atcoder/extra/graph/graphviz.nim
- /library/atcoder/extra/graph/graphviz.nim.html
title: atcoder/extra/graph/graphviz.nim
---
