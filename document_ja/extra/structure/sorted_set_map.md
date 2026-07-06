# sorted_set_map

順序付き集合・順序付き写像です。

Nim 標準の `sets` / `tables` は hash-based なコンテナなので、C++ の `std::set` / `std::map` に近い「順序付き」の集合・写像が欲しい場合に使います。

この module は次の4種類のコンテナを提供します。

    SortedSet
    SortedMultiSet
    SortedMap
    SortedMultiMap

## import

    import atcoder/extra/structure/sorted_set_map

互換のため、次の import でも同じ API を使えます。

    import atcoder/extra/structure/set_map

新しく書くコードでは `sorted_set_map` の利用を推奨します。

## SortedSet

    var s = initSortedSet[K]()
    var s = initSortedSet[K](countable = true)
    var s = initSortedSet[K](countable = true, comp)

重複なしの順序付き集合です。

`countable = true` にすると、`s{k}` による k 番目要素アクセスや `index` が使えます。

## SortedMultiSet

    var s = initSortedMultiSet[K]()
    var s = initSortedMultiSet[K](countable = true)

重複ありの順序付き集合です。

現在の `erase(x)` は、`x` と等しい要素をまとめて削除します。

## SortedMap

    var mp = initSortedMap[K, V]()
    var mp = initSortedMap[K, V](countable = true)

順序付き写像です。

    mp[key] = value
    mp[key]

`mp[key] = value` で値を設定します。

`mp[key]` は値を返します。存在しない key に対して `mp[key]` を呼ぶと、default 値を持つ要素が挿入されます。

## SortedMultiMap

    var mp = initSortedMultiMap[K, V]()
    var mp = initSortedMultiMap[K, V](countable = true)

同じ key を複数持てる順序付き multimap です。

`insert((key, value))` で値を追加します。

現在の `erase(key)` は、その key を持つ要素をまとめて削除します。

## 主な操作

### insert

    s.insert(x)
    mp.insert((key, value))

要素を追加します。

`SortedSet` / `SortedMap` では同じ key は1つだけ保持されます。

### erase

    s.erase(x)
    mp.erase(key)

要素を削除します。

### contains

    x in s
    key in mp

存在判定をします。

### find

    s.find(x)
    mp.find(key)

node を返します。見つからない場合は `end()` を返します。

node の値は `*it` で取得できます。

### iteration

    for x in s:
      ...

    for k, v in mp:
      ...

昇順に走査します。

### kth access

    s{k}
    mp{k}

`countable = true` のとき、0-indexed で k 番目の node を返します。

## 使用例

    import atcoder/extra/structure/sorted_set_map

    var s = initSortedSet[int](countable = true)

    s.insert(3)
    s.insert(1)
    s.insert(4)
    s.insert(1)

    doAssert 1 in s
    doAssert 2 notin s

    doAssert *s{0} == 1
    doAssert *s{1} == 3
    doAssert *s{2} == 4

    s.erase(3)

    doAssert 3 notin s

    var mp = initSortedMap[string, int]()

    mp["three"] = 3
    mp["one"] = 1

    doAssert "one" in mp
    doAssert mp["one"] == 1

    for k, v in mp:
      discard

## 降順集合の例

    import atcoder/extra/structure/sorted_set_map

    proc desc(a, b:int):bool = a > b

    var s = initSortedSet[int](countable = true, desc)

    s.insert(3)
    s.insert(1)
    s.insert(4)

    doAssert *s{0} == 4
    doAssert *s{1} == 3
    doAssert *s{2} == 1

## 注意

この実装は Red-Black Tree を backend にした順序付きコンテナです。

`SortedMultiSet` / `SortedMultiMap` の `erase(key)` は、現状では該当 key を持つ範囲をまとめて削除します。

既存コードとの互換性のため `set_map` module からも同じ API を import できますが、新規コードでは `sorted_set_map` の利用を推奨します。
