# mincostflow_lowerbound

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/graph/mincostflow_lowerbound

## 公開 API

    const ATCODER_MINCOSTFLOW_LOWERBOUND_HPP* = 1
    type MinCostFlowLowerBound*[Cap, Cost] = object
    proc initMinCostFlowLowerBound*[Cap, Cost, GraphType](V:int):MinCostFlowLowerBound[Cap, Cost] =
    proc add_edge*[Cap, Cost](self: var MinCostFlowLowerBound[Cap, Cost], src, dst:int, low, high: Cap, cost:Cost) =
    proc build*[Cap, Cost](self: var MinCostFlowLowerBound[Cap, Cost]) =
    proc can_flow*[Cap, Cost](self: var MinCostFlowLowerBound[Cap, Cost]):bool =
    proc can_flow*[Cap, Cost](self: var MinCostFlowLowerBound[Cap, Cost], s, t:int):bool =
    proc max_flow*[Cap, Cost](self: var MinCostFlowLowerBound[Cap, Cost], s, t:int):Option[(Cap, Cost)] =
    proc slope*[Cap, Cost](self: var MinCostFlowLowerBound[Cap, Cost], s, t:int):Option[seq[(Cap, Cost)]] =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
