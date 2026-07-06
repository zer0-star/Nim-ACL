# static_eratosthenes

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/math/static_eratosthenes

## 公開 API

    const ATCODER_STATIC_ERATOSTHENES_HPP* = 1
    type Eratosthenes*[n:static[int]] = object
    proc init*(self: var Eratosthenes) =
    var m = i * i
    proc initEratosthenes*(n:static[int]):Eratosthenes[n] =
    proc isPrime*(self:Eratosthenes, n:int): bool =
    proc primeDivisor*(self:Eratosthenes, n:int):int =
    proc factor*(self:var Eratosthenes, n:int): seq[(int,int)] =
    proc divisor*(self: var Eratosthenes, n:int):seq[int] =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
