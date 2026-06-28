when not declared ATCODER_SPECIAL_JUDGE_HPP:
  const ATCODER_SPECIAL_JUDGE_HPP* = 1
  when declared(DEBUG):
    when DEBUG:
      var strm = newStringStream("")
      proc echo*(s:varargs[string, toStr]) =
        let s = s.join("")
        strm.write(s & "\n")
        system.echo(s.join(""))
  
  template check*(body:untyped):untyped =
    when declared(DEBUG):
      when DEBUG:
        strm.setPosition(0)
        body
    discard
