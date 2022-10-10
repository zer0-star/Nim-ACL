---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/extra/graph/graph_template.nim
    title: atcoder/extra/graph/graph_template.nim
  - icon: ':question:'
    path: atcoder/extra/graph/graph_template.nim
    title: atcoder/extra/graph/graph_template.nim
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
    links:
    - https://cdnjs.cloudflare.com/ajax/libs/vis/4.21.0/vis.min.css
    - https://cdnjs.cloudflare.com/ajax/libs/vis/4.21.0/vis.min.js
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.7/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.7/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_GRAPH_VISUALIZE_HPP:\n  const ATCODER_GRAPH_VISUALIZE_HPP*\
    \ = 1\n  import atcoder/extra/graph/graph_template\n  import std/strformat, std/os\n\
    \n  proc is_weighted*(g:Graph):bool =\n    static:\n      assert g.adjType is\
    \ ADJTYPE_SEQ\n    for u in 0 ..< g.len:\n      for e in g[u]:\n        if e.weight\
    \ != 1: return true\n    return false\n\n  proc is_directed*(g:Graph):bool =\n\
    \    static:\n      assert g.adjType is ADJTYPE_SEQ\n    for u in 0 ..< g.len:\n\
    \      for e in g[u]:\n        if e.rev == -1: return true\n    return false\n\
    \n  proc visualize*(g:Graph) =\n    var f: File = open(\"graph.html\", FileMode.fmWrite)\n\
    \    var\n      nodes_array:seq[string] = @[]\n      edges_array:seq[string] =\
    \ @[]\n    let is_directed = g.is_directed\n    let is_weighted = g.is_weighted\n\
    \    var found = initSet[(int, int)]()\n    for u in 0 ..< g.len:\n      nodes_array.add(fmt\"\
    {{id: {u}, label: '{u}'}}\")\n      for i, e in g[u]:\n        if not is_directed:\n\
    \          if (u, i) in found: continue\n          found.incl((e.dst, e.rev))\n\
    \        var s = fmt\"from: {u}, to: {e.dst}\"\n        if is_weighted:\n    \
    \      s &= fmt\", label: '{e.weight}'\"\n        if is_directed:\n          s\
    \ &= \", arrows: 'to'\"\n        edges_array.add(fmt\"{{ {s} }}\")\n    let\n\
    \      nodes_info = nodes_array.join(\",\")\n      edges_info = edges_array.join(\"\
    ,\")\n    var s = fmt\"\"\"\n<html>\n  <head>\n    <link href=\"https://cdnjs.cloudflare.com/ajax/libs/vis/4.21.0/vis.min.css\"\
    \ rel=\"stylesheet\">\n    <style type=\"text/css\">\n      #network {{\n    \
    \    width:  800px;\n        height: 800px;\n        border: 1px solid #000;\n\
    \      }}\n    </style>\n    <script type=\"text/javascript\" src=\"https://cdnjs.cloudflare.com/ajax/libs/vis/4.21.0/vis.min.js\"\
    ></script>\n  </head>\n  <body>\n    <div id=\"network\"></div>\n    <script type=\"\
    text/javascript\">\n      var nodes = new vis.DataSet([{nodes_info}]);\n     \
    \ var edges = new vis.DataSet([{edges_info}]);\n      var container = document.getElementById('network');\n\
    \      var data = {{\n        nodes: nodes,\n        edges: edges\n      }};\n\
    \      var options = {{smooth:false}};\n      var network = new vis.Network(container,\
    \ data, options);\n    </script>\n  </body>\n</html>\n\"\"\"\n    f.write(s)\n\
    \    f.close\n    var r = execShellCmd(\"brave-browser graph.html\")\n"
  dependsOn:
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/graph/graph_template.nim
  isVerificationFile: false
  path: atcoder/extra/graph/visualize.nim
  requiredBy: []
  timestamp: '2022-10-10 21:34:07+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/graph/visualize.nim
layout: document
redirect_from:
- /library/atcoder/extra/graph/visualize.nim
- /library/atcoder/extra/graph/visualize.nim.html
title: atcoder/extra/graph/visualize.nim
---
