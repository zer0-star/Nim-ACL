# dice

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/other/dice

## 公開 API

    const ATCODER_DICE* = 1
    type FACE* = enum
    type dice*[T] = object
    proc initDice*[T]():dice[T] =
    proc `[]`*[T](self:dice[T], f:FACE):T = self.val[self.id[f.int]]
    proc `[]=`*[T](self:var dice[T], f:FACE, t:T) = self.val[self.id[f.int]] = t
    proc `==`*[T](self, b:dice[T]):bool =
    proc roll*[T](self: var dice[T], a, b, c, d:FACE) =
    proc roll_x*[T](self:var dice[T]) = self.roll(TOP, BACK, BOTTOM, FRONT)
    proc roll_y*[T](self:var dice[T]) = self.roll(TOP, LEFT, BOTTOM, RIGHT)
    proc roll_z*[T](self:var dice[T]) = self.roll(FRONT, RIGHT, BACK, LEFT)
    proc all_rolls*[T](self:dice[T]):seq[dice[T]] =
    proc equivalent_to*[T](self, di: dice[T]):bool =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
