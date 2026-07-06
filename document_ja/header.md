# header

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/header

## 公開 API

    const ATCODER_HEADER_HPP* = 1
    proc scanf*(formatstr: cstring){.header: "<stdio.h>", varargs.}
    proc getchar*(): char {.header: "<stdio.h>", varargs.}
    proc nextInt*(base:int = 0): int =
    proc nextFloat*(): float = scanf("%lf",addr result)
    proc nextString*(): string =
    template `max=`*(x,y:typed):void = x = max(x,y)
    template `min=`*(x,y:typed):void = x = min(x,y)
    template inf*(T): untyped =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
