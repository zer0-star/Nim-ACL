---
title: Tree backends
documentation_of: //src/atcoder/extra/structure/tree_backends.nim
---

# Tree backends

Nim-ACL には、順序集合・列操作・遅延伝播などのための低レベル木 backend がいくつかあります。

通常の順序付き set / map が欲しい場合は、まず [`sorted_set_map`](./sorted_set_map.html) を使ってください。

~~~nim
import atcoder/extra/structure/sorted_set_map
~~~

## 通常利用向け

### sorted_set_map

~~~nim
import atcoder/extra/structure/sorted_set_map
~~~

推奨される順序付き set / map interface です。

提供される主な型です。

~~~nim
SortedSet(K)
SortedMultiSet(K)
SortedMap(K, V)
SortedMultiMap(K, V)
~~~

## 互換 alias

### set_map

~~~nim
import atcoder/extra/structure/set_map
~~~

`set_map` は `sorted_set_map` の互換 alias です。  
新規コードでは `sorted_set_map` を推奨します。

## 低レベル backend

次の module は内部または高度な用途向けの木 backend です。

~~~nim
import atcoder/extra/structure/red_black_tree
import atcoder/extra/structure/randomized_binary_search_tree_with_parent
import atcoder/extra/structure/splay_tree
~~~

### RedBlackTree

`sorted_set_map` の標準 backend です。  
低レベル node 操作が露出しているため、通常は直接使う必要はありません。

### RandomizedBinarySearchTree

列操作・split/merge を直接扱いたい場合の backend です。

### SplayTree

列操作・反転・遅延伝播などを扱える backend です。

## 注意

複数の低レベル backend module を同時に import すると、同じ名前の関数が衝突することがあります。  
必要な backend だけを import してください。

この `tree_backends` module 自体は documentation-only module で、低レベル backend を re-export しません。
