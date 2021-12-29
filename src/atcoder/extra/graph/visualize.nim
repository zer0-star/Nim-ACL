when not declared ATCODER_GRAPH_VISUALIZE_HPP:
  const ATCODER_GRAPH_VISUALIZE_HPP* = 1
  import atcoder/extra/graph/graph_template
  import std/strformat, std/os

  proc is_weighted*(g:Graph):bool =
    static:
      assert g.adjType is ADJTYPE_SEQ
    for u in 0 ..< g.len:
      for e in g[u]:
        if e.weight != 1: return true
    return false

  proc is_directed*(g:Graph):bool =
    static:
      assert g.adjType is ADJTYPE_SEQ
    for u in 0 ..< g.len:
      for e in g[u]:
        if e.rev == -1: return true
    return false

  proc visualize*(g:Graph) =
    var f: File = open("graph.html", FileMode.fmWrite)
    var
      nodes_array:seq[string] = @[]
      edges_array:seq[string] = @[]
    let is_directed = g.is_directed
    let is_weighted = g.is_weighted
    var found = initSet[(int, int)]()
    for u in 0 ..< g.len:
      nodes_array.add(fmt"{{id: {u}, label: '{u}'}}")
      for i, e in g[u]:
        if not is_directed:
          if (u, i) in found: continue
          found.incl((e.dst, e.rev))
        var s = fmt"from: {u}, to: {e.dst}"
        if is_weighted:
          s &= fmt", label: '{e.weight}'"
        if is_directed:
          s &= ", arrows: 'to'"
        edges_array.add(fmt"{{ {s} }}")
    let
      nodes_info = nodes_array.join(",")
      edges_info = edges_array.join(",")
    var s = fmt"""
<html>
  <head>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/vis/4.21.0/vis.min.css" rel="stylesheet">
    <style type="text/css">
      #network {{
        width:  800px;
        height: 800px;
        border: 1px solid #000;
      }}
    </style>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/vis/4.21.0/vis.min.js"></script>
  </head>
  <body>
    <div id="network"></div>
    <script type="text/javascript">
      var nodes = new vis.DataSet([{nodes_info}]);
      var edges = new vis.DataSet([{edges_info}]);
      var container = document.getElementById('network');
      var data = {{
        nodes: nodes,
        edges: edges
      }};
      var options = {{smooth:false}};
      var network = new vis.Network(container, data, options);
    </script>
  </body>
</html>
"""
    f.write(s)
    f.close
    var r = execShellCmd("brave-browser graph.html")
