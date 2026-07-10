# Aho-Corasick

`Aho-Corasick` は、複数の pattern 文字列をまとめて検索するためのアルゴリズムです。

すべての pattern を Trie に入れ、そこに failure link を張ることで、text を 1 回走査するだけで多数の pattern の出現位置をまとめて検出できます。

## 使いどころ

次のような問題でよく使います。

- 多数の禁止文字列を含むか判定する
- text 中に現れる pattern をすべて列挙する
- 複数 pattern matching
- 文字列 DP の状態遷移に「禁止 pattern の出現」を組み込む
- 各 pattern ごとに KMP を回すと重すぎる問題

## 考え方

まず、すべての pattern を Trie に追加します。  
Trie の node は、「ここまで読んだ suffix が、どの pattern prefix に一致しているか」を表します。

しかし、text を走査している途中で次の文字に対応する Trie edge が無いことがあります。  
そのとき、今まで読んだ文字列の suffix のうち、別の pattern prefix として使える最長のものへ移動します。これが failure link です。

failure link を使うと、text の各文字について automaton state を 1 回進めるだけで済みます。  
その state に pattern 終端があれば、そこに対応する pattern が出現したことになります。

## import

~~~nim
import atcoder/extra/string/aho_corasick
~~~

## 型

~~~nim
type AhoCorasick
type AhoCorasickNode
type AhoCorasickMatch
~~~

`AhoCorasickMatch` は次の field を持ちます。

~~~nim
l: int
r: int
patternId: int
~~~

match 区間は半開区間 `[l, r)` です。

## コンストラクタ

~~~nim
proc initAhoCorasick(): AhoCorasick
proc initAhoCorasick(patterns: openArray[string]): AhoCorasick
~~~

空で作ってから pattern を追加するか、pattern list から一気に構築できます。

## pattern 追加と build

~~~nim
proc addPattern(ac: var AhoCorasick, pattern: string): int
proc build(ac: var AhoCorasick)
~~~

- `addPattern(pattern)` は pattern を追加し、その pattern id を返します。
- pattern は空文字列にできません。
- すべての pattern を追加したあとに `build()` を呼んでください。
- `build()` 後に pattern を追加することは想定していません。

## 操作

~~~nim
proc len(ac: AhoCorasick): int
proc patternCount(ac: AhoCorasick): int

proc nextState(ac: AhoCorasick, state: int, ch: char): int
proc transition(ac: AhoCorasick, state: int, ch: char): int

proc findAll(ac: AhoCorasick, text: string): seq[AhoCorasickMatch]
proc countMatches(ac: AhoCorasick, text: string): int
proc matchCount(ac: AhoCorasick, text: string): int
proc contains(ac: AhoCorasick, text: string): bool
~~~

- `findAll(text)` はすべての match を返します。
- `countMatches(text)` は match 数を返します。
- `contains(text)` は 1 つ以上の pattern が text に含まれるかを返します。
- `text in ac` でも `contains` と同じ判定ができます。
- `transition` は `nextState` の alias です。

## 使用例

~~~nim
var ac = initAhoCorasick()

let
  he = ac.addPattern("he")
  she = ac.addPattern("she")
  hers = ac.addPattern("hers")

ac.build()

let matches = ac.findAll("ushers")

for m in matches:
  echo "pattern ", m.patternId, " appears at [", m.l, ", ", m.r, ")"

doAssert ac.countMatches("ushers") == 3
doAssert ac.contains("ushers")
~~~

`initAhoCorasick(patterns)` で一気に構築することもできます。

~~~nim
let ac = initAhoCorasick(@["a", "aa", "aaa"])

doAssert ac.countMatches("aaaa") == 9
~~~

## Nim らしい使い方

`contains` が定義されているので、text が何かの pattern を含むかを `in` で書けます。

~~~nim
if text in ac:
  echo "matched"
~~~

`transition` を使うと、automaton を DP 状態として扱いやすくなります。

~~~nim
var state = 0

for ch in text:
  state = ac.transition(state, ch)
~~~

## 計算量

pattern の総長を `M`、text 長を `N`、match 数を `Z` とします。

- 構築: `O(M * alphabet + M)` に近いです。この実装では char alphabet 256 の完全遷移表を作ります。
- `findAll`: `O(N + Z)`
- `countMatches`: `O(N)`
- memory: `O(states * 256 + total output)`

です。

## 注意

- この実装は `char` / `string` 用です。
- alphabet は 256 として完全遷移表を持ちます。
- Unicode の grapheme cluster 単位の処理には対応していません。
- `findAll` の match 区間は半開区間 `[l, r)` です。
- `build()` 後に pattern を追加することはできません。

## 関連資料・他言語ライブラリ

- cp-algorithms: Aho-Corasick algorithm
- Nyaan Library: Aho-Corasick
- ei1333 Library: Aho-Corasick
- KACTL: Aho-Corasick
- Library Checker: multiple pattern matching / string 系問題
