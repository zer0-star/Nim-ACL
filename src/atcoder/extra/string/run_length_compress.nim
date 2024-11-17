when not declared ATCODER_RUN_LENGTH_HPP:
  const ATCODER_RUN_LENGTH_HPP* = 1
  import strutils
  proc runLengthEncode*(s:string):seq[tuple[c:char, n:int]] =
    var i = 0
    while i < s.len:
      var j = i
      while j < s.len and s[i] == s[j]:
        j.inc
      result.add (s[i], j - i)
      i = j
  proc runLengthDecode*(a:seq[tuple[c:char, n:int]]):string =
    result = ""
    for (c, n) in a:
      result.add c.repeat(n)
