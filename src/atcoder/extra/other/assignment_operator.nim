when not declared ATCODER_ASSIGNMENT_OPERATOR_HPP:
  import std/macros, std/strformat
  const ATCODER_ASSIGNMENT_OPERATOR_HPP* = 1
  template `>?=`*(x,y:typed):void = x.max= y
  template `<?=`*(x,y:typed):void = x.min= y
  proc `//`*[T](x,y:T):T = x div y
  proc `%`*[T](x,y:T):T = x mod y
  macro generateAssignmentOperator*(ops:varargs[untyped]) =
    var strBody = ""
    for op in ops:
      let op = op.repr
      var op_raw = op
      if op_raw[0] == '`':
        op_raw = op_raw[1..^2]
      strBody &= fmt"""proc `{op_raw}=`*[S, T](a:var S, b:T):auto {{.inline discardable.}} = (mixin {op};a = `{op_raw}`(a, b);return a){'\n'}"""
    parseStmt(strBody)
  generateAssignmentOperator(`mod`, `div`, `and`, `or`, `xor`, `shr`, `shl`, `<<`, `>>`, max, min, `%`, `//`, `&`, `|`, `^`)
