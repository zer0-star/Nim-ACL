
# SegTree2D compatibility API

このmoduleは、従来のimport pathとinterfaceを維持するための互換moduleです。

```nim
import atcoder/extra/structure/segtree_2d
```

新規コードでは [CompressedSegTree2D](./compressed_segtree_2d.html) を使用してください。

## 従来constructor

```nim
var tree =
  initSegTree2D[int](
    points,
    addInt,
    zeroInt,
  )
```

渡された演算は可換演算として扱われます。

## 従来API

```nim
tree.add(x, y, value)
tree.prod(xLeft..xRight, yLeft..yRight)
tree[xLeft..xRight, yLeft..yRight]
```

`add` はcanonical APIの `combineAt` に対応します。`Slice` queryは終端を含みます。`Slice × int` と `int × Slice` も維持されています。

4整数版の

```nim
tree.prod(
  xLeft,
  xRight,
  yLeft,
  yRight,
)
```

はcanonical APIと同じ半開矩形です。

| 従来API | canonical API |
|---|---|
| `SegTree2D` | `CompressedSegTree2D` |
| `initSegTree2D` | `initCompressedSegTree2D` |
| `add` | `combineAt` |
| inclusive `Slice` query | 4整数の半開 `prod` |

互換moduleにdeprecated warningは付けていません。

利用箇所がなく、通常版より機能が狭かった `segtree_2d_backup` は削除されています。
