# set_map

`set_map` は互換用 alias module です。

新規コードでは通常 [`sorted_set_map`](./sorted_set_map.html) を推奨します。

## import

~~~nim
import atcoder/extra/structure/set_map
~~~

## 定義

~~~nim
import atcoder/extra/structure/sorted_set_map
export sorted_set_map
~~~

この module は `sorted_set_map` を import/export します。  
そのため、`set_map` を import しても `SortedSet`, `SortedMap`, `initSortedSet`, `initSortedMap` などを利用できます。

## 使用例

~~~nim
import atcoder/extra/structure/set_map

var s = initSortedSet[int]()

s.insert(3)
s.insert(1)

doAssert 1 in s
doAssert 2 notin s
~~~

## 注意

古いコードとの互換性のために残されています。  
新しく書く場合は次を推奨します。

~~~nim
import atcoder/extra/structure/sorted_set_map
~~~
