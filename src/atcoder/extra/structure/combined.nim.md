---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links:
    - https://github.com/nim-lang/Nim/pull/8531#issuecomment-410436458
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.7/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.7/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "import macros\nmacro Please(x): untyped = nnkStmtList.newTree()\n\nPlease\
    \ use Nim-ACL\nPlease use Nim-ACL\nPlease use Nim-ACL\n\n\nwhen not declared ATCODER_TRIE_HPP:\n\
    \  const ATCODER_TRIE_HPP* = 1\n  import std/algorithm\n  type TrieNode*[char_size:static[int]]\
    \ = object\n    nxt: array[char_size, int]\n    exist: int\n    accept: seq[int]\n\
    \  \n  proc initTrieNode*[char_size:static[int]]():TrieNode[char_size] =\n   \
    \ result.exist = 0\n    result.nxt.fill(-1)\n\n  type Trie*[char_size, margin:static[int]]\
    \ = object\n    nodes:seq[TrieNode[char_size]]\n    root:int\n  \n  #using Node\
    \ = TrieNode< char_size >;\n\n  proc initTrie*[char_size, margin:static[int]]():Trie[char_size,\
    \ margin] =\n    result.root = 0\n    result.nodes.add(initTrieNode[char_size]())\n\
    \n  proc update_direct*(self:var Trie, node, id:int) =\n    self.nodes[node].accept.add(id)\n\
    \n  proc update_child*(self: var Trie, node, child, id:int) =\n    self.nodes[node].exist.inc\n\
    \n  proc add*(self: var Trie, str:string, str_index, node_index, id:int) =\n \
    \   if str_index == str.len:\n      self.update_direct(node_index, id)\n    else:\n\
    \      let c = str[str_index].ord - self.margin\n      if self.nodes[node_index].nxt[c]\
    \ == -1:\n        self.nodes[node_index].nxt[c] = self.nodes.len\n        self.nodes.add(initTrieNode[self.char_size]());\n\
    \      self.add(str, str_index + 1, self.nodes[node_index].nxt[c], id)\n     \
    \ self.update_child(node_index, self.nodes[node_index].nxt[c], id)\n\n  proc add*(self:\
    \ var Trie, str:string, id:int) =\n    self.add(str, 0, 0, id)\n\n  proc add*(self:\
    \ var Trie, str:string) =\n    self.add(str, self.nodes[0].exist)\n\n  proc query*(self:\
    \ Trie, str:string, f:proc(a:int):void, str_index, node_index:int) =\n    for\
    \ idx in self.nodes[node_index].accept: f(idx)\n    if str_index == str.len:\n\
    \      return\n    else:\n      let c = str[str_index].ord - self.margin\n   \
    \   if self.nodes[node_index].nxt[c] == -1: return\n      self.query(str, f, str_index\
    \ + 1, self.nodes[node_index].nxt[c])\n\n  proc query*(self: Trie, str:string,\
    \ f:proc(a:int):void) =\n    query(str, f, 0, 0)\n\n  proc len*(self: Trie):int\
    \ =\n    return self.nodes[0].exist\n\n#[ include lib/header/chaemon_header ]#\n\
    when not declared ATCODER_CHAEMON_HEADER_HPP:\n  const ATCODER_CHAEMON_HEADER_HPP*\
    \ = 1\n\n  {.hints:off warnings:off assertions:on optimization:speed.}\n  when\
    \ declared(DO_CHECK):\n    when DO_CHECK:\n      static: echo \"check is on\"\n\
    \      {.checks:on.}\n    else:\n      static: echo \"check is off\"\n      {.checks:off.}\n\
    \  else:\n    static: echo \"check is on\"\n    {.checks:on.}\n\n  import std/algorithm\
    \ as algorithm_lib\n  import std/sequtils as sequtils_lib\n  import std/macros\
    \ as macros_lib\n  import std/math as math_lib\n  import std/sets as sets_lib\n\
    \  import std/tables as tables_lib\n  import std/strutils as strutils_lib\n  import\
    \ std/strformat as strformat_lib\n  import std/options as options_lib\n  import\
    \ std/bitops as bitops_lib\n  import std/streams as streams_lib\n\n  #[ import\
    \ atcoder/extra/other/internal_sugar ]#\n  when not declared ATCODER_INTERNAL_SUGAR_HPP:\n\
    \    const ATCODER_INTERNAL_SUGAR_HPP* = 1\n    import std/macros\n    import\
    \ std/typetraits\n    \n    proc checkPragma(ex, prag: var NimNode) =\n    # \
    \ since (1, 3):\n      block:\n        if ex.kind == nnkPragmaExpr:\n        \
    \  prag = ex[1]\n          if ex[0].kind == nnkPar and ex[0].len == 1:\n     \
    \       ex = ex[0][0]\n          else:\n            ex = ex[0]\n    \n    proc\
    \ createProcType(p, b: NimNode): NimNode {.compileTime.} =\n      result = newNimNode(nnkProcTy)\n\
    \      var\n        formalParams = newNimNode(nnkFormalParams).add(b)\n      \
    \  p = p\n        prag = newEmptyNode()\n    \n      checkPragma(p, prag)\n  \
    \  \n      case p.kind\n      of nnkPar, nnkTupleConstr:\n        for i in 0 ..<\
    \ p.len:\n          let ident = p[i]\n          var identDefs = newNimNode(nnkIdentDefs)\n\
    \          case ident.kind\n          of nnkExprColonExpr:\n            identDefs.add\
    \ ident[0]\n            identDefs.add ident[1]\n          else:\n            identDefs.add\
    \ newIdentNode(\"i\" & $i)\n            identDefs.add(ident)\n          identDefs.add\
    \ newEmptyNode()\n          formalParams.add identDefs\n      else:\n        var\
    \ identDefs = newNimNode(nnkIdentDefs)\n        identDefs.add newIdentNode(\"\
    i0\")\n        identDefs.add(p)\n        identDefs.add newEmptyNode()\n      \
    \  formalParams.add identDefs\n    \n      result.add formalParams\n      result.add\
    \ prag\n    \n    macro `=>`*(p, b: untyped): untyped =\n      ## Syntax sugar\
    \ for anonymous procedures.\n      ## It also supports pragmas.\n      var\n \
    \       params = @[ident\"auto\"]\n        name = newEmptyNode()\n        kind\
    \ = nnkLambda\n        pragma = newEmptyNode()\n        p = p\n    \n      checkPragma(p,\
    \ pragma)\n    \n      if p.kind == nnkInfix and p[0].kind == nnkIdent and p[0].eqIdent\"\
    ->\":\n        params[0] = p[2]\n        p = p[1]\n    \n      checkPragma(p,\
    \ pragma) # check again after -> transform\n  #    since (1, 3):\n      block:\n\
    \  #      if p.kind == nnkCall:\n        if p.kind in {nnkCall, nnkObjConstr}:\n\
    \          # foo(x, y) => x + y\n          kind = nnkProcDef\n          name =\
    \ p[0]\n          let newP = newNimNode(nnkPar)\n          for i in 1..<p.len:\n\
    \            newP.add(p[i])\n          p = newP\n    \n      case p.kind\n   \
    \   of nnkPar, nnkTupleConstr:\n        var untypedBeforeColon = 0\n        for\
    \ i, c in p:\n          var identDefs = newNimNode(nnkIdentDefs)\n          case\
    \ c.kind\n          of nnkExprColonExpr:\n            let t = c[1]\n    #    \
    \    since (1, 3):\n            block:\n              # + 1 here because of return\
    \ type in params\n              for j in (i - untypedBeforeColon + 1) .. i:\n\
    \                params[j][1] = t\n            untypedBeforeColon = 0\n      \
    \      identDefs.add(c[0])\n            identDefs.add(t)\n            identDefs.add(newEmptyNode())\n\
    \          of nnkIdent:\n            identDefs.add(c)\n            identDefs.add(newIdentNode(\"\
    auto\"))\n            identDefs.add(newEmptyNode())\n            inc untypedBeforeColon\n\
    \          of nnkInfix:\n            if c[0].kind == nnkIdent and c[0].eqIdent\"\
    ->\":\n              var procTy = createProcType(c[1], c[2])\n              params[0]\
    \ = procTy[0][0]\n              for i in 1 ..< procTy[0].len:\n              \
    \  params.add(procTy[0][i])\n            else:\n              error(\"Expected\
    \ proc type (->) got (\" & c[0].strVal & \").\", c)\n            break\n     \
    \     else:\n            error(\"Incorrect procedure parameter list.\", c)\n \
    \         params.add(identDefs)\n      of nnkIdent:\n        var identDefs = newNimNode(nnkIdentDefs)\n\
    \        identDefs.add(p)\n        identDefs.add(ident\"auto\")\n        identDefs.add(newEmptyNode())\n\
    \        params.add(identDefs)\n      else:\n        error(\"Incorrect procedure\
    \ parameter list.\", p)\n      result = newProc(body = b, params = params,\n \
    \                      pragmas = pragma, name = name,\n                      \
    \ procType = kind)\n  \n    macro `->`*(p, b: untyped): untyped =\n      result\
    \ = createProcType(p, b)\n    \n    macro dump*(x: untyped): untyped =\n     \
    \ let s = x.toStrLit\n      let r = quote do:\n        debugEcho `s`, \" = \"\
    , `x`\n      return r\n    \n    # TODO: consider exporting this in macros.nim\n\
    \    proc freshIdentNodes(ast: NimNode): NimNode =\n      # Replace NimIdent and\
    \ NimSym by a fresh ident node\n      # see also https://github.com/nim-lang/Nim/pull/8531#issuecomment-410436458\n\
    \      proc inspect(node: NimNode): NimNode =\n        case node.kind:\n     \
    \   of nnkIdent, nnkSym:\n          result = ident($node)\n        of nnkEmpty,\
    \ nnkLiterals:\n          result = node\n        else:\n          result = node.kind.newTree()\n\
    \          for child in node:\n            result.add inspect(child)\n      result\
    \ = inspect(ast)\n    \n    macro capture*(locals: varargs[typed], body: untyped):\
    \ untyped =\n      var params = @[newIdentNode(\"auto\")]\n      let locals =\
    \ if locals.len == 1 and locals[0].kind == nnkBracket: locals[0]\n           \
    \        else: locals\n      for arg in locals:\n        if arg.strVal == \"result\"\
    :\n          error(\"The variable name cannot be `result`!\", arg)\n        params.add(newIdentDefs(ident(arg.strVal),\
    \ freshIdentNodes getTypeInst arg))\n      result = newNimNode(nnkCall)\n    \
    \  result.add(newProc(newEmptyNode(), params, body, nnkProcDef))\n      for arg\
    \ in locals: result.add(arg)\n    \n    #[ import atcoder/extra/other/internal_underscored_calls\
    \ ]#\n    when not declared ATCODER_INTERNAL_UNDERSCORED_CALLS_HPP:\n      const\
    \ ATCODER_INTERNAL_UNDERSCORED_CALLS_HPP* = 1\n      import macros\n    \n   \
    \   proc underscoredCall(n, arg0: NimNode): NimNode =\n        proc underscorePos(n:\
    \ NimNode): int =\n          for i in 1 ..< n.len:\n            if n[i].eqIdent(\"\
    _\"): return i\n          return 0\n    \n        if n.kind in nnkCallKinds:\n\
    \          result = copyNimNode(n)\n          result.add n[0]\n    \n        \
    \  let u = underscorePos(n)\n          for i in 1..u-1: result.add n[i]\n    \
    \      result.add arg0\n          for i in u+1..n.len-1: result.add n[i]\n   \
    \     elif n.kind in {nnkAsgn, nnkExprEqExpr}:\n          var field = n[0]\n \
    \         if n[0].kind == nnkDotExpr and n[0][0].eqIdent(\"_\"):\n           \
    \ # handle _.field = ...\n            field = n[0][1]\n          result = newDotExpr(arg0,\
    \ field).newAssignment n[1]\n        else:\n          # handle e.g. 'x.dup(sort)'\n\
    \          result = newNimNode(nnkCall, n)\n          result.add n\n         \
    \ result.add arg0\n    \n      proc underscoredCalls*(result, calls, arg0: NimNode)\
    \ =\n        expectKind calls, {nnkArgList, nnkStmtList, nnkStmtListExpr}\n  \
    \  \n        for call in calls:\n          if call.kind in {nnkStmtList, nnkStmtListExpr}:\n\
    \            underscoredCalls(result, call, arg0)\n          else:\n         \
    \   result.add underscoredCall(call, arg0)\n      discard\n  \n    macro dup*[T](arg:\
    \ T, calls: varargs[untyped]): T =\n      result = newNimNode(nnkStmtListExpr,\
    \ arg)\n      let tmp = genSym(nskVar, \"dupResult\")\n      result.add newVarStmt(tmp,\
    \ arg)\n      underscoredCalls(result, calls, tmp)\n      result.add tmp\n   \
    \ \n    \n    proc transLastStmt(n, res, bracketExpr: NimNode): (NimNode, NimNode,\
    \ NimNode) =\n      # Looks for the last statement of the last statement, etc...\n\
    \      case n.kind\n      of nnkIfExpr, nnkIfStmt, nnkTryStmt, nnkCaseStmt:\n\
    \        result[0] = copyNimTree(n)\n        result[1] = copyNimTree(n)\n    \
    \    result[2] = copyNimTree(n)\n        for i in ord(n.kind == nnkCaseStmt)..<n.len:\n\
    \          (result[0][i], result[1][^1], result[2][^1]) = transLastStmt(n[i],\
    \ res, bracketExpr)\n      of nnkStmtList, nnkStmtListExpr, nnkBlockStmt, nnkBlockExpr,\
    \ nnkWhileStmt,\n          nnkForStmt, nnkElifBranch, nnkElse, nnkElifExpr, nnkOfBranch,\
    \ nnkExceptBranch:\n        result[0] = copyNimTree(n)\n        result[1] = copyNimTree(n)\n\
    \        result[2] = copyNimTree(n)\n        if n.len >= 1:\n          (result[0][^1],\
    \ result[1][^1], result[2][^1]) = transLastStmt(n[^1], res, bracketExpr)\n   \
    \   of nnkTableConstr:\n        result[1] = n[0][0]\n        result[2] = n[0][1]\n\
    \        if bracketExpr.len == 1:\n          bracketExpr.add([newCall(bindSym\"\
    typeof\", newEmptyNode()), newCall(\n              bindSym\"typeof\", newEmptyNode())])\n\
    \        template adder(res, k, v) = res[k] = v\n        result[0] = getAst(adder(res,\
    \ n[0][0], n[0][1]))\n      of nnkCurly:\n        result[2] = n[0]\n        if\
    \ bracketExpr.len == 1:\n          bracketExpr.add(newCall(bindSym\"typeof\",\
    \ newEmptyNode()))\n        template adder(res, v) = res.incl(v)\n        result[0]\
    \ = getAst(adder(res, n[0]))\n      else:\n        result[2] = n\n        if bracketExpr.len\
    \ == 1:\n          bracketExpr.add(newCall(bindSym\"typeof\", newEmptyNode()))\n\
    \        template adder(res, v) = res.add(v)\n        result[0] = getAst(adder(res,\
    \ n))\n    \n    macro collect*(init, body: untyped): untyped =\n      # analyse\
    \ the body, find the deepest expression 'it' and replace it via\n      # 'result.add\
    \ it'\n      let res = genSym(nskVar, \"collectResult\")\n      expectKind init,\
    \ {nnkCall, nnkIdent, nnkSym}\n      let bracketExpr = newTree(nnkBracketExpr,\n\
    \        if init.kind == nnkCall: init[0] else: init)\n      let (resBody, keyType,\
    \ valueType) = transLastStmt(body, res, bracketExpr)\n      if bracketExpr.len\
    \ == 3:\n        bracketExpr[1][1] = keyType\n        bracketExpr[2][1] = valueType\n\
    \      else:\n        bracketExpr[1][1] = valueType\n      let call = newTree(nnkCall,\
    \ bracketExpr)\n      if init.kind == nnkCall:\n        for i in 1 ..< init.len:\n\
    \          call.add init[i]\n      result = newTree(nnkStmtListExpr, newVarStmt(res,\
    \ call), resBody, res)\n    discard\n#  import std/sugar\n  #[ import atcoder/extra/other/reader\
    \ ]#\n  when not declared ATCODER_READER_HPP:\n    const ATCODER_READER_HPP* =\
    \ 1\n    import streams\n    import strutils\n    import sequtils\n  #  proc scanf*(formatstr:\
    \ cstring){.header: \"<stdio.h>\", varargs.}\n    #proc getchar(): char {.header:\
    \ \"<stdio.h>\", varargs.}\n  #  proc nextInt*(): int = scanf(\"%lld\",addr result)\n\
    \  #  proc nextFloat*(): float = scanf(\"%lf\",addr result)\n    proc nextString*(f:auto\
    \ = stdin): string =\n      var get = false\n      result = \"\"\n      while\
    \ true:\n        let c = f.readChar\n        #doassert c.int != 0\n        if\
    \ c.int > ' '.int:\n          get = true\n          result.add(c)\n        elif\
    \ get: return\n    proc nextInt*(f:auto = stdin): int = parseInt(f.nextString)\n\
    \    proc nextFloat*(f:auto = stdin): float = parseFloat(f.nextString)\n  #  proc\
    \ nextString*():string = stdin.nextString()\n  \n    proc toStr*[T](v:T):string\
    \ =\n      proc `$`[T](v:seq[T]):string =\n        v.mapIt($it).join(\" \")\n\
    \      return $v\n    \n    proc print0*(x: varargs[string, toStr]; sep:string):string{.discardable.}\
    \ =\n      result = \"\"\n      for i,v in x:\n        if i != 0: addSep(result,\
    \ sep = sep)\n        add(result, v)\n      result.add(\"\\n\")\n      stdout.write\
    \ result\n    \n    var print*:proc(x: varargs[string, toStr])\n    print = proc(x:\
    \ varargs[string, toStr]) =\n      discard print0(@x, sep = \" \")\n    discard\n\
    \  #[ import atcoder/extra/other/sliceutils ]#\n  when not declared ATCODER_SLICEUTILS_HPP:\n\
    \    const ATCODER_SLICEUTILS_HPP* = 1\n    proc index*[T](a:openArray[T]):Slice[int]\
    \ =\n      a.low..a.high\n    type ReversedSlice[T] = distinct Slice[T]\n    type\
    \ StepSlice[T] = object\n      s:Slice[T]\n      d:T\n    proc rev*[T](p:Slice[T]):ReversedSlice[T]\
    \ = ReversedSlice[T](p)\n    iterator items*(n:int):int = (for i in 0..<n: yield\
    \ i)\n    iterator items*[T](p:ReversedSlice[T]):T =\n      if Slice[T](p).b >=\
    \ Slice[T](p).a:\n        var i = Slice[T](p).b\n        while true:\n       \
    \   yield i\n          if i == Slice[T](p).a:break\n          i.dec\n    proc\
    \ `>>`*[T](s:Slice[T], d:T):StepSlice[T] =\n      assert d != 0\n      StepSlice[T](s:s,\
    \ d:d)\n    proc `<<`*[T](s:Slice[T], d:T):StepSlice[T] =\n      assert d != 0\n\
    \      StepSlice[T](s:s, d: -d)\n    proc low*[T](s:StepSlice[T]):T = s.s.a\n\
    \    proc high*[T](s:StepSlice[T]):T =\n      let p = s.s.b - s.s.a\n      if\
    \ p < 0: return s.low - 1\n      let d = abs(s.d)\n      return s.s.a + (p div\
    \ d) * d\n    iterator items*[T](p:StepSlice[T]):T = \n      assert p.d != 0\n\
    \      if p.s.a <= p.s.b:\n        if p.d > 0:\n          var i = p.low\n    \
    \      let h = p.high\n          while i <= h:\n            yield i\n        \
    \    if i == h: break\n            i += p.d\n        else:\n          var i =\
    \ p.high\n          let l = p.low\n          while i >= l:\n            yield\
    \ i\n            if i == l: break\n            i += p.d\n    proc `[]`*[T:SomeInteger,\
    \ U](a:openArray[U], s:Slice[T]):seq[U] =\n      for i in s:result.add(a[i])\n\
    \    proc `[]=`*[T:SomeInteger, U](a:var openArray[U], s:StepSlice[T], b:openArray[U])\
    \ =\n      var j = 0\n      for i in s:\n        a[i] = b[j]\n        j.inc\n\
    \    discard\n  #[ import atcoder/extra/other/assignment_operator ]#\n  when not\
    \ declared ATCODER_ASSIGNMENT_OPERATOR_HPP:\n    import std/macros\n    import\
    \ std/strformat\n    const ATCODER_ASSIGNMENT_OPERATOR_HPP* = 1\n    template\
    \ `>?=`*(x,y:typed):void = x.max= y\n    template `<?=`*(x,y:typed):void = x.min=\
    \ y\n    proc `//`*[T](x,y:T):T = x div y\n    proc `%`*[T](x,y:T):T = x mod y\n\
    \    macro generateAssignmentOperator*(ops:varargs[untyped]) =\n      var strBody\
    \ = \"\"\n      for op in ops:\n        let op = op.repr\n        var op_raw =\
    \ op\n        if op_raw[0] == '`':\n          op_raw = op_raw[1..^2]\n       \
    \ strBody &= fmt\"\"\"proc `{op_raw}=`*[S, T](a:var S, b:T):auto {{.inline discardable.}}\
    \ = (mixin {op};a = `{op_raw}`(a, b);return a){'\\n'}\"\"\"\n      parseStmt(strBody)\n\
    \    generateAssignmentOperator(`mod`, `div`, `and`, `or`, `xor`, `shr`, `shl`,\
    \ `<<`, `>>`, max, min, `%`, `//`, `&`, `|`, `^`)\n    discard\n  #[ import atcoder/extra/other/inf\
    \ ]#\n  when not declared ATCODER_INF_HPP:\n    const ATCODER_INF_HPP* = 1\n \
    \   template inf*(T:typedesc): untyped = \n      when T is SomeFloat: T(Inf)\n\
    \      elif T is SomeInteger: T.high div 2\n      else:\n        static: assert(false)\n\
    \    proc `\u221E`*(T:typedesc):T = T.inf\n    proc `*!`*[T:SomeInteger](a, b:T):T\
    \ =\n      if a == T(0) or b == T(0): return T(0)\n      var sgn = T(1)\n    \
    \  if a < T(0): sgn = -sgn\n      if b < T(0): sgn = -sgn\n      let a = abs(a)\n\
    \      let b = abs(b)\n      if b > T.inf div a: result = T.inf\n      else: result\
    \ = min(T.inf, a * b)\n      result *= sgn\n    proc `+!`*[T:SomeInteger](a, b:T):T\
    \ =\n      result = a + b\n      result = min(T.inf, result)\n      result = max(-T.inf,\
    \ result)\n    proc `-!`*[T:SomeInteger](a, b:T):T =\n      result = a - b\n \
    \     result = min(T.inf, result)\n      result = max(-T.inf, result)\n    discard\n\
    \  #[ import atcoder/extra/other/warlus_operator ]#\n  when not declared ATCODER_CHAEMON_WARLUS_OPERATOR_HPP:\n\
    \    const ATCODER_CHAEMON_WARLUS_OPERATOR_HPP* = 1\n    import macros\n    proc\
    \ discardableId*[T](x: T): T {.discardable.} = x\n  \n    proc warlusImpl(x, y:NimNode):NimNode\
    \ =\n      return quote do:\n        when declaredInScope(`x`):\n          `x`\
    \ = `y`\n        else:\n          var `x` = `y`\n  \n    macro `:=`*(x, y: untyped):\
    \ untyped =\n      result = newStmtList()\n      if x.kind == nnkCurly:\n    \
    \    for i,xi in x: result.add warlusImpl(xi, y)\n      elif x.kind == nnkPar:\n\
    \        for i,xi in x: result.add warlusImpl(xi, y[i])\n      else:\n       \
    \ result.add warlusImpl(x, y)\n        result.add quote do:\n          discardableId(`x`)\n\
    \    discard\n  #[ import atcoder/extra/other/seq_array_utils ]#\n  when not declared\
    \ ATCODER_SEQ_ARRAY_UTILS:\n    const ATCODER_SEQ_ARRAY_UTILS* = 1\n    import\
    \ std/strformat\n    import std/macros\n    type SeqType = object\n    type ArrayType\
    \ = object\n    let\n      Seq* = SeqType()\n      Array* = ArrayType()\n  \n\
    \    template fill*[T](a:var T, init:untyped) =\n      when T is init.type:\n\
    \        a = init\n      else:\n        for x in a.mitems: fill(x, init)\n  \n\
    \    template makeSeq*(x:int; init):auto =\n      when init is typedesc: newSeq[init](x)\n\
    \      else:\n        var a = newSeq[typeof(init, typeofProc)](x)\n        a.fill(init)\n\
    \        a\n  \n    template makeArray*(x:int or Slice[int]; init):auto =\n  \
    \    var v:array[x, init.type]\n      v\n  \n    macro `[]`*(x:ArrayType or SeqType,\
    \ args:varargs[untyped]):auto =\n      var a:string\n      if $x == \"Seq\" and\
    \ args.len == 1 and args[0].kind != nnkExprColonExpr:\n        a = fmt\"newSeq[{args[0].repr}]()\"\
    \n      else:\n        let tail = args[^1]\n        assert tail.kind == nnkExprColonExpr,\
    \ \"Wrong format of tail\"\n        let\n          args = args[0 .. ^2] & tail[0]\n\
    \          init = tail[1]\n        a = fmt\"{init.repr}\"\n        if $x == \"\
    Array\":\n          for i in countdown(args.len - 1, 0): a = fmt\"makeArray({args[i].repr},\
    \ {a})\"\n          a = fmt\"{'\\n'}block:{'\\n'}  var a = {a}{'\\n'}  when {init.repr}\
    \ isnot typedesc:{'\\n'}    a.fill({init.repr}){'\\n'}  a\"\n        elif $x ==\
    \ \"Seq\":\n          for i in countdown(args.len - 1, 0): a = fmt\"makeSeq({args[i].repr},\
    \ {a})\"\n          a = fmt\"{'\\n'}block:{'\\n'}  {a}\"\n        else:\n    \
    \      assert(false)\n      parseStmt(a)\n    discard\n  #[ include atcoder/extra/other/debug\
    \ ]#\n  when not declared ATCODER_DEBUG_HPP:\n    const ATCODER_DEBUG_HPP* = 1\n\
    \    import macros\n    import strformat\n    import terminal\n  \n    macro debugImpl*(n:varargs[untyped]):\
    \ untyped =\n      #  var a = \"stderr.write \"\n      var a = \"\"\n      a.add\
    \ \"setForegroundColor fgYellow\\n\"\n      a.add \"stdout.write \"\n  #    a.add\
    \ \"stderr.write \"\n      for i,x in n:\n        if x.kind == nnkStrLit:\n  \
    \        a &= fmt\"{x.repr}  \"\n        else:\n          a &= fmt\"\"\" \"{x.repr}\
    \ = \", {x.repr} \"\"\"\n        if i < n.len - 1:\n          a.add(\"\"\", \"\
    , \",\"\"\")\n      a.add(\", \\\"\\\\n\\\"\")\n      a.add \"\\n\"\n      a.add\
    \ \"resetAttributes()\"\n      parseStmt(a)\n    template debug*(n: varargs[untyped]):\
    \ untyped =\n      const EVAL =\n        when declared DEBUG: DEBUG\n        else:\
    \ false\n      when EVAL:\n        debugImpl(n)\n    discard\n  #[ import atcoder/extra/other/reference\
    \ ]#\n  when not declared ATCODER_REFERENCE_HPP:\n    const ATCODER_REFERENCE_HPP*\
    \ = 1\n    import std/macros\n    import std/strformat\n  \n    template byaddr*(lhs,\
    \ typ, ex) =\n      when typ is typeof(nil):\n        let tmp = addr(ex)\n   \
    \   else:\n        let tmp: ptr typ = addr(ex)\n      template lhs: untyped =\
    \ tmp[]\n  \n    macro `=&`*(lhs, rhs:untyped) =\n      parseStmt(fmt\"\"\"byaddr({lhs.repr},\
    \ {rhs.repr}.type, {rhs.repr})\"\"\")\n    discard\n  #[ import atcoder/extra/other/floatutils\
    \ ]#\n  when not declared ATCODER_FLOAT_UTILS_HPP:\n    const ATCODER_FLOAT_UTILS_HPP*\
    \ = 1\n    import std/math as math_lib_floatutils\n    import std/strutils\n \
    \   #[ import atcoder/element_concepts ]#\n    when not declared ATCODER_ELEMENT_CONCEPTS_HPP:\n\
    \      const ATCODER_ELEMENT_CONCEPTS_HPP* = 1\n      proc inv*[T:SomeFloat](a:T):auto\
    \ = T(1) / a\n      proc init*(self:typedesc[SomeFloat], a:SomeNumber):auto =\
    \ self(a)\n      type AdditiveGroupElem* = concept x, y, type T\n        x + y\n\
    \        x - y\n        -x\n        T(0)\n      type MultiplicativeGroupElem*\
    \ = concept x, y, type T\n        x * y\n        x / y\n    #    x.inv()\n   \
    \     T(1)\n      type RingElem* = concept x, y, type T\n        x + y\n     \
    \   x - y\n        -x\n        x * y\n        T(0)\n        T(1)\n      type FieldElem*\
    \ = concept x, y, type T\n        x + y\n        x - y\n        x * y\n      \
    \  x / y\n        -x\n    #    x.inv()\n        T(0)\n        T(1)\n      type\
    \ FiniteFieldElem* = concept x, type T\n        T is FieldElem\n        T.mod\n\
    \        T.mod() is int\n        x.pow(1000000)\n      type hasInf* = concept\
    \ x, type T\n        T(Inf)\n      discard\n    #[ import atcoder/extra/other/static_var\
    \ ]#\n    when not declared ATCODER_STATIC_VAR_HPP:\n      const ATCODER_STATIC_VAR_HPP*\
    \ = 1\n      import std/macros\n      import std/strformat\n      macro staticVar*(T:typedesc,\
    \ body: untyped) =\n        var s = \"\"\n        for n in body:\n          let\
    \ name = n[0]\n          let t = n[1]\n          let t2 = fmt\"{t.repr[1..<t.repr.len]}\"\
    \n          s &= fmt\"\"\"{'\\n'}proc get_global_addr_of_{name.repr}*[U:{T.repr}](self:typedesc[U]\
    \ or U):ptr[{t2}] ={'\\n'}  when self is typedesc:{'\\n'}    var a {{.global.}}:{t2}.type{'\\\
    n'}    a.addr{'\\n'}  else:{'\\n'}    get_global_addr_of_{name.repr}(self.type){'\\\
    n'}\n    \"\"\"\n        parseStmt(s)\n      \n      macro `$.`*(t, name:untyped):untyped\
    \ =\n        let s = fmt\"{t.repr}.get_global_addr_of_{name.repr}()[]\"\n    \
    \    parseStmt(s)\n      discard\n    proc getParameters*(Real:typedesc):ptr[tuple[n:int,\
    \ pi, eps, inf:Real]] =\n      var p {.global.}:tuple[n:int, pi, eps, inf:Real]\n\
    \      return p.addr\n  \n    converter floatConverter*(a:SomeInteger):float =\
    \ a.float\n    converter float64Converter*(a:SomeInteger):float64 = a.float64\n\
    \    converter float32Converter*(a:SomeInteger):float32 = a.float32\n    converter\
    \ floatConverter*(a:string):float = a.parseFloat\n    converter float64Converter*(a:string):float64\
    \ = a.parseFloat.float64\n    converter float32Converter*(a:string):float32 =\
    \ a.parseFloat.float32\n  \n    staticVar FieldElem:\n      pi:U.type\n      eps:U.type\n\
    \      inf:U.type\n  \n    proc getPi*(Real:typedesc):Real = Real.getParameters()[].pi\n\
    \    proc getEPS*(Real:typedesc):Real = Real.getParameters()[].eps\n    proc getINF*(Real:typedesc):Real\
    \ = Real.getParameters()[].inf\n    proc setEPS*(Real:typedesc, x:Real) = Real.getParameters()[].eps\
    \ = x\n  \n    proc valid_range*[Real](l, r:Real):bool =\n      # assert(l <=\
    \ r)\n      var (l, r) = (l, r)\n      if l > r: swap(l, r)\n      let d = r -\
    \ l\n      let eps = Real$.eps\n      if d < eps: return true\n      if l <= Real(0)\
    \ and Real(0) <= r: return false\n      return d < eps * min(abs(l), abs(r))\n\
    \  \n    template initPrec*(Real:typedesc) =\n      Real$.pi = PI.Real\n     \
    \ Real$.inf = Inf.Real\n      when Real is float or Real is float64:\n       \
    \ Real$.eps = 1e-9.Real\n      elif Real is float32:\n        Real$.eps = 1e-9.Real\n\
    \      # float comp\n      # TODO: relative error\n      proc `=~`*(a,b:Real):bool\
    \ = abs(a - b) < Real$.eps\n      proc `!=~`*(a,b:Real):bool = abs(a - b) > Real$.eps\n\
    \      proc `<~`*(a,b:Real):bool = a + Real$.eps < b\n      proc `>~`*(a,b:Real):bool\
    \ = a > b + Real$.eps\n      proc `<=~`*(a,b:Real):bool = a < b + Real$.eps\n\
    \      proc `>=~`*(a,b:Real):bool = a + Real$.eps > b\n  \n    # for OMC\n   \
    \ proc estimateRational*[Real](x:Real, n:int) =\n      var m = Real$.inf\n   \
    \   var q = 1\n      while q <= n:\n        let p = round(x * q.Real)\n      \
    \  let d = abs(p / q.Real - x)\n        if d < m:\n          m = d\n         \
    \ echo \"found: \", p, \"/\", q, \"   \", \"error: \", d\n        q.inc\n    \
    \  return\n  \n    float.initPrec()\n  #  float64.initPrec()\n    float32.initPrec()\n\
    \    discard\n  #[ import atcoder/extra/other/zip ]#\n  when not declared ATCODER_ZIP_HPP:\n\
    \    const ATCODER_ZIP_HPP* = 1\n    import macros\n  \n    macro zip*(v:varargs[untyped]):untyped\
    \ =\n      result = newStmtList()\n      var par = newPar()\n      for i,a in\
    \ v:\n        var ts = newNimNode(nnkTypeSection)\n        par.add(ident(\"T\"\
    \ & $i))\n        ts.add(newNimNode(nnkTypeDef).add(\n          ident(\"T\" &\
    \ $i),\n          newEmptyNode(),\n          newDotExpr(newNimNode(nnkBracketExpr).add(a,\
    \ newIntLitNode(0)), ident(\"type\"))\n        ))\n        result.add ts\n   \
    \   var varSection = newNimNode(nnkVarSection)\n      varSection.add newIdentDefs(ident(\"\
    a\"), newEmptyNode(), newCall(\n        newNimNode(nnkBracketExpr).add(\n    \
    \      ident(\"newSeq\"), \n          par\n        ), \n        ident(\"n\")\n\
    \      ))\n      result.add newNimNode(nnkLetSection).add(newIdentDefs(ident(\"\
    n\"), newEmptyNode(), \n        newDotExpr(v[0] , ident(\"len\"))\n      ))\n\
    \      result.add(varSection)\n    \n      var forStmt = newNimNode(nnkForStmt).add(ident(\"\
    i\")).add(\n        newNimNode(nnkInfix).add(ident(\"..<\")).add(newIntLitNode(0),\
    \ ident(\"n\"))\n      )\n      var fs = newStmtList()\n      for j,a in v:\n\
    \        fs.add newAssignment(\n          newNimNode(nnkBracketExpr).add(\n  \
    \          newNimNode(nnkBracketExpr).add(\n              ident(\"a\"), \n   \
    \           ident(\"i\")\n            ), \n            newIntLitNode(j)), \n \
    \         newNimNode(nnkBracketExpr).add(\n            a, \n            ident(\"\
    i\")\n          )\n        )\n      forStmt.add fs\n      result.add(forStmt)\n\
    \      result.add(ident(\"a\"))\n      result = newBlockStmt(newEmptyNode(), result)\n\
    \    \n    macro unzip*(n:int, p:tuple):untyped = \n      result = newStmtList()\n\
    \      result.add(newNimNode(nnkLetSection).add(newIdentDefs(ident(\"n\"), newEmptyNode(),\
    \ n)))\n      for i,a in p:\n        var a = newPar(a)\n        var t = newCall(\n\
    \          newNimNode(nnkBracketExpr).add(\n            ident(\"newSeq\"), \n\
    \            newDotExpr(a, ident(\"type\"))\n          ), \n          ident(\"\
    n\")\n        )\n        var varSection = newNimNode(nnkVarSection).add(\n   \
    \       newIdentDefs(ident(\"a\" & $i), newEmptyNode(), t), \n        )\n    \
    \    result.add(varSection)\n      var forStmt = newNimNode(nnkForStmt).add(ident(\"\
    i\"))\n      var rangeDef = newNimNode(nnkInfix).add(ident(\"..<\")).add(newIntLitNode(0),\
    \ ident(\"n\"))\n      forStmt.add(rangeDef)\n      var fs = newStmtList()\n \
    \     for i,a in p:\n        fs.add newAssignment(\n          newNimNode(nnkBracketExpr).add(\n\
    \            ident(\"a\" & $i), \n            ident(\"i\")), \n          a\n \
    \       )\n      forStmt.add fs\n      result.add(forStmt)\n      var par = newPar()\n\
    \      for i, a in p:\n        par.add(ident(\"a\" & $i))\n      result.add(par)\n\
    \      result = newBlockStmt(newEmptyNode(), result)\n  \n    discard\n  #[ import\
    \ atcoder/extra/other/solve_proc ]#\n  when not declared ATCODER_SOLVEPROC_HPP:\n\
    \    const ATCODER_SOLVEPROC_HPP* = 1\n    import std/macros\n    import std/strformat\n\
    \    import std/algorithm\n    import std/sequtils\n    import std/streams\n \
    \   import std/strutils\n    import math\n  \n    proc compare_answer_string*(s,\
    \ t:string, error:float = NaN):bool =\n      if error.classify == fcNaN:\n   \
    \     return s == t\n      else:\n        var\n          s = s.split(\"\\n\")\n\
    \          t = t.split(\"\\n\")\n        if s.len != t.len: return false\n   \
    \     for i in 0 ..< s.len:\n          var s = s[i].split()\n          var t =\
    \ t[i].split()\n          if s.len != t.len: return false\n          for j in\
    \ 0 ..< s.len:\n            if s[j].len == 0:\n              if t[j].len != 0:\
    \ return false\n            elif t[j].len == 0:\n              return false\n\
    \            else:\n              var fs = s[j].parseFloat\n              var\
    \ ft = t[j].parseFloat\n              if abs(fs - ft) > error and abs(fs - ft)\
    \ > min(abs(ft), abs(fs)) * error: return false\n        return true\n      doAssert\
    \ false\n  \n    proc mainBodyHeader():NimNode =\n  #    let macro_def = \"(for\
    \ s in {x.repr}: (result &= $s;(when output_stdout: stdout.write $s)));(result\
    \ &= \\\"\\\\n\\\";when output_stdout: stdout.write \\\"\\\\n\\\")\"\n      result\
    \ = newStmtList()\n      result.add quote(\"@@\") do:\n        mixin echo\n  \
    \      result = \"\"\n        var resultPointer = result.addr\n        proc echo(x:varargs[string,\
    \ `$`]) =\n          for s in x:\n            resultPointer[] &= $s\n        \
    \    when output_stdout: stdout.write $s\n          resultPointer[] &= \"\\n\"\
    \n          when output_stdout: stdout.write \"\\n\"\n  \n    macro solveProc*(head,\
    \ body:untyped):untyped =\n      var prev_type:NimNode\n      var params:seq[NimNode]\n\
    \      for i in countdown(head.len - 1, 1):\n        var identDefs = newNimNode(nnkIdentDefs)\n\
    \        if head[i].kind == nnkExprColonExpr:\n          identDefs.add(head[i][0])\n\
    \          prev_type = head[i][1]\n        elif head[i].kind == nnkIdent:\n  \
    \        identDefs.add(head[i])\n        identDefs.add(prev_type)\n        identDefs.add(newEmptyNode())\n\
    \        params.add(identDefs)\n      params.add(ident\"auto\")\n      params.reverse()\n\
    \      var callparams:seq[NimNode]\n      for i in 1..<params.len:\n        callparams.add(params[i][0])\n\
    \  #    var mainBody, naiveBody = mainBodyHeader()\n      var mainBody, checkBody,\
    \ naiveBody, testBody, generateBody = newStmtList()\n      var hasNaive, hasCheck,\
    \ hasTest, hasGenerate = false\n      for b in body:\n        if b.kind == nnkCall:\n\
    \          if b[0] == ident\"Check\":\n            hasCheck = true\n         \
    \   var checkStmt = if b.len == 2: b[1] else: b[2]\n            var strmName =\
    \ if b.len == 2: ident(\"strm\") else: b[1]\n            checkBody.add(newNimNode(nnkWhenStmt).add(\n\
    \              newNimNode(nnkElifBranch).add(ident\"DO_CHECK\").add(\n       \
    \         newBlockStmt(newEmptyNode(), \n                  newStmtList().add(\n\
    \                    quote do:\n                      var `strmName` = newStringStream(resultOutput)\n\
    \                  ).add(checkStmt)\n            ))))\n          elif b[0] ==\
    \ ident\"Naive\":\n            hasNaive = true\n            naiveBody.add b[1]\n\
    \          elif b[0] == ident\"Test\":\n            hasTest = true\n         \
    \   testBody.add b[1]\n          elif b[0] == ident\"Generate\":\n           \
    \ hasGenerate = true\n            generateBody.add b[1]\n          else:\n   \
    \         mainBody.add b\n        else:\n          mainBody.add b\n      mainBody\
    \ = newStmtList().add(mainBodyHeader()).add(mainBody)\n      #if hasCheck:\n \
    \     #  mainBody.add(checkBody)\n      result = newStmtList()\n      let procName\
    \ = head[0]\n      var discardablePragma = newNimNode(nnkPragma).add(ident(\"\
    discardable\"))\n      var mainParams = params\n      mainParams[0] = ident\"\
    string\"\n  #    var identDefsSub = newNimNode(nnkIdentDefs).add(ident\"output_stdout\"\
    ).add(newNimNode(nnkBracketExpr).add(ident\"static\").add(ident\"bool\")).add(ident\"\
    true\")\n      var identDefs = newNimNode(nnkIdentDefs).add(ident\"output_stdout\"\
    ).add(newNimNode(nnkBracketExpr).add(ident\"static\").add(ident\"bool\")).add(ident\"\
    true\")\n      proc copy(a:seq[NimNode]):seq[NimNode] = a.mapIt(it.copy)\n  #\
    \    var identDefs = newNimNode(nnkIdentDefs).add(ident\"output_stdout\").add(newNimNode(nnkBracketExpr).add(ident\"\
    static\").add(ident\"bool\")).add(newEmptyNode())\n      mainParams.add(identDefs)\n\
    \      #var mainProcDef = newNimNode(nnkProcDef).add(ident\"solve\").add(newEmptyNode()).add(newEmptyNode()).add(newNimNode(nnkFormalParams).add(mainParams.copy())).add(discardablePragma).add(newEmptyNode()).add(newEmptyNode())\n\
    \      #result.add(mainProcDef)\n      if hasCheck:\n        result.add(quote\
    \ do:\n          type CheckResult {.inject.} = ref object of Exception\n     \
    \       output, err:string\n          template check(b:untyped) =\n          \
    \  if not b:\n              raise CheckResult(err: b.astToStr, output: resultOutput)\n\
    \        )\n      if hasNaive:\n        var naiveProcDef = newNimNode(nnkProcDef).add(ident\"\
    solve_naive\").add(newEmptyNode()).add(newEmptyNode()).add(newNimNode(nnkFormalParams).add(mainParams.copy())).add(discardablePragma).add(newEmptyNode()).add(newEmptyNode())\n\
    \        result.add(naiveProcDef)\n  \n      var naiveParams = mainParams.copy()\n\
    \      #result.add newProc(name = ident(procName), params = mainParams.copy(),\
    \ body = mainBody, pragmas = discardablePragma)\n      \n      var mainProcImpl\
    \ =\n        newStmtList().add(parseStmt(\"mixin echo\")).add quote do:\n    \
    \    proc solve():string =\n          `mainBody`\n        var resultOutput {.inject.}\
    \ = solve()\n      var mainTemplateBody = newStmtList().add quote do:\n      \
    \  `mainProcImpl`\n      if hasCheck:\n        mainTemplateBody.add checkBody\n\
    \      mainTemplateBody.add quote do:\n        resultOutput\n      var mainTemplate\
    \ = quote do:\n        proc `procName`():string {.discardable.} =\n          `mainTemplateBody`\n\
    \      mainTemplate[3].add mainParams[1..^1].copy()\n      result.add mainTemplate\n\
    \  \n      if hasNaive:\n        let naiveProcName = $procName & \"naive\"\n \
    \       naiveBody = mainBodyHeader().add(newBlockStmt(newEmptyNode(), naiveBody))\n\
    \        result.add newProc(name = ident(naiveProcName), params = naiveParams,\
    \ body = naiveBody, pragmas = discardablePragma)\n        var test_body = newStmtList()\n\
    \        var var_names = newSeq[string]()\n        for procName in [$procName,\
    \ $procName & \"_naive\"]:\n          let var_name = \"v\" & procName\n      \
    \    var_names.add(var_name)\n          var l = newNimNode(nnkCall).add(ident(procName))\n\
    \          for c in callparams: l.add(c)\n          l.add(ident\"false\")\n  \
    \        test_body.add(\n            newNimNode(nnkLetSection).add(\n        \
    \      newNimNode(nnkIdentDefs).add(ident(var_name)).add(newEmptyNode()).add(l)\n\
    \            ))\n        var test_params = params\n        var vars = \"\"\n \
    \       for i in 1..<params.len:\n          let p = params[i][0]\n          vars\
    \ &= &\"  {p.repr} = {{{p.repr}}}\\\\n\"\n        test_params[0] = ident\"bool\"\
    \n  \n        var identDefs = newNimNode(nnkIdentDefs).add(ident\"error\").add(ident\"\
    float\").add(ident(\"NaN\"))\n        test_params.add identDefs\n        test_body.add\
    \ parseStmt(&\"if not compare_answer_string(vsolve, vsolve_naive, error): echo\
    \ &\\\"test failed for\\\\n{vars}\\\", \\\"[solve]\\\\n\\\", vsolve, \\\"[solve_naive]\\\
    \\n\\\", vsolve_naive;doAssert false\")\n        result.add newProc(name = ident\"\
    test\", params = test_params, body = test_body, pragmas = discardablePragma)\n\
    \      elif hasCheck:\n        var test_body_sub = newStmtList()\n        var\
    \ var_names = newSeq[string]()\n        for procName in [$procName]:\n       \
    \   let var_name = \"v\" & procName\n          var_names.add(var_name)\n     \
    \     var l = newNimNode(nnkCall).add(ident(procName))\n          for c in callparams:\
    \ l.add(c)\n          l.add(ident\"false\")\n          test_body_sub.add(\n  \
    \          newNimNode(nnkLetSection).add(\n              newNimNode(nnkIdentDefs).add(ident(var_name)).add(newEmptyNode()).add(l)\n\
    \            ))\n        var test_params = params\n        var vars = \"\"\n \
    \       for i in 1..<params.len:\n          let p = params[i][0]\n          vars\
    \ &= &\"  {p.repr} = {{{p.repr}}}\\\\n\"\n        test_params[0] = ident\"bool\"\
    \n        var test_body = newStmtList()\n        var d = &\"try:\\n  {test_body_sub.repr.strip}\\\
    nexcept CheckResult as e:\\n  echo &\\\"check failed for\\\\n{vars}\\\", \\\"\
    [failed statement]\\\\n\\\", e.err.strip, \\\"\\\\n[output]\\\\n\\\", e.output;doAssert\
    \ false\"\n        test_body.add parseStmt(d)\n        result.add newProc(name\
    \ = ident\"test\", params = test_params, body = test_body, pragmas = discardablePragma)\n\
    \  \n      if hasGenerate:\n        discard\n      if hasTest:\n        discard\n\
    \      #echo result.repr\n    discard\n\n  when declared USE_DEFAULT_TABLE:\n\
    \    when USE_DEFAULT_TABLE:\n      proc `[]`[A, B](self: var Table[A, B], key:\
    \ A): var B =\n        discard self.hasKeyOrPut(key, B.default)\n        tables_lib.`[]`(self,\
    \ key)\n\n  # converter toBool[T:ref object](x:T):bool = x != nil\n  # converter\
    \ toBool[T](x:T):bool = x != T(0)\n  # misc\n  proc `<`[T](a, b:seq[T]):bool =\n\
    \    for i in 0 ..< min(a.len, b.len):\n      if a[i] < b[i]: return true\n  \
    \    elif a[i] > b[i]: return false\n    if a.len < b.len: return true\n    else:\
    \ return false\n\n  proc ceilDiv*[T:SomeInteger](a, b:T):T =\n    assert b !=\
    \ 0\n    if b < 0: return ceilDiv(-a, -b)\n    result = a.floorDiv(b)\n    if\
    \ a mod b != 0: result.inc\n\n  template `/^`*[T:SomeInteger](a, b:T):T = ceilDiv(a,\
    \ b)\n  discard\n\nblock:\n  var\n    trie = initTrie[26, 'a'.ord]()\n  let\n\
    \    S = nextString()\n    M = nextInt()\n    P = Seq[M: nextString()]\n    W\
    \ = Seq[M: nextInt()]\n  for i in M: trie.add(P[i])\n  var dp = Seq[S.len + 1]\n\
    \  for i in S.len:\n    proc update(idx:int) =\n      dp[i + P[idx].len] = max(dp[i\
    \ + P[idx].len], dp[i] + W[idx]);\n    trie.query(S, update, i, 0)\n    dp[i +\
    \ 1] = max(dp[i + 1], dp[i])\n  echo dp[^1]\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/structure/combined.nim
  requiredBy: []
  timestamp: '2022-06-06 17:51:24+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/structure/combined.nim
layout: document
redirect_from:
- /library/atcoder/extra/structure/combined.nim
- /library/atcoder/extra/structure/combined.nim.html
title: atcoder/extra/structure/combined.nim
---
