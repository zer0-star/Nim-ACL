import macros
macro Please(x): untyped = nnkStmtList.newTree()

Please use Nim-ACL
Please use Nim-ACL
Please use Nim-ACL


when not declared ATCODER_TRIE_HPP:
  const ATCODER_TRIE_HPP* = 1
  import std/algorithm
  type TrieNode*[char_size:static[int]] = object
    nxt: array[char_size, int]
    exist: int
    accept: seq[int]
  
  proc initTrieNode*[char_size:static[int]]():TrieNode[char_size] =
    result.exist = 0
    result.nxt.fill(-1)

  type Trie*[char_size, margin:static[int]] = object
    nodes:seq[TrieNode[char_size]]
    root:int
  
  #using Node = TrieNode< char_size >;

  proc initTrie*[char_size, margin:static[int]]():Trie[char_size, margin] =
    result.root = 0
    result.nodes.add(initTrieNode[char_size]())

  proc update_direct*(self:var Trie, node, id:int) =
    self.nodes[node].accept.add(id)

  proc update_child*(self: var Trie, node, child, id:int) =
    self.nodes[node].exist.inc

  proc add*(self: var Trie, str:string, str_index, node_index, id:int) =
    if str_index == str.len:
      self.update_direct(node_index, id)
    else:
      let c = str[str_index].ord - self.margin
      if self.nodes[node_index].nxt[c] == -1:
        self.nodes[node_index].nxt[c] = self.nodes.len
        self.nodes.add(initTrieNode[self.char_size]());
      self.add(str, str_index + 1, self.nodes[node_index].nxt[c], id)
      self.update_child(node_index, self.nodes[node_index].nxt[c], id)

  proc add*(self: var Trie, str:string, id:int) =
    self.add(str, 0, 0, id)

  proc add*(self: var Trie, str:string) =
    self.add(str, self.nodes[0].exist)

  proc query*(self: Trie, str:string, f:proc(a:int):void, str_index, node_index:int) =
    for idx in self.nodes[node_index].accept: f(idx)
    if str_index == str.len:
      return
    else:
      let c = str[str_index].ord - self.margin
      if self.nodes[node_index].nxt[c] == -1: return
      self.query(str, f, str_index + 1, self.nodes[node_index].nxt[c])

  proc query*(self: Trie, str:string, f:proc(a:int):void) =
    query(str, f, 0, 0)

  proc len*(self: Trie):int =
    return self.nodes[0].exist

