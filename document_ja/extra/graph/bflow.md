# bflow

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/graph/bflow

## 公開 API

    const ATCODER_BFLOW_HPP* = 1
    type BFlow*[CAP, COST] = object
    proc initBFlow*[CAP, COST](N = 0): BFlow[CAP, Cost] =
    proc add_supply*[CAP, COST](self: var BFlow[CAP, COST], v: int, supply: CAP) = self.b[v] += supply
    proc add_demand*[CAP, COST](self: var BFlow[CAP, COST], v: int, demand: CAP) = self.b[v] -= demand
    proc add_edge*[CAP, COST](self: var BFlow[CAP, COST], s, t: int, lower_cap, upper_cap: CAP, cost: COST) =
    proc solve*[CAP, COST](self: var BFlow[CAP, COST]): (bool, COST) =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
