# universal_segtree

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/structure/universal_segtree

## 公開 API

    const ATCODER_UNIVERSAL_SEGTREE_HPP* = 1
    template calc_op*[ST:UniversalSegTree](self:ST or typedesc[ST], a, b:ST.S):auto =
    template calc_e*[ST:UniversalSegTree](self:ST or typedesc[ST]):auto =
    template calc_mapping*[ST:UniversalSegTree](self:ST or typedesc[ST], a:ST.F, b:ST.S):auto =
    template calc_composition*[ST:UniversalSegTree](self:ST or typedesc[ST], a, b:ST.F):auto =
    template calc_id*[ST:UniversalSegTree](self:ST or typedesc[ST]):auto =
    template calc_p*[ST:UniversalSegTree](self:ST or typedesc[ST], a:ST.F, s:Slice[int]):auto =
    proc update*[ST:UniversalSegTree](self:var ST, k:int) =
    proc push*[ST:UniversalSegTree](self: var ST, k:int)
    proc all_apply*[ST:UniversalSegTree](self:var ST, k:int, f:ST.F) =
    proc push*[ST:UniversalSegTree](self: var ST, k:int) =
    proc init*[ST:UniversalSegTree](self: var ST, v:seq[ST.S] or seq[ST.F]) =
    proc init*[ST:UniversalSegTree](self: var ST, v:int) =
    template SegTreeType*[S](op, e:untyped):typedesc =
    template initSegTree*[S](v:int or seq[S], op, e:untyped):auto =
    template DualSegTreeType*[F](composition, id:untyped):auto =
    template initDualSegTree*[F](v:int or seq[F], composition, id:untyped):auto =
    template LazySegTreeType*[S,F](op,e,mapping,composition,id:untyped):auto =
    template initLazySegTree*[S,F](v:int or seq[S], op,e,mapping,composition,id:untyped):auto =
    template LazySegTreeWithPType*[S,F](op,e,mapping,composition,id,p:untyped):auto =
    template initLazySegTree_with_p*[S,F](v:int or seq[S], op,e,mapping,composition,id,p:untyped):auto =
    template SegTreeBeatsType*[S,F](op,e,mapping,composition,id:untyped):typedesc =
    template initSegTreeBeats*[S,F](v:int or seq[S], op,e,mapping,composition,id:untyped):auto =
    proc set*[ST:UniversalSegTree](self: var ST, p:IndexType, x:auto) =
    proc `[]=`*[ST:UniversalSegTree](self: var ST, p:IndexType, x:auto) = self.set(p, x)
    proc get*[ST:UniversalSegTree](self: var ST, p:IndexType):auto =
    proc `[]`*[ST:UniversalSegTree](self: var ST, p:IndexType):auto = self.get(p)
    proc prod*[ST:UniversalSegTree](self:var ST, p:RangeType):ST.S =
    proc `[]`*[ST:UniversalSegTree](self:var ST, p:RangeType):ST.S = self.prod(p)
    proc all_prod*[ST:UniversalSegTree](self:ST):auto = self.d[1]
    proc apply*[ST:UniversalSegTree](self: var ST, p:IndexType, f:ST.F) =
    proc apply*[ST:UniversalSegTree](self: var ST, p:RangeType, f:ST.F) =
    proc max_right*[ST:UniversalSegTree](self:var ST, l:IndexType, g:(ST.S)->bool):int =
    proc min_left*[ST:UniversalSegTree](self: var ST, r:IndexType, g:(ST.S)->bool):int =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
