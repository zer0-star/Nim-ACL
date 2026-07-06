# skew_heap

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/structure/skew_heap

## 公開 API

    const ATCODER_SKEW_HEAP_HPP* = 1
    proc initSkewHeap*[T,E](rev = false):SkewHeap[T,E] =
    proc initSkewHeap*[T,E](g:proc(a:T,b:E):T, h:proc(a, b:E):E, rev = false): SkewHeap[T,E] =
    proc propagate*[T,E](self:SkewHeap[T,E], t:Node[T,E]):Node[T,E] {.discardable.} =
    proc merge*[T,E](self:SkewHeap[T,E], x, y:Node[T,E]):Node[T,E] =
    proc push*[T,E](self: SkewHeap[T,E], root: var Node[T, E], key:T) =
    proc top*[T,E](self: SkewHeap[T,E], root:Node[T,E]):T = self.propagate(root).key
    proc pop*[T,E](self: SkewHeap[T,E], root:var Node[T,E]):T {.discardable.}=
    proc empty*[T,E](self: SkewHeap[T,E], root:Node[T,E]):bool = (root == nil)
    proc add*[T,E](self:SkewHeap[T,E], root:Node[T,E], lazy:E) =
    proc makeheap*[T,E](self:SkewHeap[T,E]):Node[T,E] = nil

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
