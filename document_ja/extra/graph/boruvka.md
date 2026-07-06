# boruvka

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/graph/boruvka

## 公開 API

    const ATCODER_BORUVKA_HPP* = 1
    type Boruvka*[T] = object
    proc initBoruvka*[T](V:int, inf = -1):Boruvka[T] =
    proc find*[T](self:Boruvka[T], k:int):int = self.uf.leader(k)
    proc build*[T](self:Boruvka[T], update:proc(ret:var seq[(int,int)])):T =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
