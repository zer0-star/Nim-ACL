# eulerian_trail

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/graph/eulerian_trail

## 公開 API

    const ATCODER_EULERIAN_TRAIL_HPP* = 1
    type EulerianTrail*[directed:static[bool]] = object
    proc initEulerianTrail*(V:int, directed:static[bool]):auto =
    proc add_edge*(self:var EulerianTrail, a, b:int) =
    proc get_edge*(self:var EulerianTrail, idx:int):(int,int) = self.es[idx]
    proc enumerate_eulerian_trail*(self:var EulerianTrail):seq[seq[int]] =
    proc enumerate_semi_eulerian_trail*(self:var EulerianTrail):seq[seq[int]] =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
