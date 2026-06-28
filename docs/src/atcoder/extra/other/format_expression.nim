import strutils

proc formatExpression*(expr: string): seq[string] =
  proc splitMixedToken(token: string): seq[string] =
    # 数字で始まり、途中に文字が出てきたら分割
    var i = 0
    while i < token.len and token[i].isDigit:
      inc i
    if i > 0 and i < token.len:
      result = @[token[0..<i], token[i..^1]]
    else:
      result = @[token]
  var
    tokens: seq[string] = @[]
    current = ""

  for ch in expr:
    if ch in "+-*/^()":
      if current.len > 0:
        tokens.add current;current = ""
      tokens.add $ch
    elif ch.isSpaceAscii:
      if current.len > 0:
        tokens.add current;current = ""
    else:
      current.add ch
  if current.len > 0:
    tokens.add current

  # 数字文字混合トークンを分割
  var flatTokens: seq[string] = @[]
  for t in tokens:
    for sub in splitMixedToken(t):
      flatTokens.add sub

  # 整形（演算子の間に空白、掛け算の * を補完）
  for i in 0 ..< flatTokens.len:
    let curr = flatTokens[i]
    result.add curr

    if i < flatTokens.len - 1:
      let next = flatTokens[i + 1]
      let currOp = curr in ["+", "-", "*", "/", "^"]
      let nextOp = next in ["+", "-", "*", "/", "^"]
      if (not currOp and curr != "(") and (not nextOp and next != ")"):
        result.add "*"
