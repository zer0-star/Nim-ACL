# graph_template_directed_undirected

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/graph/graph_template_directed_undirected

## 公開 API

    const ATCODER_EXTRA_GRAPH_GRAPH_TEMPLATE_DIRECTED_UNDIRECTED_HPP* = 1
    proc initEdge*[T; isDirected](src,dst:int,weight:T = 1,rev:int = -1):Edge[T, isDirected] =
    proc initUndirectedGraph*[T](n:int):Graph[T, void] = newSeqWith(n,newSeq[Edge[T, void]]())
    proc initDirectedGraph*[T](n:int):Graph[T, int] = newSeqWith(n,newSeq[Edge[T, int]]())
    proc addEdge*[T; isDirected](g:var Graph[T, isDirected], e:Edge[T, isDirected]):void =
    proc addEdge*[T; isDirected](g:var Graph[T, isDirected],src,dst:int,weight:T = 1):void =
    proc initUndirectedGraph*[T](n:int, a,b,c:seq[T]):Graph[T, void] =
    proc initUndirectedGraph*[T](n:int, a,b:seq[T]):Graph[T, void] =
    proc initDirectedGraph*[T](n:int, a,b:seq[int],c:seq[T]):Graph[T, int] =
    proc initDirectedGraph*[T](n:int, a,b:seq[int]):Graph[T, int] =
    proc `<`*[T; isDirected](l,r:Edge[T, isDirected]):bool = l.weight < r.weight

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
