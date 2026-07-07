---
title: Tree backends
documentation_of: //src/atcoder/extra/structure/tree_backends.nim
---

# Tree backends

Nim-ACL には、順序集合・列操作・遅延伝播などのための低レベル木 backend がいくつかあります。

通常の順序集合・順序写像を使いたい場合は、まず次を使うのが推奨です。

```nim
import atcoder/extra/structure/sorted_set_map
```

このページでは、より低レベルの backend を直接使う場合の最小限の使い方をまとめます。

## RedBlackTree

`red_black_tree` は順序木 backend です。

```nim
import atcoder/extra/structure/red_black_tree

var rb = initRedBlackTree[int]()

let n3 = rb.insert(rb.End, 3)
discard rb.insert(n3, 1)
discard rb.insert(rb.End, 5)

var xs: seq[int] = @[]
var it = rb.begin()
while it != rb.End:
  xs.add(*it)
  it.inc

doAssert xs == @[1, 3, 5]
```

`iterOrder` は低レベル sentinel の値を含むことがあるため、直接 backend を使う場合は `begin()` から `End` まで node を進める走査が安全です。

## RandomizedBinarySearchTree with parent

`randomized_binary_search_tree_with_parent` は、列を split / merge で扱う RBST backend です。

```nim
import atcoder/extra/structure/randomized_binary_search_tree_with_parent

var t = initRandomizedBinarySearchTree[int](seed = 1)

t.build(@[1, 2, 3])
doAssert t.toSeq == @[1, 2, 3]

t.insert_index(1, 10)
doAssert t.toSeq == @[1, 10, 2, 3]

t.erase_index(2)
doAssert t.toSeq == @[1, 10, 3]

t[1] = 20
doAssert t.toSeq == @[1, 20, 3]

let (l, r) = t.split_index(1)
t.root = t.merge(l, r)

doAssert t.toSeq == @[1, 20, 3]
```

## SplayTree

`splay_tree` も列を扱う backend です。`insert_index`, `erase_index`, `split_index`, `merge`, `toSeq` などを使えます。

```nim
import atcoder/extra/structure/splay_tree

var t = initSplayTree[int]()

t.build(@[1, 2, 3])
doAssert t.toSeq == @[1, 2, 3]

t.insert_index(1, 10)
doAssert t.toSeq == @[1, 10, 2, 3]

t.erase_index(2)
doAssert t.toSeq == @[1, 10, 3]

t[1] = 20
doAssert t.toSeq == @[1, 20, 3]

let (l, r) = t.split_index(t.root, 1)
t.root = t.merge(l, r)

doAssert t.toSeq == @[1, 20, 3]
```

## Common sequence backend interface

RBST と SplayTree は、列 backend としておおむね次の interface に寄せています。

| 操作 | RBST | SplayTree |
| --- | --- | --- |
| 長さ | `len` | `len` |
| sequence 化 | `toSeq` | `toSeq` |
| k 番目取得 | `[]` | `[]` |
| k 番目代入 | `[]=` | `[]=` |
| k 番目に挿入 | `insert_index` | `insert_index` |
| k 番目を削除 | `erase_index` | `erase_index` |
| split | `split_index` | `split_index` |
| merge | `merge` | `merge` |
| 検査 | `check_tree` | `check_tree` |

Nim は識別子が style-insensitive なので、`insertIndex` のような camelCase alias は追加していません。`insertIndex` は `insert_index` と同一視され、再定義エラーになるためです。

また、`insert_index` / `erase_index` は値を返さない wrapper として使うため、`discard t.insert_index(...)` ではなく、単に `t.insert_index(...)` と書きます。
