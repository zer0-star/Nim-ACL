# set_map

この module は互換用の alias です。

順序付き集合・順序付き写像の実装本体は `sorted_set_map` にあります。

    import atcoder/extra/structure/sorted_set_map

既存コードとの互換性のため、次の import でも同じ API を使えます。

    import atcoder/extra/structure/set_map

新しく書くコードでは `sorted_set_map` の利用を推奨します。

提供される主な型は次の通りです。

    SortedSet
    SortedMultiSet
    SortedMap
    SortedMultiMap

詳しい使い方は [sorted_set_map](sorted_set_map.html) を参照してください。
