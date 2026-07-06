# mincostflow_generalized

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/graph/mincostflow_generalized

## 公開 API

    const ATCODER_EXTRA_GRAPH_MINCOSTFLOW_GENERALIZED_HPP* = 1
    type MCFEdge*[Cap, Cost] = object
    type MCFGraph*[Cap, Cost, graphType] = object
    proc initMCFGraph*[Cap, Cost, graphType](n:int):MCFGraph[Cap, Cost, graphType] = result.n = n
    proc initMinCostFLow*[Cap, Cost, graphType](n:int):MCFGraph[Cap, Cost, graphType] = result.n = n
    proc add_edge*[Cap, Cost, graphType](self: var MCFGraph[Cap, Cost, graphType], src, dst:int, cap:Cap, cost:Cost):int {.discardable.} =
    proc get_edge*[Cap, Cost, graphType](self:MCFGraph[Cap, Cost, graphType], i:int): MCFEdge[Cap, Cost] =
    proc edges*[Cap, Cost, graphType](self:var MCFGraph[Cap, Cost, graphType]):seq[MCFEdge[Cap, Cost]] = self.edges
    proc `<`*[Cost](l, r:MCFQ[Cost]):bool = l.key > r.key
    proc slope*[Cap, Cost, graphType](self: MCFGraph[Cap, Cost, graphType], g:var csr[MCFInternalEdge[Cap, Cost]], s, t:int, flow_limit:Cap):seq[tuple[cap:Cap, cost:Cost]] =
    proc slope*[Cap, Cost, graphType](self:var MCFGraph[Cap, Cost, graphType], s, t:int, flow_limit:Cap):seq[tuple[cap:Cap, cost:Cost]] =
    var elist = newSeqOfCap[(int, MCFInternalEdge[Cap, Cost])](2 * m)
    proc flow*[Cap, Cost, graphType](self:var MCFGraph[Cap, Cost, graphType], s, t:int, flow_limit:Cap):tuple[cap:Cap, cost:Cost] = self.slope(s, t, flow_limit)[^1]
    proc flow*[Cap, Cost, graphType](self:var MCFGraph[Cap, Cost, graphType], s, t:int):tuple[cap:Cap, cost:Cost] = self.flow(s, t, Cap.high)
    proc slope*[Cap, Cost, graphType](self:var MCFGraph[Cap, Cost, graphType], s, t:int):seq[tuple[cap:Cap, cost:Cost]] = self.slope(s, t, Cap.high)
    proc reset*[Cap, Cost, graphType](self: var MCFGraph[Cap, Cost, graphType]) =
    proc set_edge*[Cap, Cost, graphType](self: var MCFGraph[Cap, Cost, graphType], i:int, cap:Cap, cost:Cost) =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