#[ include lib/header/chaemon_header ]#
when not declared ATCODER_CHAEMON_HEADER_HPP:
  const ATCODER_CHAEMON_HEADER_HPP* = 1

  {.hints:off warnings:off assertions:on optimization:speed.}
  when declared(DO_CHECK):
    when DO_CHECK:
      static: echo "check is on"
      {.checks:on.}
    else:
      static: echo "check is off"
      {.checks:off.}
  else:
    static: echo "check is on"
    {.checks:on.}

  import std/algorithm as algorithm_lib
  import std/sequtils as sequtils_lib
  import std/macros as macros_lib
  import std/math as math_lib
  import std/sets as sets_lib
  import std/tables as tables_lib
  import std/strutils as strutils_lib
  import std/strformat as strformat_lib
  import std/options as options_lib
  import std/bitops as bitops_lib
  import std/streams as streams_lib

  #[ import atcoder/extra/other/internal_sugar ]#
  when not declared ATCODER_INTERNAL_SUGAR_HPP:
    const ATCODER_INTERNAL_SUGAR_HPP* = 1
    import std/macros
    import std/typetraits
    
    proc checkPragma(ex, prag: var NimNode) =
    #  since (1, 3):
      block:
        if ex.kind == nnkPragmaExpr:
          prag = ex[1]
          if ex[0].kind == nnkPar and ex[0].len == 1:
            ex = ex[0][0]
          else:
            ex = ex[0]
    
    proc createProcType(p, b: NimNode): NimNode {.compileTime.} =
      result = newNimNode(nnkProcTy)
      var
        formalParams = newNimNode(nnkFormalParams).add(b)
        p = p
        prag = newEmptyNode()
    
      checkPragma(p, prag)
    
      case p.kind
      of nnkPar, nnkTupleConstr:
        for i in 0 ..< p.len:
          let ident = p[i]
          var identDefs = newNimNode(nnkIdentDefs)
          case ident.kind
          of nnkExprColonExpr:
            identDefs.add ident[0]
            identDefs.add ident[1]
          else:
            identDefs.add newIdentNode("i" & $i)
            identDefs.add(ident)
          identDefs.add newEmptyNode()
          formalParams.add identDefs
      else:
        var identDefs = newNimNode(nnkIdentDefs)
        identDefs.add newIdentNode("i0")
        identDefs.add(p)
        identDefs.add newEmptyNode()
        formalParams.add identDefs
    
      result.add formalParams
      result.add prag
    
    macro `=>`*(p, b: untyped): untyped =
      ## Syntax sugar for anonymous procedures.
      ## It also supports pragmas.
      var
        params = @[ident"auto"]
        name = newEmptyNode()
        kind = nnkLambda
        pragma = newEmptyNode()
        p = p
    
      checkPragma(p, pragma)
    
      if p.kind == nnkInfix and p[0].kind == nnkIdent and p[0].eqIdent"->":
        params[0] = p[2]
        p = p[1]
    
      checkPragma(p, pragma) # check again after -> transform
  #    since (1, 3):
      block:
  #      if p.kind == nnkCall:
        if p.kind in {nnkCall, nnkObjConstr}:
          # foo(x, y) => x + y
          kind = nnkProcDef
          name = p[0]
          let newP = newNimNode(nnkPar)
          for i in 1..<p.len:
            newP.add(p[i])
          p = newP
    
      case p.kind
      of nnkPar, nnkTupleConstr:
        var untypedBeforeColon = 0
        for i, c in p:
          var identDefs = newNimNode(nnkIdentDefs)
          case c.kind
          of nnkExprColonExpr:
            let t = c[1]
    #        since (1, 3):
            block:
              # + 1 here because of return type in params
              for j in (i - untypedBeforeColon + 1) .. i:
                params[j][1] = t
            untypedBeforeColon = 0
            identDefs.add(c[0])
            identDefs.add(t)
            identDefs.add(newEmptyNode())
          of nnkIdent:
            identDefs.add(c)
            identDefs.add(newIdentNode("auto"))
            identDefs.add(newEmptyNode())
            inc untypedBeforeColon
          of nnkInfix:
            if c[0].kind == nnkIdent and c[0].eqIdent"->":
              var procTy = createProcType(c[1], c[2])
              params[0] = procTy[0][0]
              for i in 1 ..< procTy[0].len:
                params.add(procTy[0][i])
            else:
              error("Expected proc type (->) got (" & c[0].strVal & ").", c)
            break
          else:
            error("Incorrect procedure parameter list.", c)
          params.add(identDefs)
      of nnkIdent:
        var identDefs = newNimNode(nnkIdentDefs)
        identDefs.add(p)
        identDefs.add(ident"auto")
        identDefs.add(newEmptyNode())
        params.add(identDefs)
      else:
        error("Incorrect procedure parameter list.", p)
      result = newProc(body = b, params = params,
                       pragmas = pragma, name = name,
                       procType = kind)
  
    macro `->`*(p, b: untyped): untyped =
      result = createProcType(p, b)
    
    macro dump*(x: untyped): untyped =
      let s = x.toStrLit
      let r = quote do:
        debugEcho `s`, " = ", `x`
      return r
    
    # TODO: consider exporting this in macros.nim
    proc freshIdentNodes(ast: NimNode): NimNode =
      # Replace NimIdent and NimSym by a fresh ident node
      # see also https://github.com/nim-lang/Nim/pull/8531#issuecomment-410436458
      proc inspect(node: NimNode): NimNode =
        case node.kind:
        of nnkIdent, nnkSym:
          result = ident($node)
        of nnkEmpty, nnkLiterals:
          result = node
        else:
          result = node.kind.newTree()
          for child in node:
            result.add inspect(child)
      result = inspect(ast)
    
    macro capture*(locals: varargs[typed], body: untyped): untyped =
      var params = @[newIdentNode("auto")]
      let locals = if locals.len == 1 and locals[0].kind == nnkBracket: locals[0]
                   else: locals
      for arg in locals:
        if arg.strVal == "result":
          error("The variable name cannot be `result`!", arg)
        params.add(newIdentDefs(ident(arg.strVal), freshIdentNodes getTypeInst arg))
      result = newNimNode(nnkCall)
      result.add(newProc(newEmptyNode(), params, body, nnkProcDef))
      for arg in locals: result.add(arg)
    
    #[ import atcoder/extra/other/internal_underscored_calls ]#
    when not declared ATCODER_INTERNAL_UNDERSCORED_CALLS_HPP:
      const ATCODER_INTERNAL_UNDERSCORED_CALLS_HPP* = 1
      import macros
    
      proc underscoredCall(n, arg0: NimNode): NimNode =
        proc underscorePos(n: NimNode): int =
          for i in 1 ..< n.len:
            if n[i].eqIdent("_"): return i
          return 0
    
        if n.kind in nnkCallKinds:
          result = copyNimNode(n)
          result.add n[0]
    
          let u = underscorePos(n)
          for i in 1..u-1: result.add n[i]
          result.add arg0
          for i in u+1..n.len-1: result.add n[i]
        elif n.kind in {nnkAsgn, nnkExprEqExpr}:
          var field = n[0]
          if n[0].kind == nnkDotExpr and n[0][0].eqIdent("_"):
            # handle _.field = ...
            field = n[0][1]
          result = newDotExpr(arg0, field).newAssignment n[1]
        else:
          # handle e.g. 'x.dup(sort)'
          result = newNimNode(nnkCall, n)
          result.add n
          result.add arg0
    
      proc underscoredCalls*(result, calls, arg0: NimNode) =
        expectKind calls, {nnkArgList, nnkStmtList, nnkStmtListExpr}
    
        for call in calls:
          if call.kind in {nnkStmtList, nnkStmtListExpr}:
            underscoredCalls(result, call, arg0)
          else:
            result.add underscoredCall(call, arg0)
      discard
  
    macro dup*[T](arg: T, calls: varargs[untyped]): T =
      result = newNimNode(nnkStmtListExpr, arg)
      let tmp = genSym(nskVar, "dupResult")
      result.add newVarStmt(tmp, arg)
      underscoredCalls(result, calls, tmp)
      result.add tmp
    
    
    proc transLastStmt(n, res, bracketExpr: NimNode): (NimNode, NimNode, NimNode) =
      # Looks for the last statement of the last statement, etc...
      case n.kind
      of nnkIfExpr, nnkIfStmt, nnkTryStmt, nnkCaseStmt:
        result[0] = copyNimTree(n)
        result[1] = copyNimTree(n)
        result[2] = copyNimTree(n)
        for i in ord(n.kind == nnkCaseStmt)..<n.len:
          (result[0][i], result[1][^1], result[2][^1]) = transLastStmt(n[i], res, bracketExpr)
      of nnkStmtList, nnkStmtListExpr, nnkBlockStmt, nnkBlockExpr, nnkWhileStmt,
          nnkForStmt, nnkElifBranch, nnkElse, nnkElifExpr, nnkOfBranch, nnkExceptBranch:
        result[0] = copyNimTree(n)
        result[1] = copyNimTree(n)
        result[2] = copyNimTree(n)
        if n.len >= 1:
          (result[0][^1], result[1][^1], result[2][^1]) = transLastStmt(n[^1], res, bracketExpr)
      of nnkTableConstr:
        result[1] = n[0][0]
        result[2] = n[0][1]
        if bracketExpr.len == 1:
          bracketExpr.add([newCall(bindSym"typeof", newEmptyNode()), newCall(
              bindSym"typeof", newEmptyNode())])
        template adder(res, k, v) = res[k] = v
        result[0] = getAst(adder(res, n[0][0], n[0][1]))
      of nnkCurly:
        result[2] = n[0]
        if bracketExpr.len == 1:
          bracketExpr.add(newCall(bindSym"typeof", newEmptyNode()))
        template adder(res, v) = res.incl(v)
        result[0] = getAst(adder(res, n[0]))
      else:
        result[2] = n
        if bracketExpr.len == 1:
          bracketExpr.add(newCall(bindSym"typeof", newEmptyNode()))
        template adder(res, v) = res.add(v)
        result[0] = getAst(adder(res, n))
    
    macro collect*(init, body: untyped): untyped =
      # analyse the body, find the deepest expression 'it' and replace it via
      # 'result.add it'
      let res = genSym(nskVar, "collectResult")
      expectKind init, {nnkCall, nnkIdent, nnkSym}
      let bracketExpr = newTree(nnkBracketExpr,
        if init.kind == nnkCall: init[0] else: init)
      let (resBody, keyType, valueType) = transLastStmt(body, res, bracketExpr)
      if bracketExpr.len == 3:
        bracketExpr[1][1] = keyType
        bracketExpr[2][1] = valueType
      else:
        bracketExpr[1][1] = valueType
      let call = newTree(nnkCall, bracketExpr)
      if init.kind == nnkCall:
        for i in 1 ..< init.len:
          call.add init[i]
      result = newTree(nnkStmtListExpr, newVarStmt(res, call), resBody, res)
    discard
