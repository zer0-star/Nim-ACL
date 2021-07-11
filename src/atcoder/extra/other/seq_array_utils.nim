when not declared ATCODER_SEQ_ARRAY_UTILS:
  const ATCODER_SEQ_ARRAY_UTILS* = 1
  import std/strformat, std/macros, std/sequtils
  template makeSeq*(x:int; init):auto =
    when init is typedesc: newSeq[init](x)
    else: newSeqWith(x, init)

  type SeqType = object
  type ArrayType = object
  let
    Seq* = SeqType()
    Array* = ArrayType()

  template fill*[T](a:var T, init) =
    when a isnot seq and a isnot array:
      a = init
    else:
      for v in a.mitems: fill(v, init)

  template makeArray*(x:int or Slice[int]; init):auto =
    var v:array[x, init.type]
    v

  macro `[]`*(x:ArrayType or SeqType, args:varargs[untyped]):auto =
    var a:string
    if $x == "Seq" and args.len == 1 and args[0].kind != nnkExprColonExpr:
      a = fmt"newSeq[{args[0].repr}]()"
    else:
      let tail = args[^1]
      assert tail.kind == nnkExprColonExpr, "Wrong format of tail"
      let
        args = args[0 .. ^2] & tail[0]
        init = tail[1]
      a = fmt"{init.repr}"
      if $x == "Array":
        for i in countdown(args.len - 1, 0): a = fmt"makeArray({args[i].repr}, {a})"
        a = fmt"{'\n'}block:{'\n'}  var a = {a}{'\n'}  when {init.repr} isnot typedesc:{'\n'}    a.fill({init.repr}){'\n'}  a"
      elif $x == "Seq":
        for i in countdown(args.len - 1, 0): a = fmt"makeSeq({args[i].repr}, {a})"
        a = fmt"{'\n'}block:{'\n'}  {a}"
      else:
        assert(false)
    parseStmt(a)
