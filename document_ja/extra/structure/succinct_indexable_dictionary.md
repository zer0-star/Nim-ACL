
# SuccinctIndexableDictionary

Succinct Indexable Dictionary です。

長さ `n` の bit 列に対して、各位置の bit を取得したり、先頭から `k` 個の範囲に含まれる `1` の個数を高速に数えたりできます。

Wavelet Matrix などの内部部品としてよく使われます。

## import

    import atcoder/extra/structure/succinct_indexable_dictionary

## コンストラクタ

    var sid = initSuccinctIndexableDictionary(n:int)

長さ `n` の bit 列を作ります。初期値はすべて `0` です。

@{keyword.constraints}

- `0 <= n`

@{keyword.complexity}

- $O(n / 32)$

## set

    sid.set(k:int):void

位置 `k` の bit を `1` にします。

`build()` の前に呼び出してください。

@{keyword.constraints}

- `0 <= k < n`

@{keyword.complexity}

- $O(1)$

## build

    sid.build():void

rank クエリに必要な累積個数を構築します。

`set` をすべて終えたあとに一度呼び出してください。

@{keyword.complexity}

- $O(n / 32)$

## get

    sid[k]:bool

位置 `k` の bit を返します。

@{keyword.constraints}

- `0 <= k < n`

@{keyword.complexity}

- $O(1)$

## rank

    sid.rank(k:int):int
    sid.rank(val:bool, k:int):int

`sid.rank(k)` は、半開区間 `0..<k` に含まれる `1` の個数を返します。

`sid.rank(true, k)` は `1` の個数、`sid.rank(false, k)` は `0` の個数を返します。

@{keyword.constraints}

- `0 <= k <= n`

@{keyword.complexity}

- $O(1)$

## 使用例

    import atcoder/extra/structure/succinct_indexable_dictionary

    var sid = initSuccinctIndexableDictionary(70)

    for k in [0, 1, 31, 32, 69]:
      sid.set(k)

    sid.build()

    doAssert sid[0]
    doAssert sid[31]
    doAssert not sid[33]

    doAssert sid.rank(70) == 5
    doAssert sid.rank(true, 70) == 5
    doAssert sid.rank(false, 70) == 65

## 注意

`set` のあとに `build()` を呼ばないと、`rank` の結果は正しくなりません。

`rank(k)` は `0..<k` の個数を返す半開区間形式です。
