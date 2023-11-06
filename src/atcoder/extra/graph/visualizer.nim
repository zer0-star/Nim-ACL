when not declared ATCODER_GRAPH_VISUALIZER_HPP:
  const ATCODER_GRAPH_VISUALIZER_HPP* = 1
  import atcoder/extra/graph/graph_template
  import std/strformat, std/sets, std/strutils, std/browsers
  proc visualize*(g:Graph, labels:seq[string] = @[], base = 0) =
    var
      node_data:seq[string]
      edge_data:seq[string]
      useNodeLabels = if labels.len == 0: false else: true
      isEdgeWeighted = block:
        var r = false
        for u in 0 ..< g.len:
          for e in g[u]:
            if e.weight != 1: r = true
        r
    if useNodeLabels:
      doAssert labels.len == g.len
    for u in 0 ..< g.len:
      var node_name = if useNodeLabels: labels[u] else: $(u + base)
      node_data.add fmt"{{id: {$u}, label: '{node_name}'}}"
    var undirected_edges = initHashSet[(int, int)]()
    for u in 0 ..< g.len:
      for e in g[u]:
        let v = e.dst
        var edge_label = if isEdgeWeighted: fmt"'{$e.weight}'" else: "undefined"
        if e.rev == -1:
          edge_data.add(fmt"{{from: {$u}, to: {$v}, arrows: 'to', label: {edge_label} }}")
        else:
          if (u, v) in undirected_edges: continue
          edge_data.add(fmt"{{from: {$u}, to: {$v}, label: {edge_label} }}")
          undirected_edges.incl((u, v))
          undirected_edges.incl((v, u))
    var html = """
<html>
<head>
    <script type="text/javascript" src="https://unpkg.com/vis-network/standalone/umd/vis-network.min.js"></script>

    <style type="text/css">
        #mynetwork {
            width: 100%;
            height: 100%;
            border: 1px solid lightgray;
        }
    </style>
</head>
<body>
<div id="mynetwork"></div>

<script type="text/javascript">
    // create an array with nodes
    var nodes = new vis.DataSet([
        <<<NODE_DATA>>>
    ]);

    // create an array with edges
    var edges = new vis.DataSet([
        <<<EDGE_DATA>>>
    ]);

    // create a network
    var container = document.getElementById('mynetwork');

    // provide the data in the vis format
    var data = {
        nodes: nodes,
        edges: edges
    };
    var options = {
        physics: {
            barnesHut: {
                avoidOverlap: 0.3
            }
        }
    };

    // initialize your network!
    var network = new vis.Network(container, data, options);
</script>
</body>
</html>"""
    html = html.replace("<<<NODE_DATA>>>", node_data.join(","))
    html = html.replace("<<<EDGE_DATA>>>", edge_data.join(","))
    var f = open("./graph.html", FileMode.fmWrite)
    f.write(html)
    openDefaultBrowser("./graph.html")
    defer: close(f)
