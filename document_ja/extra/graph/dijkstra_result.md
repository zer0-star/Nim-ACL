# dijkstra_result

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/graph/dijkstra_result

## 公開 API

    const ATCODER_DIJKSTRA_RESULT_HPP* = 1
    type DijkstraResult*[T, U, useId] = object
    proc contains*[T, U, useId](d:var DijkstraResult[T, U, useId], u:U):bool =
    proc `[]`*[T, U, useId](d:var DijkstraResult[T, U, useId], u:U):T =
    proc prev*[T, U, useId](d:var DijkstraResult[T, U, useId], u:U):U =
    proc path*[T, U, useId](d:var DijkstraResult[T, U, useId], t:U): seq[U] =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
