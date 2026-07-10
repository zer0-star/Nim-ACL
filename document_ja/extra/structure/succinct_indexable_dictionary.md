# SuccinctIndexableDictionary

`SuccinctIndexableDictionary` は、bit 列に対して rank query を高速に処理するための data structure です。

Wavelet Matrix などの内部部品としてよく使われます。

## import

~~~nim
import atcoder/extra/structure/succinct_indexable_dictionary
~~~

## 型

~~~nim
type SuccinctIndexableDictionary
~~~

## コンストラクタ

~~~nim
proc initSuccinctIndexableDictionary(n: int): SuccinctIndexableDictionary
~~~

長さ `n` の bit 列を作ります。初期値はすべて `0` です。

## 操作

~~~nim
proc set(sid: var SuccinctIndexableDictionary, k: int)
proc build(sid: var SuccinctIndexableDictionary)

proc rank(sid: SuccinctIndexableDictionary, k: int): int
proc rank(sid: SuccinctIndexableDictionary, bit: bool, k: int): int
~~~

- `set(k)` は位置 `k` の bit を `1` にします。
- `build()` は rank 用の前処理をします。`set` をすべて呼んだあとに実行してください。
- `rank(k)` は区間 `[0, k)` に含まれる `1` の個数を返します。
- `rank(bit, k)` は区間 `[0, k)` に含まれる `bit` の個数を返します。

## 使用例

<!-- nim-line-numbers -->
~~~nim
var sid = initSuccinctIndexableDictionary(8)

sid.set(1)
sid.set(3)
sid.set(4)
sid.build()

doAssert sid.rank(0) == 0
doAssert sid.rank(4) == 2
doAssert sid.rank(8) == 3

doAssert sid.rank(true, 8) == 3
doAssert sid.rank(false, 8) == 5
~~~

## 制約

`build()` の後に `set()` を追加で呼ぶ用途は想定していません。  
bit をすべて設定してから `build()` してください。

## 計算量

- `set`: `O(1)`
- `build`: `O(n / word_size)`
- `rank`: `O(1)`

です。
