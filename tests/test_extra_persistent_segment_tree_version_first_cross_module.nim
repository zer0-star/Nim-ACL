import std/unittest

import support/persistent_segment_tree_version_first_helper


suite "PersistentSegTree version-first cross-module":
  test "nested read and write work across modules":
    var tree =
      buildCrossTree()

    let version0 =
      tree.initialVersion

    var version =
      version0

    tree[version][1] = 5
    tree[version][3] = 9

    check tree[version][0 .. 3] == 14
    check tree[version0][0 .. 3] == 0

    let nextVersion =
      tree.set(
        version,
        2,
        7,
      )

    check tree.get(
      nextVersion,
      2,
    ) == 7

    check tree.prod(
      nextVersion,
      0,
      4,
    ) == 21
