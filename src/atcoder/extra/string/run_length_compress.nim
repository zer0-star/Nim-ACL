when not declared ATCODER_RUN_LENGTH_COMPRESS_HPP:
  const ATCODER_RUN_LENGTH_COMPRESS_HPP* = 1
  import strutils
  proc encode*(s:string):seq[tuple[c:char, n:int]] =
    var i = 0
    while i < s.len:
      var j = i
      while j < s.len and s[i] == s[j]: j.inc
      result.add (s[i], j - i)
      i = j

  proc decode*(a:seq[tuple[c:char, n:int]]):string =
    for (c, n) in a:
      result.add c.repeat(n)

  proc encode*[T](s:seq[T]):seq[tuple[c:T, n:int]] =
    var i = 0
    while i < s.len:
      var j = i
      while j < s.len and s[i] == s[j]: j.inc
      result.add (s[i], j - i)
      i = j

  proc decode*[T](a:seq[tuple[c:T, n:int]]):seq[T] =
    for (c, n) in a:
      result.add c.repeat(n)
