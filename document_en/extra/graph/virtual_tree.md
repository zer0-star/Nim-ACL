# Auxiliary Tree (Virtual Tree)

Builds a compressed tree containing selected vertices and the LCAs needed to connect them.

The structure is commonly called an **Auxiliary Tree** or **Virtual Tree**. This page uses Auxiliary Tree as the primary name while retaining Virtual Tree to match the existing module and API names.

## Import

~~~nim
import atcoder/extra/graph/virtual_tree
~~~

## Preprocessing

~~~nim
let vt = initVirtualTree(graph, root = 0)
~~~

`graph` is a zero-indexed undirected tree. Preprocessing builds Euler-tour order, depths, and binary-lifting LCA metadata.

## `buildVirtualTree`

~~~nim
let built = vt.buildVirtualTree(keys)
~~~

The result contains every selected vertex and every LCA required to connect them.

- `built.root`: compressed index of the root
- `built.vertices[i]`: original vertex represented by compressed vertex `i`
- `built.edges`: `(parent, child, dist)` tuples
- `built.adj[i]`: child edges from compressed vertex `i`
- `dist`: distance in the original tree

~~~nim
for edge in built.edges:
  echo built.vertices[edge.parent],
       " -> ",
       built.vertices[edge.child],
       " distance = ",
       edge.dist
~~~

## Additional APIs

~~~nim
echo vt.lca(u, v)
echo vt.dist(u, v)
echo vt.isAncestor(u, v)
~~~

## Complexity

For an original tree with \(N\) vertices and a selected set of size \(K\):

- preprocessing: \(O(N\log N)\)
- Auxiliary Tree construction: \(O(K\log K + K\log N)\)
- number of compressed vertices: \(O(K)\)

## Related material

- [ABC340 G official editorial: definition and construction of an Auxiliary Tree](https://atcoder.jp/contests/abc340/editorial/9256)
- [ABC359 G official editorial: an application of an Auxiliary Tree](https://atcoder.jp/contests/abc359/editorial/10259?lang=en)
- [Euler Tour](euler_tour.md)

## Practice problems

<details class="problem-examples">
<summary>Show problems that can use this library (may reveal the intended technique)</summary>
<ul>
  <li><a href="https://atcoder.jp/contests/abc340/tasks/abc340_g" target="_blank" rel="noopener">AtCoder Beginner Contest 340 G - Leaf Color</a></li>
  <li><a href="https://atcoder.jp/contests/abc359/tasks/abc359_g" target="_blank" rel="noopener">AtCoder Beginner Contest 359 G - Sum of Tree Distance</a></li>
</ul>
</details>
