
# DynamicSegTree

`dynamic_segtree` は、実行時に `op` と `e` を渡して使うセグメント木です。

名前は `dynamic` ですが、ここでの意味は「演算を実行時に持つ」ことであり、座標を動的に増やす疎なセグメント木ではありません。長さ `n` は初期化時に固定されます。

## import

    import atcoder/dynamic_segtree

## コンストラクタ

    var st = initSegTree[S](v:seq[S], op:proc(a, b:S):S, e:proc():S)
    var st = initSegTree[S](n:int, op:proc(a, b:S):S, e:proc():S)

列 `v` から、または長さ `n` の単位元列からセグメント木を構築します。

@{keyword.constraints}

- `op` は結合的
- `e()` は `op` の単位元

@{keyword.complexity}

- $O(n)$

## set

    st.set(p:int, x:S):void

位置 `p` の値を `x` に変更します。

@{keyword.constraints}

- `0 <= p < n`

@{keyword.complexity}

- $O(\log n)$

## get

    st.get(p:int):S

位置 `p` の値を返します。

@{keyword.constraints}

- `0 <= p < n`

@{keyword.complexity}

- $O(1)$

## prod

    st.prod(l..r):S

区間 `l..r` の値を返します。

この実装の `prod` は `Slice[int]` を受け取り、`l..r` を閉区間として扱います。

@{keyword.constraints}

- `0 <= l <= r < n`

@{keyword.complexity}

- $O(\log n)$

## all_prod

    st.all_prod():S

全体の値を返します。

@{keyword.complexity}

- $O(1)$

## max_right / min_left

    st.max_right(l:int, f:proc(s:S):bool):int
    st.min_left(r:int, f:proc(s:S):bool):int

ACL の `segtree` と同様に、条件 `f` を満たす最大右端・最小左端を二分探索します。

@{keyword.constraints}

- `f(e()) == true`

@{keyword.complexity}

- $O(\log n)$

## 使用例

    import atcoder/dynamic_segtree

    proc op(a, b:int):int = a + b
    proc e():int = 0

    var st = initSegTree[int](@[1, 2, 3, 4, 5], op, e)

    doAssert st.prod(0..4) == 15
    doAssert st.prod(1..3) == 9

    st.set(2, 10)

    doAssert st.get(2) == 10
    doAssert st.prod(0..4) == 22

## 注意

`prod` の引数は `Slice[int]` で、`0..4` のような閉区間です。`0..<4` 形式ではなく、右端を含む範囲として扱います。
