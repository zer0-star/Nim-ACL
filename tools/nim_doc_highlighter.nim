when not declared NIM_ACL_DOC_HIGHLIGHTER_HPP:
  const NIM_ACL_DOC_HIGHLIGHTER_HPP* = 1

  import std/base64
  import packages/docutils/highlite

  proc escapeHtml(text: string): string =
    result = newStringOfCap(text.len)

    for ch in text:
      case ch
      of '&':
        result.add "&amp;"
      of '<':
        result.add "&lt;"
      of '>':
        result.add "&gt;"
      of '"':
        result.add "&quot;"
      of '\'':
        result.add "&#39;"
      else:
        result.add ch

  proc tokenCssClass(kind: TokenClass): string =
    case kind
    of gtKeyword:
      "tok-keyword"

    of gtStringLit, gtLongStringLit, gtCharLit:
      "tok-string"

    of gtEscapeSequence:
      "tok-escape"

    of gtDecNumber, gtBinNumber, gtHexNumber,
       gtOctNumber, gtFloatNumber:
      "tok-number"

    of gtComment, gtLongComment:
      "tok-comment"

    of gtOperator:
      "tok-operator"

    of gtPunctuation:
      "tok-punctuation"

    of gtIdentifier:
      "tok-identifier"

    of gtPreprocessor, gtDirective:
      "tok-directive"

    of gtHyperlink:
      "tok-hyperlink"

    of gtWhitespace, gtEof:
      ""

    else:
      "tok-other"

  proc appendHighlightedToken(
    resultHtml: var string,
    text: string,
    cssClass: string
  ) =
    ## A token may contain line breaks, for example a long comment or string.
    ## Each line fragment is wrapped independently so that line-number markup
    ## can later split lines without producing unbalanced span elements.
    var segmentStart = 0

    for i, ch in text:
      if ch != '\n':
        continue

      let segment =
        if segmentStart < i:
          text[segmentStart ..< i]
        else:
          ""

      if cssClass.len == 0:
        resultHtml.add escapeHtml(segment)
      elif segment.len > 0:
        resultHtml.add "<span class=\""
        resultHtml.add cssClass
        resultHtml.add "\">"
        resultHtml.add escapeHtml(segment)
        resultHtml.add "</span>"

      resultHtml.add '\n'
      segmentStart = i + 1

    let tail =
      if segmentStart < text.len:
        text[segmentStart ..< text.len]
      else:
        ""

    if cssClass.len == 0:
      resultHtml.add escapeHtml(tail)
    elif tail.len > 0:
      resultHtml.add "<span class=\""
      resultHtml.add cssClass
      resultHtml.add "\">"
      resultHtml.add escapeHtml(tail)
      resultHtml.add "</span>"

  proc highlightNim(code: string): string =
    for item in tokenize(code, langNim):
      let
        token = item[0]
        kind = item[1]

      result.appendHighlightedToken(
        token,
        tokenCssClass(kind),
      )

  proc processLine(encoded: string): string =
    if encoded.len == 0:
      return ""

    let code = decode(encoded)
    encode(highlightNim(code))

  when isMainModule:
    for encodedLine in stdin.lines:
      stdout.writeLine processLine(encodedLine)
