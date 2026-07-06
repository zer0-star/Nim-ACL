# matrix

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/math/matrix

## 公開 API

    const ATCODER_MATRIX_HPP* = 1
    type StaticMatrix*[T; N, M:static[int];Vector;p:static[tuple]] = object
    type DynamicMatrix*[T;Vector;p:static[tuple]] = object
    type DynamicVector*[T] = seq[T]
    type StaticMatrixObj*[T; p:static[tuple]] =
    type StaticVector*[T; N:static[int]] = array[N, T]
    type SomeMatrix* = StaticMatrix | DynamicMatrix
    type SomeVector* = StaticVector | DynamicVector
    template height*(self: DynamicMatrix):int = self.N
    template height*[M:StaticMatrix](self: M):int = M.N
    template width*(self: DynamicMatrix):int = self.M
    template width*[M:StaticMatrix](self: M):int = M.M
    proc `[]`*[M:StaticMatrix](self:M, i, j:int):M.T = self.data[i][j]
    proc `[]`*[M:StaticMatrix](self:var M, i, j:int):var M.T = self.data[i][j]
    proc `[]=`*[M:StaticMatrix](self:var M, i, j:int, a:M.T) = self.data[i][j] = a
    proc `[]`*[M:DynamicMatrix](self:M, i, j:int):M.T = self.data[i * self.M + j]
    proc `[]`*[M:DynamicMatrix](self:var M, i, j:int):var M.T = self.data[i * self.M + j]
    proc `[]=`*[M:DynamicMatrix](self:var M, i, j:int, a:M.T) = self.data[i * self.M + j] = a
    proc init*[M:DynamicMatrix](self:typedesc[M] or M, n, m:int):M =
    proc init*[M:DynamicMatrix](self:typedesc[M] or M, n:int):M = M.init(n, n)
    proc init*[M:StaticMatrixObj | StaticMatrix](self:typedesc[M] or M, n, m:static[int]):auto =
    proc init*[M:StaticMatrixObj | StaticMatrix](self:typedesc[M] or M, n:static[int]):auto = M.init(n, n)
    template DynamicMatrixType*(T:typedesc):auto =
    template DynamicMatrixType*(T:typedesc, p:static[OperatorType]):auto =
    template StaticMatrixType*(T:typedesc):auto =
    template StaticMatrixType*(T:typedesc, p:static[OperatorType]):auto =
    proc initVector*[M:DynamicMatrix](self:M or typedesc[M], n:int):DynamicVector[M.T] = DynamicVector[M.T](newSeqWith(n, M.p.zero()))
    proc initVector*[M:DynamicMatrix](self:M or typedesc[M], a:seq or array):DynamicVector[M.T] =
    template initVector*[M:StaticMatrix | StaticMatrixObj](self:M or typedesc[M], n:static[int]):auto =
    template initVector*[M:StaticMatrix | StaticMatrixObj](self:M or typedesc[M], a:array):auto =
    proc init*[T, Vector, p](self:DynamicMatrix[T, Vector, p] or typedesc[DynamicMatrix[T, Vector, p]], a: seq or array):auto =
    template init*[M:StaticMatrixObj | StaticMatrix](self:M or typedesc[M], a:array):auto =
    proc unit*[M:DynamicMatrix](self: typedesc[M], n:int):M =
    proc unit*[M:DynamicMatrix](self: M, n = -1):M =
    proc unit*[M:StaticMatrix or StaticMatrixObj](self: typedesc[M], n:static[int]):auto =
    proc unit*[M:StaticMatrix](self: M, n:static[int] = -1):M =
    proc `+=`*[M:SomeMatrix](self: var M, B: M) =
    proc `+=`*[V:SomeVector](self: var V, B:V) =
    proc `-=`*[M:SomeMatrix](self: var M, B: M) =
    proc `*=`*[M:SomeMatrix](self: var M, B: M) =
    proc `*`*[M:DynamicMatrix](self:M, B:M):auto =
    proc `*`*(self:StaticMatrix, B:auto):auto =
    proc `*`*[M:SomeMatrix](self: M, v: M.Vector): auto =
    proc `*=`*[M:SomeMatrix](self: var M, B: M.T) =
    proc `-`*[M:SomeMatrix](self: M):auto =
    proc `*`*[M:DynamicMatrix](self:M, B:M.T):auto = (var C = self); C *= B; C
    proc `+`*[M:SomeMatrix](self: M, B:M):auto =
    proc `-`*[M:SomeMatrix](self: M, B:M):auto =
    proc `+`*[T](self, B:DynamicVector[T]):auto =
    proc equals*[M:SomeMatrix](A, B:M):bool =
    proc toString*[M:SomeMatrix](self: M):string =
    proc determinant*[M:SomeMatrix](self: M):auto =
    proc gaussianElimination*[M:SomeMatrix](A:M):(seq[seq[M.T]], seq[int]) =
    proc linearEquations*[M:SomeMatrix](A:M, b:SomeVector):auto =
    proc inv*[M:SomeMatrix](A:M):M =
    var A2 = M.init(n, n * 2)
    proc `/=`*[M:SomeMatrix](self: var M, B: M) = self *= B.inv
    proc `/`*[M:SomeMatrix](self, B: M):M =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
