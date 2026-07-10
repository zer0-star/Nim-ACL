# AtCoder Level-Based Library Guide

This page groups Nim-ACL modules by approximate AtCoder color level.

The classification is only a guideline. The difficulty of a problem depends heavily on recognizing the technique and combining it with other ideas.

| Level | Approximate colors |
|---|---|
| Beginner | Gray, brown, green |
| Intermediate | Cyan, blue |
| Advanced | Yellow and above |


## Relationship to the official lecture catalog

The beginner/intermediate/advanced levels on this page are Nim-ACL-specific
usage categories. They are separate from the official difficulty levels 1–9.

See the
[AtCoder Algorithm Lectures coverage page](./atcoder_algorithm_lectures_coverage.html)
for the official cross-reference.

# Beginner

Focus on basic transformations, graph traversal, prefix aggregation, and standard data structures.

## Recommended modules

| Area | Module | Typical use |
|---|---|---|
| Array | [Coordinate Compression](../extra/algorithm/coordinate_compression.html) | Large sparse coordinates |
| Array | [Run-Length Encoding](../extra/algorithm/run_length_encoding.html) | Consecutive equal groups |
| Set | [MexSet](../extra/structure/mex_set.html) | Dynamic mex |
| Set | [SortedSet / SortedMap](../extra/structure/sorted_set_map.html) | Ordered containers |
| Graph | [Functional Graph / Doubling](../extra/graph/functional_graph.html) | Apply a function many times |
| String | [KMP](../extra/string/kmp.html) | Single-pattern matching |
| Geometry | [Geometry facade](../extra/geometry/geometry.html) | Basic geometry |

Core ACL modules:

~~~nim
import atcoder/dsu
import atcoder/fenwicktree
import atcoder/segtree
import atcoder/modint
~~~

## Suggested order

1. Run-Length Encoding
2. Coordinate Compression
3. Prefix sums
4. DSU
5. Fenwick Tree
6. Dijkstra
7. Segment Tree
8. Functional Graph
9. KMP

# Intermediate

Intermediate problems require selecting a structure based on static/dynamic, online/offline, and algebraic properties.

## Range queries

| Module | Use |
|---|---|
| [Sparse Table](../extra/structure/sparse_table.html) | Static idempotent queries |
| [Disjoint Sparse Table](../extra/structure/disjoint_sparse_table.html) | Static associative queries |
| [FastSet](../extra/structure/fast_set.html) | Successor / predecessor |
| [Binary Trie](../extra/structure/binary_trie.html) | XOR optimization |
| [Wavelet Matrix](../extra/structure/wavelet_matrix.html) | Rank, frequency, k-th |
| [Mo](../extra/algorithm/mo.html) | Offline range queries |
| [Cartesian Tree](../extra/structure/cartesian_tree.html) | RMQ and monotonic stack structure |

## Strings

| Module | Use |
|---|---|
| [Manacher](../extra/string/manacher.html) | Palindrome radii |
| [Aho-Corasick](../extra/string/aho_corasick.html) | Multiple-pattern matching |
| [Minimum Rotation](../extra/string/minimum_rotation.html) | Canonical cyclic rotation |
| Rolling Hash | Substring comparison |
| Suffix Array | Lexicographic substring structure |

## Trees and DP

| Module | Use |
|---|---|
| [Rerooting DP](../extra/graph/rerooting_dp.html) | Tree DP for every root |
| Heavy-Light Decomposition | Path queries |
| LCA | Ancestor and distance queries |


## Static and persistent range structures

| Module | Use |
|---|---|
| [Sqrt Tree](../extra/structure/sqrt_tree.html) | Static monoid range products |
| [Persistent Segment Tree](../extra/structure/persistent_segment_tree.html) | Queries over old versions |
| [Euler Tour](../extra/graph/euler_tour.html) | Convert subtrees to intervals |

# Advanced

Advanced problems frequently combine offline processing, rollback, tree compression, and graph decomposition.

## Dynamic connectivity

| Module | Use |
|---|---|
| [Rollback DSU](../extra/structure/rollback_dsu.html) | Undo DSU merges |
| [Offline Dynamic Connectivity](../extra/graph/offline_dynamic_connectivity.html) | Edge insertion/deletion offline |
| Partially Persistent DSU | Queries about past states |

## Advanced tree techniques

| Module | Use |
|---|---|
| [Virtual Tree](../extra/graph/virtual_tree.html) | Compress important vertices |
| [DSU on Tree](../extra/graph/dsu_on_tree.html) | Subtree frequency queries |
| Rerooting DP | All-root tree DP |
| Link-Cut Tree | Dynamic forests |

## Undirected graph decomposition

| Module | Use |
|---|---|
| [Undirected Graph Decomposition](../extra/graph/undirected_decomposition.html) | Shared low-link interface |
| [Biconnected Components](../extra/graph/biconnected_components.html) | Articulation-based blocks |
| [Two-Edge-Connected Components](../extra/graph/two_edge_connected_components.html) | Bridge-based components |
| [Block-Cut Tree](../extra/graph/block_cut_tree.html) | Tree of blocks and articulations |

## Advanced strings

| Module | Use |
|---|---|
| [Suffix Automaton](../extra/string/suffix_automaton.html) | Distinct substrings and occurrences |
| [Palindromic Tree](../extra/string/palindromic_tree.html) | Distinct palindromes |
| Aho-Corasick | Automaton DP |
| Suffix Array / LCP | Substring ordering |

## Advanced mathematics

| Module | Use |
|---|---|
| [FPS](../extra/math/fps.html) | Formal power series |
| Convolution / NTT | Polynomial multiplication |
| [XOR Basis](../extra/math/xor_basis.html) | GF(2) linear basis |

# Quick selection guide

| Problem shape | Candidate |
|---|---|
| Large values, few distinct coordinates | Coordinate Compression |
| Apply a mapping `k` times | Functional Graph |
| Max/min XOR with an element | Binary Trie |
| Representable subset XOR | XOR Basis |
| Multiple patterns | Aho-Corasick |
| Palindrome range checks | Manacher |
| Distinct palindromes | Palindromic Tree |
| Every-root tree DP | Rerooting |
| Subtree frequency queries | DSU on Tree |
| Important vertex subset on a tree | Virtual Tree |
| Offline edge deletion | Offline Dynamic Connectivity |
| Bridges and articulation points | Low-link decomposition |

# Future candidates

High-priority future candidates include:

- Dominator Tree
- Mo on Tree
- Persistent Binary Trie
- Miller-Rabin / Pollard Rho
- Segment Tree Beats facade
- Persistent Segment Tree
