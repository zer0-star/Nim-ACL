# ソート済みSetとMap

二分木によりキーをソートした状態で管理するset, tableのデータ構造です。C++のset, map, multiset, multimapと同等の機能をNimで使うために作りました。(Nimでの名称はset/tableだからSortedSet/SortedTableの方がいいか？)
イテレータはNodeという名称で管理されていて、木のノードの参照がそのまま渡されます。

## SortedSet
### コンストラクタ
```nim
var a = initSortedSet(T, countable:static[bool]=false, comp:proc(a, b:T):bool=nil)
var a:SortedSet(T,countable=false,comp:proc(a,b:T):bool=nil); a.init()
```

- SortedSetの構造を作ります。Tはキーの型、countableはインデックスによるランダムアクセス(後述)を可能にするかどうか, compは比較関数です。countable, compは省略可能で省略した場合はそれぞれfalse, 通常の比較関数が渡されます。

### 先頭と末尾
```nim
a.begin()
```
先頭の要素のNode(iterator)を取得します。

- 計算量: $O(\log N)$

```nim
a.end()
```
末尾の要素のNode(iterator)を取得します。C++同様、このend()ノードには値は入っていないのでご注意ください。endが予約後になってて実装にちょっと苦労しました。

- 計算量: $O(1)$

### 挿入
```nim
var it = a.insert(x)
var it = a.incl(x)
```
- 先に指定したT型のキーを挿入します。C++風のinsertとNim風のinclの両方で呼び出し可能です。戻り値は挿入した部分のNode(iterator)が返されます。この戻り値はdiscardableです。

### 削除
```nim
var it = a.erase(x:T)
var it = a.excl(x:T)
var it = a.erase(it0)
var it = a.erase(it0)
```
- 先に指定したT型のキーを削除します。C++風のeraseとNim風のexclの両方で呼び出し可能です。戻り値は削除したノードの次の要素のNode(iterator)が返されます。そのようなキーがない場合はa.end()が返されます。この戻り値はdiscardableです。
### 検索
```nim
var it = a.find(x:T)
```

要素xを検索してイテレータを返します。存在しない場合はa.end()が返ります。

### lower_bound
```nim
var it = a.lower_bound(x:T)
```

x以上の最初のイテレータを返します。

### upper_bound
```nim
var it = a.upper_bound(x:T)
```

xより大きい最初のイテレータを返します。


## SortedMultiSet
### コンストラクタ
```nim
var a = initSortedMultiSet(T, countable:static[bool]=false, comp:proc(a, b:T):bool=nil)
var a:SortedMultiSet(T,countable=false,comp:proc(a,b:T):bool=nil); a.init()
```

ほかは大体同じ

## SortedMap

### コンストラクタ
```nim
var a = initSortedMap(K, V, countable:static[bool]=false, comp:proc(a, b:T):bool=nil)
var a:SortedMap(K, V,countable=false,comp:proc(a,b:T):bool=nil); a.init()
```

Kにキー、Vにバリューを指定します。他の引数は同上です。

### 挿入
```nim
var it = a.insert((key:K, value:V))
var it = a.incl((key:K, value:V))
```
- (key, value)のペアを指定することで挿入可能です。すでにkeyが存在している場合はその部分のvalueだけ書き換えます。

### []演算子による挿入
```nim
a[key:T] = value:V
```
挿入時には[]演算子も使えます。存在しない場合は新たにキーが追加されるのでご注意ください。

ほかは同じです。

## SortedMultiMap
```nim
var a = initSortedMultiMap(K, V, countable:static[bool]=false, comp:proc(a, b:T):bool=nil)
var a:SortedMultiMap(K, V,countable=false,comp:proc(a,b:T):bool=nil); a.init()
```

## イテレーターの操作
### 値の取得
```nim
var p = *it
```

C++と同様、イテレータのアスタリスクで要素の取得が可能です。setの場合は要素自身、mapの場合はキーとバリューのペアになります。


### インクリメント・デクリメント
```nim
it.inc
it.dec
var it2 = it.succ
var it2 = it.pred
it += n
it -= n
```

ノード(iterator)はinc, dec関数でインクリメント可能です。end()ノードのインクリメント、begin()ノードのデクリメントは未定義動作です。succ, predでそれぞれ次の要素、前の要素を取得できます。

- 計算量: $O(\log N)$


## インデックス関連
下記の処理はコンストラクト時にcountableをtrueにしている必要があります。falseになっているとこの機能は使えませんが余計な処理がない分少し早いかもしれません。
### インデックスによるアクセス
``` nim
var it = a.kth_element(k:int)
var it = a{k:int}
```
上記の操作でk番目の要素のイテレータを取り出すことが可能です。
``` nim
var k = it.index
```
イテレータの現在のインデックスを取得できます。
``` nim
var d = distance(it, it2)
```
C++同様, 2つのイテレータの距離を取得できます。

- 計算量: $O(\log N)$


