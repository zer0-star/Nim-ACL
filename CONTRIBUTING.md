# 新しいライブラリを提案するとき

適切な issue を建て、自分で作成したい場合はコメントを残してください。

# 提案されたライブラリを作成するとき

以下の点に注意してください。

- ファイルは `src/nim_acl/` に設置してください。
- 先頭に `when defined ...` で始まる定型句を記述してください (他のファイルなどを参照してください。詳細な仕様はまだ定まっていません) 。
- 他のファイルに依存しているときは、 `import` ではなく `include` を使ったほうが良いです。
- その際、 `include` のパスを `src` から始まるようにしてください。
- verify 用のファイルは `verify/` に設置してください。
- verify 用のファイルは https://online-judge-tools.github.io/verification-helper/document.ja.html を参照して適切な設定をしてください。
- (未確定) ACL に収録されていないものは、`src/nim_acl/extra/`に設置してください。
