# Nim-ACL
ACL (AtCoder Library) のNimによる実装です。
ACLで実装されているものはexpander含めてすべてNimに変換しています。
一部、Nim向けに使いやすくなるような仕様も追加しました。

## expander
Nim-ACLによるimport, includeをすべて展開します。コマンドは本家ACLのものと同じです。
Nim-ACLはatcoderのジャッジ環境では呼び出せませんがexpanderで展開することで、atcoderでもコンパイル可能なコードを生成することが可能です。
online-judge-tools, atcoder-toolsなどの自動提出機能のあるツールと合わせて展開と提出を同時に行うようにすると便利です。
### expanderのオプション
```
usage: expander.py [-h] [-c] [-s] [--lib LIB] source
　--lib LIB     ライブラリへのパス(srcがあるディレクトリ)を表示します。本家ACLのものと同じです。
  -s            展開した部分が一行で表示され、提出ソースコードが読みやすくなります。NimおよびNim-ACL利用者を増やすためにもこのオプションを有効にしていただけたら嬉しいです。
```

## extra
ACLにないがよく使いそうなライブラリを独自に実装しています。
例えば、グラフ関連の処理(ダイクストラ法等)や累積和ライブラリなどがあります。こちらもexpanderで展開可能です。
大体、以下のスタンスで実装していきます。
* 仕様等はACLのものに統一(例: segtreeにおけるmapping, composition等の名称を二分木等の名称でも統一)
* 内部の処理にACLで実装済みのアルゴリズムが必要になった場合はACLのものを用いる
* C++, python等の他の主要言語の標準ライブラリと同等かそれ以上の環境を提供する。特に他の言語で標準搭載であるがNimでは実装されていないものも実装する。例えばC++におけるset/multiset, map/multiset, bitset等が該当し、SortedSet/SortedMultiSet, SortedMap/SortedMultiMap, BitSetという名前で実装しました。
  * これについては、どこまでやるかはちょっと悩みどころです。例えば、pythonのnumpyやC++のboostとかまでやろうとするとかなり大変そうです。
* 本家ACLほどの万全なサポートは行わないが、test, verifyはできるだけ書く
* READMEもできるだけ書く(英訳はできないかも)
* 将来ACLに実装された場合は順次そちらに置き換える

## verifyの実施方法
- [online-judge-tools/verification-helper](https://github.com/online-judge-tools/verification-helper/blob/master/README.ja.md#%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)を参考にpip installする
- [このドキュメント](https://github.com/online-judge-tools/verification-helper/blob/master/.verify-helper/docs/static/document.ja.md#%E5%AF%BE%E5%BF%9C%E3%82%B5%E3%83%BC%E3%83%93%E3%82%B9%E4%B8%80%E8%A6%A7)を参考にYUKICODER_TOKEN を取得し、環境変数を設定する。`export YUKICODER_TOKEN=xxx`
- `src/`に移動する
- すべてのverifyを通すには`oj-verify run`を実行する。初回は遅いので`-j N`(Nは論理コア数)をつけ並列処理が有効にすると良い
- 個別にveifyした場合は`oj-verify verify/crt_test.nim`のようにpathを指定する

apple silicon上でverifyに失敗した場合
- apple siliconはonline-judge側でスタックサイズを大きくすることができません。`ulimit -s 65000`の実行で多くのテストが成功するようになります

## ドキュメント
* ドキュメントはこちらです。
  * https://zer0-star.github.io/Nim-ACL/document_ja/index.html

## 使用上の注意
* 本ライブラリをコンパイルする際にはcppでのコンパイル、つまりnim cppが必要です。atcoderでもcppでコンパイルされています。nim cでは動きません。
* mathという名前の標準ライブラリがあるので、import atcoder/mathとimport mathはバッティングします。両方importしたい場合は後者をimport std/mathとしましょう。

# References
- https://atcoder.jp/posts/517?lang=ja
