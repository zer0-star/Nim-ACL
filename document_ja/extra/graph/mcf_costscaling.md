# mcf_costscaling

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/graph/mcf_costscaling

## 公開 API

    const ATCODER_MCF_COSTSCALING_HPP* = 1
    proc initMCFCostScaling*[Cap, Cost; SCALING: static[int] = 1;
    proc addEdge*[Cap, Cost; SCALING: static[int]; REFINEMENT_ITER: static[int]]( self: var MCFCostScaling[Cap, Cost, SCALING, REFINEMENT_ITER], src, dst: int, capVal: Cap, costVal: Cost ): int {.discardable.} =
    let scaledCost = costVal * Cost(self.n + 1)
    proc addSupply*[Cap, Cost; SCALING: static[int]; REFINEMENT_ITER: static[int]]( self: var MCFCostScaling[Cap, Cost, SCALING, REFINEMENT_ITER], v: int, supply: Cap ) =
    proc addDemand*[Cap, Cost; SCALING: static[int]; REFINEMENT_ITER: static[int]]( self: var MCFCostScaling[Cap, Cost, SCALING, REFINEMENT_ITER], v: int, demand: Cap ) =
    proc solveAs*[Cap, Cost, RetCost; SCALING: static[int]; REFINEMENT_ITER: static[int]]( self: var MCFCostScaling[Cap, Cost, SCALING, REFINEMENT_ITER], _: typedesc[RetCost] ): RetCost =
    proc solve*[Cap, Cost; SCALING: static[int]; REFINEMENT_ITER: static[int]]( self: var MCFCostScaling[Cap, Cost, SCALING, REFINEMENT_ITER] ): Cost =
    proc potential*[Cap, Cost; SCALING: static[int]; REFINEMENT_ITER: static[int]]( self: MCFCostScaling[Cap, Cost, SCALING, REFINEMENT_ITER] ): seq[Cost] =
    proc getEdge*[Cap, Cost; SCALING: static[int]; REFINEMENT_ITER: static[int]]( self: MCFCostScaling[Cap, Cost, SCALING, REFINEMENT_ITER], e: int ): MCFEdge[Cap, Cost] =
    proc edges*[Cap, Cost; SCALING: static[int]; REFINEMENT_ITER: static[int]]( self: MCFCostScaling[Cap, Cost, SCALING, REFINEMENT_ITER] ): seq[MCFEdge[Cap, Cost]] =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
