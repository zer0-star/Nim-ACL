# succinct_indexable_dictionary

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/structure/succinct_indexable_dictionary

## 公開 API

    const SUCCINCT_INDEXABLE_DICTIONARY_HPP* = 1
    type SuccinctIndexableDictionary* = object
    proc initSuccinctIndexableDictionary*(len:int):SuccinctIndexableDictionary =
    proc set*(self:var SuccinctIndexableDictionary, k:int) =
    proc build*(self:var SuccinctIndexableDictionary) =
    proc `[]`*(self:SuccinctIndexableDictionary, k:int):bool =
    proc rank*(self:SuccinctIndexableDictionary, k:int):int =
    proc rank*(self:SuccinctIndexableDictionary, val:bool, k:int):int =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
