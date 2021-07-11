when not declared ATCODER_STATIC_VAR_HPP:
  const ATCODER_STATIC_VAR_HPP* = 1
  import std/macros, std/strformat
  macro staticVar*(T:typedesc, body: untyped) =
    var s = ""
    for n in body:
      let name = n[0]
      let t = n[1]
      let t2 = fmt"{t.repr[1..<t.repr.len]}"
      s &= fmt"""{'\n'}proc get_global_addr_of_{name.repr}*[U:{T.repr}](self:typedesc[U] or U):ptr[{t2}] ={'\n'}  when self is typedesc:{'\n'}    var a {{.global.}}:{t2}.type{'\n'}    a.addr{'\n'}  else:{'\n'}    get_global_addr_of_{name.repr}(self.type){'\n'}
"""
    parseStmt(s)
  
  macro `$.`*(t, name:untyped):untyped =
    let s = fmt"{t.repr}.get_global_addr_of_{name.repr}()[]"
    parseStmt(s)
