# maxflow_lowerbound

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/graph/maxflow_lowerbound

## 公開 API

    const ATCODER_EXTRA_GRAPH_MAXFLOW_LOWERBOUND_HPP* = 1
    type MaxFlowLowerBound*[Cap] = object
    proc initMaxFlowLowerBound*[Cap](V:int):MaxFlowLowerBound[Cap] =
    proc add_edge*[Cap](self: var MaxFlowLowerBound[Cap], src, dst:int, low, high: Cap) =
    proc build*[Cap](self: var MaxFlowLowerBound[Cap]) =
    proc can_flow*[Cap](self: var MaxFlowLowerBound[Cap]):bool =
    proc can_flow*[Cap](self: var MaxFlowLowerBound[Cap], s, t:int):bool =
    proc max_flow*[Cap](self: var MaxFlowLowerBound[Cap], s, t:int):Option[Cap] =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
