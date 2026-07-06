import atcoder/extra/graph/graph_template
import std/os

#dot -Tpng graph.dot -o graph.png
template graphviz*[G:Graph](g:G, fname = "graph.pdf", base = 0) =
  when declared DEBUG:
    when DEBUG:
      var weighted=false;#,directed=true;
      for u in 0..<g.len:
        for i in 0..<g[u].len:
          if g[u][i].weight != 1: weighted = true
      var f = open("graph.dot", fmWrite)
      f.writeLine("digraph G{")
      f.writeLine("\tnode [style=rounded];")
      for u in 0..<g.len:
        f.writeLine("\t" & $u & "[label=" & $(u + base) & "];")
      for u in 0..<g.len:
        for e in g[u]:
          if e.rev != -1 and u > e.dst:continue # loop?
          f.write("\t" & $u & "->" & $e.dst)
          f.write("[")
          if e.rev != -1:f.write("arrowhead=none,")
          else: f.write("arrowhead=normal,")
          if weighted:f.write("label=" & $e.weight & ",")
          f.writeLine("];")
      f.writeLine("}")
      f.close()
      var command = "dot -Tpdf -Gsize=10,10\\! -Gdpi=100 graph.dot -o "
    #  sprintf(command,"dot -Tpng graph.dot -o graph%d.png",ct);
      command &= fname;
      discard execShellCmd(command)
      discard execShellCmd("evince " & fname)
