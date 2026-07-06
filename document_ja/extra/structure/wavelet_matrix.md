
# WaveletMatrix

Wavelet Matrix です。

静的な列に対して、区間内の `k` 番目の値、値の出現回数、値域に入る個数などを高速に求められます。

この実装には、整数列を直接扱う `WaveletMatrix` と、座標圧縮して任意の順序付き値を扱う `CompressedWaveletMatrix` があります。

## import

    import atcoder/extra/structure/wavelet_matrix

## コンストラクタ

    let wm = initWaveletMatrix[T](v:seq[T], MAXLOG:static[int])

列 `v` から Wavelet Matrix を構築します。

`MAXLOG` は値の bit 長です。たとえば値が `0 <= x < 2^20` に収まるなら `MAXLOG = 20` とします。

@{keyword.constraints}

- `T` は `shr`, `shl`, `and`, `or` などの bit 演算ができる整数型
- `0 <= v[i] < 2^MAXLOG`

@{keyword.complexity}

- 構築 $O(n \log A)$
- `A = 2^MAXLOG`

## access

    wm[k]:T
    wm.access(k:int):T

元の列の `k` 番目の値を返します。

@{keyword.constraints}

- `0 <= k < n`

@{keyword.complexity}

- $O(\log A)$

## rank

    wm.rank(x:T, r:int):int

半開区間 `0..<r` に含まれる `x` の個数を返します。

@{keyword.constraints}

- `0 <= r <= n`

@{keyword.complexity}

- $O(\log A)$

## kth_smallest / kth_largest

    wm.kth_smallest(p:Slice[int], k:int):T
    wm.kth_largest(p:Slice[int], k:int):T

区間 `p` に含まれる値のうち、`k` 番目に小さい値、または `k` 番目に大きい値を返します。

`k` は 0-indexed です。

@{keyword.constraints}

- `0 <= k < p.len`

@{keyword.complexity}

- $O(\log A)$

## range_freq

    wm.range_freq(p:Slice[int], upper:T):int
    wm.range_freq(p:Slice[int], lower:T, upper:T):int

区間 `p` に含まれる値のうち、`upper` 未満の個数、または `lower <= x < upper` を満たす個数を返します。

@{keyword.complexity}

- $O(\log A)$

## prev_value / next_value

    wm.prev_value(p:Slice[int], upper:T):T
    wm.next_value(p:Slice[int], lower:T):T

`prev_value` は区間 `p` に含まれる `upper` 未満の最大値を返します。

`next_value` は区間 `p` に含まれる `lower` 以上の最小値を返します。

該当する値がない場合は `-1` を返します。

@{keyword.complexity}

- $O(\log A)$

## CompressedWaveletMatrix

    let wm = initCompressedWaveletMatrix[T](v:seq[T], MAXLOG:static[int])

値を座標圧縮してから Wavelet Matrix を構築します。

`T` は整数以外でも、比較可能であれば使えます。`MAXLOG` は圧縮後の値域に対する bit 長です。

## 使用例

    import atcoder/extra/structure/wavelet_matrix

    let v = @[3, 1, 4, 1, 5, 9, 2, 6]
    let wm = initWaveletMatrix[int](v, 4)

    doAssert wm[0] == 3
    doAssert wm.rank(1, 4) == 2

    doAssert wm.kth_smallest(0..<8, 0) == 1
    doAssert wm.kth_largest(0..<8, 0) == 9

    doAssert wm.range_freq(0..<8, 2, 6) == 4
    doAssert wm.prev_value(0..<8, 5) == 4
    doAssert wm.next_value(0..<8, 5) == 5

## 注意

通常の `WaveletMatrix` は非負整数を想定します。負の値や大きな値を含む場合は `CompressedWaveletMatrix` を使ってください。

`prev_value` / `next_value` は該当値がない場合に `-1` を返します。そのため、値として `-1` があり得る場合は注意してください。
