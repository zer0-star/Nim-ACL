# 永続DSU

永続配列と同様に、`=`演算子で、ある時点でのDSUの状態を「コピー」してそれぞれ別のデータ構造として更新が可能です。
当然中身をすべてコピーしないため、高速です。

## コンストラクタ
```nim
var d = initPersistentDSU[T](sz:int):PersistentDSU
```
$sz$をサイズとするDSUを作成します。通常のDSU同様、最初はすべて独立した状態になっています。

## merge
```nim
d.merge(a, b:int):int
```
通常のDSU同様、辺$(a, b)$を足します。

## same
```nim
a.same(a, b:int):bool
```
通常のDSU同様、頂点$a, b$が連結かどうかを返します

## leader
```nim
d.leader(a:int):int
```
通常のDSU同様、$a$の属する連結成分の代表元を返します


## DSUのコピー
```nim
var d2 = d
```

永続配列同様、`=`演算子で高速に「コピー」が可能でコピー後に`d`に対して行う処理は`d2`には影響しません


