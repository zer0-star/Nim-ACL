# set_map

> このページは互換用 alias です。新規コードでは [sorted_set_map](./sorted_set_map.html) を推奨します。

この module は互換用の alias です。

順序付き集合・順序付き写像の実装本体は `sorted_set_map` にあります。

```text
import atcoder/extra/structure/sorted_set_map
```
既存コードとの互換性のため、次の import でも同じ API を使えます。

```text
import atcoder/extra/structure/set_map
```
新しく書くコードでは `sorted_set_map` の利用を推奨します。

提供される主な型は次の通りです。

```text
SortedSet
SortedMultiSet
SortedMap
SortedMultiMap
```
詳しい使い方は [sorted_set_map](sorted_set_map.html) を参照してください。
