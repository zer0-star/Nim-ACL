# Run-Length Encoding

Run-Length Encoding, RLE は、連続する同じ値を

```text
(value, count)
```

の組にまとめる方法です。

例えば、

```text
aaabbcaaaa
```

は、

```text
(a, 3), (b, 2), (c, 1), (a, 4)
```

になります。

## 使いどころ

- 連続区間ごとの処理
- 文字列の同じ文字の塊
- 01列の block 数
- 隣接する同値要素の圧縮
- simulation の状態数削減
- ABC の文字列・列問題

## import

~~~nim
import atcoder/extra/algorithm/run_length_encoding
~~~

## API

~~~nim
type Run[T] = tuple[value: T, count: int]

proc runLengthEncode(a): seq[Run[T]]
proc rle(a): seq[Run[T]]

proc runLengthDecode(runs): seq[T]
proc runLengthDecodeString(runs): string

proc compressedLength(runs): int
proc originalLength(runs): int
~~~

## 使用例

~~~nim
let runs = rle("aaabbcaaaa")

doAssert runs == @[
  (value: 'a', count: 3),
  (value: 'b', count: 2),
  (value: 'c', count: 1),
  (value: 'a', count: 4),
]

doAssert runLengthDecodeString(runs) == "aaabbcaaaa"
~~~

一般の sequence にも使えます。

~~~nim
let runs = rle(@[1, 1, 2, 3, 3])

doAssert runs == @[
  (value: 1, count: 2),
  (value: 2, count: 1),
  (value: 3, count: 2),
]
~~~

## 計算量

入力長を `n` とすると、

- encode: `O(n)`
- decode: `O(n)`
- memory: `O(number of runs)`

## 注意

RLE は同じ値の**総頻度**ではなく、連続する run を区別します。

例えば `[1, 1, 2, 1]` は `(1, 2), (2, 1), (1, 1)` です。
