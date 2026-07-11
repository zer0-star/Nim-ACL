# Persistent Segment Tree（永続セグメント木）

更新前のversionを保持したまま、新しいversionを作成できるセグメント木です。

Nim-ACL標準の`SegTree`と同様に、モノイド演算`op`と単位元`e`をstatic generic tupleから呼び出します。

## import

~~~nim
import atcoder/extra/structure/persistent_segment_tree
~~~

## モノイド

~~~nim
proc addInt(
  left,
  right: int,
): int =
  left + right

proc zeroInt(): int =
  0
~~~

## 初期化

~~~nim
var tree =
  PersistentSegTree[
    int,
    (
      op: addInt,
      e: zeroInt,
    ),
  ].init(
    @[1, 2, 3, 4],
    expectedUpdates = 100,
  )
~~~

長さだけを指定すると、すべて`e()`で初期化されます。

~~~nim
var tree =
  PersistentSegTree[
    int,
    (
      op: addInt,
      e: zeroInt,
    ),
  ].init(
    200_000,
    expectedUpdates = 200_000,
  )
~~~

次の簡略記法も、同じstatic generic型を生成します。

~~~nim
var tree = initPersistentSegmentTree(
  @[1, 2, 3, 4],
  addInt,
  zeroInt,
  expectedUpdates = 100,
)
~~~

## version

~~~nim
let version0 = tree.initialVersion
~~~

versionは`PersistentVersion`型です。頂点番号や区間端点とは異なる型なので、生の`int`より引数順の間違いを検出しやすくなります。

## 一点更新

~~~nim
let version1 = tree.set(
  1,
  20,
  version0,
)
~~~

引数順は標準`SegTree`に合わせて、

```text
position, value, version
```

です。`version0`は変更されず、`version1`だけが新しい値を持ちます。

## 一点取得

~~~nim
echo tree.get(
  1,
  version0,
)

echo tree.get(
  1,
  version1,
)
~~~

引数順は、

```text
position, version
```

です。

## 区間積

~~~nim
echo tree.prod(
  1 ..< 4,
  version1,
)
~~~

または、

~~~nim
echo tree.prod(
  1,
  4,
  version1,
)
~~~

半開区間\([l,r)\)の積を返します。引数順はrangeまたは`l, r`を先に置き、versionを最後に置きます。

## 全体積

~~~nim
echo tree.allProd(version1)
~~~

Nimの識別子は大文字小文字とunderscoreを区別しないため、`all_prod`も同じprocを呼びます。

## 配列化

~~~nim
let values = tree.toSeq(version1)
~~~

debugや小規模な確認用です。計算量は\(O(N\log N)\)です。

## `expectedUpdates`

<!-- NIM_ACL_TUNING_PARAMETER: expectedUpdates -->

| 項目 | 説明 |
|---|---|
| 意味 | 今後行う一点更新回数の見積もりです。version数の上限ではありません。 |
| 事前確保 | 内部のnode poolをあらかじめ確保し、更新中の再確保を減らします。 |
| 正しさ | 値はcapacity hintだけに使われるため、正しさには影響しません。 |
| 小さすぎる場合 | 必要に応じて`seq`が自動拡張されます。再確保やcopyが増える可能性があります。 |
| 大きすぎる場合 | 使わないcapacityも予約するため、メモリ消費が増える可能性があります。 |
| 省略時 | 既定値は`0`です。初期木に必要なcapacityだけを事前確保します。 |

内部の`size`は\(N\)以上の最小の2冪で、木の高さを\(h=\log_2(\mathrm{size})\)とすると、node poolの初期capacityは

\[
2\mathrm{size}
+
\mathrm{expectedUpdates}(h+1)
\]

です。

一点更新では、根から葉までの経路を複製するため、ちょうど\(h+1\)個のnodeを追加します。

## 計算量

初期配列の長さを\(N\)、更新回数を\(U\)とします。

- 初期化: \(O(N)\)
- `set`: \(O(\log N)\)
- `get`: \(O(\log N)\)
- `prod`: \(O(\log N)\)
- `allProd`: \(O(1)\)
- versionの保持・代入: \(O(1)\)
- node数: \(O(N+U\log N)\)

## 旧runtime API

既存コードとの互換性のため、`identity`とclosureの`op`をconstructorへ渡し、生のroot番号を先頭引数に取る旧APIも残しています。

新しいコードでは、引数順の安全性と標準`SegTree`との一貫性のため、static generic APIを推奨します。