#  import std/sugar
  #[ import atcoder/extra/other/reader ]#
  when not declared ATCODER_READER_HPP:
    const ATCODER_READER_HPP* = 1
    import streams
    import strutils
    import sequtils
  #  proc scanf*(formatstr: cstring){.header: "<stdio.h>", varargs.}
    #proc getchar(): char {.header: "<stdio.h>", varargs.}
  #  proc nextInt*(): int = scanf("%lld",addr result)
  #  proc nextFloat*(): float = scanf("%lf",addr result)
    proc nextString*(f:auto = stdin): string =
      var get = false
      result = ""
      while true:
        let c = f.readChar
        #doassert c.int != 0
        if c.int > ' '.int:
          get = true
          result.add(c)
        elif get: return
    proc nextInt*(f:auto = stdin): int = parseInt(f.nextString)
    proc nextFloat*(f:auto = stdin): float = parseFloat(f.nextString)
  #  proc nextString*():string = stdin.nextString()
  
    proc toStr*[T](v:T):string =
      proc `$`[T](v:seq[T]):string =
        v.mapIt($it).join(" ")
      return $v
    
    proc print0*(x: varargs[string, toStr]; sep:string):string{.discardable.} =
      result = ""
      for i,v in x:
        if i != 0: addSep(result, sep = sep)
        add(result, v)
      result.add("\n")
      stdout.write result
    
    var print*:proc(x: varargs[string, toStr])
    print = proc(x: varargs[string, toStr]) =
      discard print0(@x, sep = " ")
    discard
  #[ import atcoder/extra/other/sliceutils ]#
  when not declared ATCODER_SLICEUTILS_HPP:
    const ATCODER_SLICEUTILS_HPP* = 1
    proc index*[T](a:openArray[T]):Slice[int] =
      a.low..a.high
    type ReversedSlice[T] = distinct Slice[T]
    type StepSlice[T] = object
      s:Slice[T]
      d:T
    proc rev*[T](p:Slice[T]):ReversedSlice[T] = ReversedSlice[T](p)
    iterator items*(n:int):int = (for i in 0..<n: yield i)
    iterator items*[T](p:ReversedSlice[T]):T =
      if Slice[T](p).b >= Slice[T](p).a:
        var i = Slice[T](p).b
        while true:
          yield i
          if i == Slice[T](p).a:break
          i.dec
    proc `>>`*[T](s:Slice[T], d:T):StepSlice[T] =
      assert d != 0
      StepSlice[T](s:s, d:d)
    proc `<<`*[T](s:Slice[T], d:T):StepSlice[T] =
      assert d != 0
      StepSlice[T](s:s, d: -d)
    proc low*[T](s:StepSlice[T]):T = s.s.a
    proc high*[T](s:StepSlice[T]):T =
      let p = s.s.b - s.s.a
      if p < 0: return s.low - 1
      let d = abs(s.d)
      return s.s.a + (p div d) * d
    iterator items*[T](p:StepSlice[T]):T = 
      assert p.d != 0
      if p.s.a <= p.s.b:
        if p.d > 0:
          var i = p.low
          let h = p.high
          while i <= h:
            yield i
            if i == h: break
            i += p.d
        else:
          var i = p.high
          let l = p.low
          while i >= l:
            yield i
            if i == l: break
            i += p.d
    proc `[]`*[T:SomeInteger, U](a:openArray[U], s:Slice[T]):seq[U] =
      for i in s:result.add(a[i])
    proc `[]=`*[T:SomeInteger, U](a:var openArray[U], s:StepSlice[T], b:openArray[U]) =
      var j = 0
      for i in s:
        a[i] = b[j]
        j.inc
    discard
  #[ import atcoder/extra/other/assignment_operator ]#
  when not declared ATCODER_ASSIGNMENT_OPERATOR_HPP:
    import std/macros
    import std/strformat
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
    discard
  #[ import atcoder/extra/other/inf ]#
  when not declared ATCODER_INF_HPP:
    const ATCODER_INF_HPP* = 1
    template inf*(T:typedesc): untyped = 
      when T is SomeFloat: T(Inf)
      elif T is SomeInteger: T.high div 2
      else:
        static: assert(false)
    proc `∞`*(T:typedesc):T = T.inf
    proc `*!`*[T:SomeInteger](a, b:T):T =
      if a == T(0) or b == T(0): return T(0)
      var sgn = T(1)
      if a < T(0): sgn = -sgn
      if b < T(0): sgn = -sgn
      let a = abs(a)
      let b = abs(b)
      if b > T.inf div a: result = T.inf
      else: result = min(T.inf, a * b)
      result *= sgn
    proc `+!`*[T:SomeInteger](a, b:T):T =
      result = a + b
      result = min(T.inf, result)
      result = max(-T.inf, result)
    proc `-!`*[T:SomeInteger](a, b:T):T =
      result = a - b
      result = min(T.inf, result)
      result = max(-T.inf, result)
    discard
  #[ import atcoder/extra/other/warlus_operator ]#
  when not declared ATCODER_CHAEMON_WARLUS_OPERATOR_HPP:
    const ATCODER_CHAEMON_WARLUS_OPERATOR_HPP* = 1
    import macros
    proc discardableId*[T](x: T): T {.discardable.} = x
  
    proc warlusImpl(x, y:NimNode):NimNode =
      return quote do:
        when declaredInScope(`x`):
          `x` = `y`
        else:
          var `x` = `y`
  
    macro `:=`*(x, y: untyped): untyped =
      result = newStmtList()
      if x.kind == nnkCurly:
        for i,xi in x: result.add warlusImpl(xi, y)
      elif x.kind == nnkPar:
        for i,xi in x: result.add warlusImpl(xi, y[i])
      else:
        result.add warlusImpl(x, y)
        result.add quote do:
          discardableId(`x`)
    discard
  #[ import atcoder/extra/other/seq_array_utils ]#
  when not declared ATCODER_SEQ_ARRAY_UTILS:
    const ATCODER_SEQ_ARRAY_UTILS* = 1
    import std/strformat
    import std/macros
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
    discard
  #[ include atcoder/extra/other/debug ]#
  when not declared ATCODER_DEBUG_HPP:
    const ATCODER_DEBUG_HPP* = 1
    import macros
    import strformat
    import terminal
  
    macro debugImpl*(n:varargs[untyped]): untyped =
      #  var a = "stderr.write "
      var a = ""
      a.add "setForegroundColor fgYellow\n"
      a.add "stdout.write "
  #    a.add "stderr.write "
      for i,x in n:
        if x.kind == nnkStrLit:
          a &= fmt"{x.repr}  "
        else:
          a &= fmt""" "{x.repr} = ", {x.repr} """
        if i < n.len - 1:
          a.add(""", ", ",""")
      a.add(", \"\\n\"")
      a.add "\n"
      a.add "resetAttributes()"
      parseStmt(a)
    template debug*(n: varargs[untyped]): untyped =
      const EVAL =
        when declared DEBUG: DEBUG
        else: false
      when EVAL:
        debugImpl(n)
    discard
  #[ import atcoder/extra/other/reference ]#
  when not declared ATCODER_REFERENCE_HPP:
    const ATCODER_REFERENCE_HPP* = 1
    import std/macros
    import std/strformat
  
    template byaddr*(lhs, typ, ex) =
      when typ is typeof(nil):
        let tmp = addr(ex)
      else:
        let tmp: ptr typ = addr(ex)
      template lhs: untyped = tmp[]
  
    macro `=&`*(lhs, rhs:untyped) =
      parseStmt(fmt"""byaddr({lhs.repr}, {rhs.repr}.type, {rhs.repr})""")
    discard
  #[ import atcoder/extra/other/floatutils ]#
  when not declared ATCODER_FLOAT_UTILS_HPP:
    const ATCODER_FLOAT_UTILS_HPP* = 1
    import std/math as math_lib_floatutils
    import std/strutils
    #[ import atcoder/element_concepts ]#
    when not declared ATCODER_ELEMENT_CONCEPTS_HPP:
      const ATCODER_ELEMENT_CONCEPTS_HPP* = 1
      proc inv*[T:SomeFloat](a:T):auto = T(1) / a
      proc init*(self:typedesc[SomeFloat], a:SomeNumber):auto = self(a)
      type AdditiveGroupElem* = concept x, y, type T
        x + y
        x - y
        -x
        T(0)
      type MultiplicativeGroupElem* = concept x, y, type T
        x * y
        x / y
    #    x.inv()
        T(1)
      type RingElem* = concept x, y, type T
        x + y
        x - y
        -x
        x * y
        T(0)
        T(1)
      type FieldElem* = concept x, y, type T
        x + y
        x - y
        x * y
        x / y
        -x
    #    x.inv()
        T(0)
        T(1)
      type FiniteFieldElem* = concept x, type T
        T is FieldElem
        T.mod
        T.mod() is int
        x.pow(1000000)
      type hasInf* = concept x, type T
        T(Inf)
      discard
    #[ import atcoder/extra/other/static_var ]#
    when not declared ATCODER_STATIC_VAR_HPP:
      const ATCODER_STATIC_VAR_HPP* = 1
      import std/macros
      import std/strformat
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
      discard
    proc getParameters*(Real:typedesc):ptr[tuple[n:int, pi, eps, inf:Real]] =
      var p {.global.}:tuple[n:int, pi, eps, inf:Real]
      return p.addr
  
    converter floatConverter*(a:SomeInteger):float = a.float
    converter float64Converter*(a:SomeInteger):float64 = a.float64
    converter float32Converter*(a:SomeInteger):float32 = a.float32
    converter floatConverter*(a:string):float = a.parseFloat
    converter float64Converter*(a:string):float64 = a.parseFloat.float64
    converter float32Converter*(a:string):float32 = a.parseFloat.float32
  
    staticVar FieldElem:
      pi:U.type
      eps:U.type
      inf:U.type
  
    proc getPi*(Real:typedesc):Real = Real.getParameters()[].pi
    proc getEPS*(Real:typedesc):Real = Real.getParameters()[].eps
    proc getINF*(Real:typedesc):Real = Real.getParameters()[].inf
    proc setEPS*(Real:typedesc, x:Real) = Real.getParameters()[].eps = x
  
    proc valid_range*[Real](l, r:Real):bool =
      # assert(l <= r)
      var (l, r) = (l, r)
      if l > r: swap(l, r)
      let d = r - l
      let eps = Real$.eps
      if d < eps: return true
      if l <= Real(0) and Real(0) <= r: return false
      return d < eps * min(abs(l), abs(r))
  
    template initPrec*(Real:typedesc) =
      Real$.pi = PI.Real
      Real$.inf = Inf.Real
      when Real is float or Real is float64:
        Real$.eps = 1e-9.Real
      elif Real is float32:
        Real$.eps = 1e-9.Real
      # float comp
      # TODO: relative error
      proc `=~`*(a,b:Real):bool = abs(a - b) < Real$.eps
      proc `!=~`*(a,b:Real):bool = abs(a - b) > Real$.eps
      proc `<~`*(a,b:Real):bool = a + Real$.eps < b
      proc `>~`*(a,b:Real):bool = a > b + Real$.eps
      proc `<=~`*(a,b:Real):bool = a < b + Real$.eps
      proc `>=~`*(a,b:Real):bool = a + Real$.eps > b
  
    # for OMC
    proc estimateRational*[Real](x:Real, n:int) =
      var m = Real$.inf
      var q = 1
      while q <= n:
        let p = round(x * q.Real)
        let d = abs(p / q.Real - x)
        if d < m:
          m = d
          echo "found: ", p, "/", q, "   ", "error: ", d
        q.inc
      return
  
    float.initPrec()
  #  float64.initPrec()
    float32.initPrec()
    discard
  #[ import atcoder/extra/other/zip ]#
  when not declared ATCODER_ZIP_HPP:
    const ATCODER_ZIP_HPP* = 1
    import macros
  
    macro zip*(v:varargs[untyped]):untyped =
      result = newStmtList()
      var par = newPar()
      for i,a in v:
        var ts = newNimNode(nnkTypeSection)
        par.add(ident("T" & $i))
        ts.add(newNimNode(nnkTypeDef).add(
          ident("T" & $i),
          newEmptyNode(),
          newDotExpr(newNimNode(nnkBracketExpr).add(a, newIntLitNode(0)), ident("type"))
        ))
        result.add ts
      var varSection = newNimNode(nnkVarSection)
      varSection.add newIdentDefs(ident("a"), newEmptyNode(), newCall(
        newNimNode(nnkBracketExpr).add(
          ident("newSeq"), 
          par
        ), 
        ident("n")
      ))
      result.add newNimNode(nnkLetSection).add(newIdentDefs(ident("n"), newEmptyNode(), 
        newDotExpr(v[0] , ident("len"))
      ))
      result.add(varSection)
    
      var forStmt = newNimNode(nnkForStmt).add(ident("i")).add(
        newNimNode(nnkInfix).add(ident("..<")).add(newIntLitNode(0), ident("n"))
      )
      var fs = newStmtList()
      for j,a in v:
        fs.add newAssignment(
          newNimNode(nnkBracketExpr).add(
            newNimNode(nnkBracketExpr).add(
              ident("a"), 
              ident("i")
            ), 
            newIntLitNode(j)), 
          newNimNode(nnkBracketExpr).add(
            a, 
            ident("i")
          )
        )
      forStmt.add fs
      result.add(forStmt)
      result.add(ident("a"))
      result = newBlockStmt(newEmptyNode(), result)
    
    macro unzip*(n:int, p:tuple):untyped = 
      result = newStmtList()
      result.add(newNimNode(nnkLetSection).add(newIdentDefs(ident("n"), newEmptyNode(), n)))
      for i,a in p:
        var a = newPar(a)
        var t = newCall(
          newNimNode(nnkBracketExpr).add(
            ident("newSeq"), 
            newDotExpr(a, ident("type"))
          ), 
          ident("n")
        )
        var varSection = newNimNode(nnkVarSection).add(
          newIdentDefs(ident("a" & $i), newEmptyNode(), t), 
        )
        result.add(varSection)
      var forStmt = newNimNode(nnkForStmt).add(ident("i"))
      var rangeDef = newNimNode(nnkInfix).add(ident("..<")).add(newIntLitNode(0), ident("n"))
      forStmt.add(rangeDef)
      var fs = newStmtList()
      for i,a in p:
        fs.add newAssignment(
          newNimNode(nnkBracketExpr).add(
            ident("a" & $i), 
            ident("i")), 
          a
        )
      forStmt.add fs
      result.add(forStmt)
      var par = newPar()
      for i, a in p:
        par.add(ident("a" & $i))
      result.add(par)
      result = newBlockStmt(newEmptyNode(), result)
  
    discard
  #[ import atcoder/extra/other/solve_proc ]#
  when not declared ATCODER_SOLVEPROC_HPP:
    const ATCODER_SOLVEPROC_HPP* = 1
    import std/macros
    import std/strformat
    import std/algorithm
    import std/sequtils
    import std/streams
    import std/strutils
    import math
  
    proc compare_answer_string*(s, t:string, error:float = NaN):bool =
      if error.classify == fcNaN:
        return s == t
      else:
        var
          s = s.split("\n")
          t = t.split("\n")
        if s.len != t.len: return false
        for i in 0 ..< s.len:
          var s = s[i].split()
          var t = t[i].split()
          if s.len != t.len: return false
          for j in 0 ..< s.len:
            if s[j].len == 0:
              if t[j].len != 0: return false
            elif t[j].len == 0:
              return false
            else:
              var fs = s[j].parseFloat
              var ft = t[j].parseFloat
              if abs(fs - ft) > error and abs(fs - ft) > min(abs(ft), abs(fs)) * error: return false
        return true
      doAssert false
  
    proc mainBodyHeader():NimNode =
  #    let macro_def = "(for s in {x.repr}: (result &= $s;(when output_stdout: stdout.write $s)));(result &= \"\\n\";when output_stdout: stdout.write \"\\n\")"
      result = newStmtList()
      result.add quote("@@") do:
        mixin echo
        result = ""
        var resultPointer = result.addr
        proc echo(x:varargs[string, `$`]) =
          for s in x:
            resultPointer[] &= $s
            when output_stdout: stdout.write $s
          resultPointer[] &= "\n"
          when output_stdout: stdout.write "\n"
  
    macro solveProc*(head, body:untyped):untyped =
      var prev_type:NimNode
      var params:seq[NimNode]
      for i in countdown(head.len - 1, 1):
        var identDefs = newNimNode(nnkIdentDefs)
        if head[i].kind == nnkExprColonExpr:
          identDefs.add(head[i][0])
          prev_type = head[i][1]
        elif head[i].kind == nnkIdent:
          identDefs.add(head[i])
        identDefs.add(prev_type)
        identDefs.add(newEmptyNode())
        params.add(identDefs)
      params.add(ident"auto")
      params.reverse()
      var callparams:seq[NimNode]
      for i in 1..<params.len:
        callparams.add(params[i][0])
  #    var mainBody, naiveBody = mainBodyHeader()
      var mainBody, checkBody, naiveBody, testBody, generateBody = newStmtList()
      var hasNaive, hasCheck, hasTest, hasGenerate = false
      for b in body:
        if b.kind == nnkCall:
          if b[0] == ident"Check":
            hasCheck = true
            var checkStmt = if b.len == 2: b[1] else: b[2]
            var strmName = if b.len == 2: ident("strm") else: b[1]
            checkBody.add(newNimNode(nnkWhenStmt).add(
              newNimNode(nnkElifBranch).add(ident"DO_CHECK").add(
                newBlockStmt(newEmptyNode(), 
                  newStmtList().add(
                    quote do:
                      var `strmName` = newStringStream(resultOutput)
                  ).add(checkStmt)
            ))))
          elif b[0] == ident"Naive":
            hasNaive = true
            naiveBody.add b[1]
          elif b[0] == ident"Test":
            hasTest = true
            testBody.add b[1]
          elif b[0] == ident"Generate":
            hasGenerate = true
            generateBody.add b[1]
          else:
            mainBody.add b
        else:
          mainBody.add b
      mainBody = newStmtList().add(mainBodyHeader()).add(mainBody)
      #if hasCheck:
      #  mainBody.add(checkBody)
      result = newStmtList()
      let procName = head[0]
      var discardablePragma = newNimNode(nnkPragma).add(ident("discardable"))
      var mainParams = params
      mainParams[0] = ident"string"
  #    var identDefsSub = newNimNode(nnkIdentDefs).add(ident"output_stdout").add(newNimNode(nnkBracketExpr).add(ident"static").add(ident"bool")).add(ident"true")
      var identDefs = newNimNode(nnkIdentDefs).add(ident"output_stdout").add(newNimNode(nnkBracketExpr).add(ident"static").add(ident"bool")).add(ident"true")
      proc copy(a:seq[NimNode]):seq[NimNode] = a.mapIt(it.copy)
  #    var identDefs = newNimNode(nnkIdentDefs).add(ident"output_stdout").add(newNimNode(nnkBracketExpr).add(ident"static").add(ident"bool")).add(newEmptyNode())
      mainParams.add(identDefs)
      #var mainProcDef = newNimNode(nnkProcDef).add(ident"solve").add(newEmptyNode()).add(newEmptyNode()).add(newNimNode(nnkFormalParams).add(mainParams.copy())).add(discardablePragma).add(newEmptyNode()).add(newEmptyNode())
      #result.add(mainProcDef)
      if hasCheck:
        result.add(quote do:
          type CheckResult {.inject.} = ref object of Exception
            output, err:string
          template check(b:untyped) =
            if not b:
              raise CheckResult(err: b.astToStr, output: resultOutput)
        )
      if hasNaive:
        var naiveProcDef = newNimNode(nnkProcDef).add(ident"solve_naive").add(newEmptyNode()).add(newEmptyNode()).add(newNimNode(nnkFormalParams).add(mainParams.copy())).add(discardablePragma).add(newEmptyNode()).add(newEmptyNode())
        result.add(naiveProcDef)
  
      var naiveParams = mainParams.copy()
      #result.add newProc(name = ident(procName), params = mainParams.copy(), body = mainBody, pragmas = discardablePragma)
      
      var mainProcImpl =
        newStmtList().add(parseStmt("mixin echo")).add quote do:
        proc solve():string =
          `mainBody`
        var resultOutput {.inject.} = solve()
      var mainTemplateBody = newStmtList().add quote do:
        `mainProcImpl`
      if hasCheck:
        mainTemplateBody.add checkBody
      mainTemplateBody.add quote do:
        resultOutput
      var mainTemplate = quote do:
        proc `procName`():string {.discardable.} =
          `mainTemplateBody`
      mainTemplate[3].add mainParams[1..^1].copy()
      result.add mainTemplate
  
      if hasNaive:
        let naiveProcName = $procName & "naive"
        naiveBody = mainBodyHeader().add(newBlockStmt(newEmptyNode(), naiveBody))
        result.add newProc(name = ident(naiveProcName), params = naiveParams, body = naiveBody, pragmas = discardablePragma)
        var test_body = newStmtList()
        var var_names = newSeq[string]()
        for procName in [$procName, $procName & "_naive"]:
          let var_name = "v" & procName
          var_names.add(var_name)
          var l = newNimNode(nnkCall).add(ident(procName))
          for c in callparams: l.add(c)
          l.add(ident"false")
          test_body.add(
            newNimNode(nnkLetSection).add(
              newNimNode(nnkIdentDefs).add(ident(var_name)).add(newEmptyNode()).add(l)
            ))
        var test_params = params
        var vars = ""
        for i in 1..<params.len:
          let p = params[i][0]
          vars &= &"  {p.repr} = {{{p.repr}}}\\n"
        test_params[0] = ident"bool"
  
        var identDefs = newNimNode(nnkIdentDefs).add(ident"error").add(ident"float").add(ident("NaN"))
        test_params.add identDefs
        test_body.add parseStmt(&"if not compare_answer_string(vsolve, vsolve_naive, error): echo &\"test failed for\\n{vars}\", \"[solve]\\n\", vsolve, \"[solve_naive]\\n\", vsolve_naive;doAssert false")
        result.add newProc(name = ident"test", params = test_params, body = test_body, pragmas = discardablePragma)
      elif hasCheck:
        var test_body_sub = newStmtList()
        var var_names = newSeq[string]()
        for procName in [$procName]:
          let var_name = "v" & procName
          var_names.add(var_name)
          var l = newNimNode(nnkCall).add(ident(procName))
          for c in callparams: l.add(c)
          l.add(ident"false")
          test_body_sub.add(
            newNimNode(nnkLetSection).add(
              newNimNode(nnkIdentDefs).add(ident(var_name)).add(newEmptyNode()).add(l)
            ))
        var test_params = params
        var vars = ""
        for i in 1..<params.len:
          let p = params[i][0]
          vars &= &"  {p.repr} = {{{p.repr}}}\\n"
        test_params[0] = ident"bool"
        var test_body = newStmtList()
        var d = &"try:\n  {test_body_sub.repr.strip}\nexcept CheckResult as e:\n  echo &\"check failed for\\n{vars}\", \"[failed statement]\\n\", e.err.strip, \"\\n[output]\\n\", e.output;doAssert false"
        test_body.add parseStmt(d)
        result.add newProc(name = ident"test", params = test_params, body = test_body, pragmas = discardablePragma)
  
      if hasGenerate:
        discard
      if hasTest:
        discard
      #echo result.repr
    discard

  when declared USE_DEFAULT_TABLE:
    when USE_DEFAULT_TABLE:
      proc `[]`[A, B](self: var Table[A, B], key: A): var B =
        discard self.hasKeyOrPut(key, B.default)
        tables_lib.`[]`(self, key)

  # converter toBool[T:ref object](x:T):bool = x != nil
  # converter toBool[T](x:T):bool = x != T(0)
  # misc
  proc `<`[T](a, b:seq[T]):bool =
    for i in 0 ..< min(a.len, b.len):
      if a[i] < b[i]: return true
      elif a[i] > b[i]: return false
    if a.len < b.len: return true
    else: return false

  proc ceilDiv*[T:SomeInteger](a, b:T):T =
    assert b != 0
    if b < 0: return ceilDiv(-a, -b)
    result = a.floorDiv(b)
    if a mod b != 0: result.inc

  template `/^`*[T:SomeInteger](a, b:T):T = ceilDiv(a, b)
  discard

block:
  var
    trie = initTrie[26, 'a'.ord]()
  let
    S = nextString()
    M = nextInt()
    P = Seq[M: nextString()]
    W = Seq[M: nextInt()]
  for i in M: trie.add(P[i])
  var dp = Seq[S.len + 1]
  for i in S.len:
    proc update(idx:int) =
      dp[i + P[idx].len] = max(dp[i + P[idx].len], dp[i] + W[idx]);
    trie.query(S, update, i, 0)
    dp[i + 1] = max(dp[i + 1], dp[i])
  echo dp[^1]
