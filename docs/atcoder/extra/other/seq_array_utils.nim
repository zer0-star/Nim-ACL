when not declared ATCODER_SEQ_ARRAY_UTILS:
  const ATCODER_SEQ_ARRAY_UTILS* = 1
  import std/strformat, std/macros, std/strutils, std/sequtils
  type SeqType = object
  type ArrayType = object
  let
    Seq* = SeqType()
    Array* = ArrayType()

  template fill*[T](a:var T, init:untyped) =
    when T is init.type:
      a = init
    else:
      for x in a.mitems: fill(x, init)

  template makeSeq*(x:int; init):auto =
    when init is typedesc: newSeq[init](x)
    else:
      var a = newSeq[typeof(init, typeofProc)](x)
      a.fill(init)
      a

  template makeArray*(x:int or Slice[int]; init):auto =
    var v:array[x, init.type]
    v

  macro `[]`*(x:ArrayType or SeqType, args:varargs[untyped]):auto =
    var a:string
    if $x == "Seq" and args.len == 1 and args[0].kind != nnkExprColonExpr:
      #a = fmt"newSeq[{args[0].repr}]()"
      a = fmt"block:{'\n'}  var a: seq[{args[0].repr}];a"
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

  macro `@`*(n: untyped, a:untyped):auto =
    if n.kind == nnkBracket:
      var v: seq[string]
      for n in n:
        v.add n.repr
      var s = v.join(",")
      result = parseStmt(fmt"Seq[{s}: {a.repr}]")
    else:
      result = quote do:
        Seq[`n`: `a`]
  proc `@`*[T](a:typedesc[T]):seq[T] =
    Seq[a]
  macro `@@`*(n: untyped, a:untyped):auto =
    if n.kind == nnkBracket:
      var v: seq[string]
      for n in n:
        v.add n.repr
      var s = v.join(",")
      result = parseStmt(fmt"Array[{s}: {a.repr}]")
    else:
      result = quote do:
        Array[`n`: `a`]
