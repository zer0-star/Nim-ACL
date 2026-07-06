# heavy_light_decomposition

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/tree/heavy_light_decomposition

## 公開 API

    proc initHeavyLightDecomposition*[G:Graph](g:G, s = 0):HeavyLightDecomposition[G.T] =
    proc la*[T](self:HeavyLightDecomposition[T]; v, k:int):int =
    proc lca*[T](self:HeavyLightDecomposition[T]; u, v:int):int =
    proc dist*[T](self: HeavyLightDecomposition[T], u, v:int):int =
    proc query*[T,U](self: HeavyLightDecomposition[T]; u, v:int, ti:U, q:(int, int)->U, f, s:(U,U)->U, edge = false):U =
    proc query*[T,U](self: HeavyLightDecomposition[T]; u, v:int, ti:U, q:(int, int)->U, f:(U,U)->U, edge = false):U = self.query(u, v, ti, q, f, f, edge)
    proc add*[T](self: HeavyLightDecomposition[T]; u, v:int, q:(int,int)->void, edge = false) =
    proc get_heavy_path*[T](self:HeavyLightDecomposition[T], g:Graph, u:int):tuple[heavy:seq[int], light:seq[seq[int]]] =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
