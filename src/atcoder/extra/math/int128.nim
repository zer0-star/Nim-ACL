when not declared ATCODER_INT128:
    const ATCODER_INT128* = 1
    import hashes
    import std/strutils, std/algorithm
    import std/macros, std/strformat
    type Int128* {.importcpp: "__int128_t", nodecl.} = object
    type Uint128* {.importcpp: "__uint128_t", nodecl.} = object
    
    converter to_Int128*(x: SomeInteger or Uint128): Int128 {.importcpp: "(__int128_t)((#))", nodecl.}
    converter to_Uint128*(x: SomeInteger or Int128): Uint128 {.importcpp: "(__uint128_t)((#))", nodecl.}
    proc to_int*(x: Int128 or Uint128): int {.importcpp: "(long long)(#)", nodecl.}
    proc to_int32*(x: Int128): int32 {.importcpp: "(int)(#)", nodecl.}
    proc to_Uint*(x: Int128): uint {.importcpp: "(unsigned long long)(#)", nodecl.}
    proc `-`*(x: Int128): Int128 {.importcpp: "(-(#))", nodecl.}
    proc `not`*[T: Int128 or Uint128](x: T): T {.importcpp: "(~(#))", nodecl.}
    proc `inc`*(x: var Int128):void {.importcpp: "(++(#))", nodecl.}
    proc `dec`*(x: var Int128):void {.importcpp: "(--(#))", nodecl.}

    template declareUpdateOperator(nimop:untyped, cop: static[string]) =
      proc `nimop`*[T: Int128 or Uint128](x: var T, y: T) {.inline importcpp: "((#) " & cop & "(#))", nodecl.}
    macro generateUpdateOperator*(ops: varargs[tuple]) =
      var strBody = ""
      for p in ops:
        let
          (nimop, cop) = ($p[0], $p[1])
        strBody &= fmt"""declareUpdateOperator(`{nimop}`, "{cop}"){'\n'}"""
      parseStmt(strBody)

    macro generateBinaryOperator*(ops:varargs[untyped]) =
      var strBody = ""
      for op in ops:
        let op = op.repr
        var op_raw = op
        if op_raw[0] == '`':
          op_raw = op_raw[1..^2]
        strBody &= fmt"""proc `{op_raw}`*[T:Int128 or Uint128](a, b:T):auto {{.inline discardable.}} = (mixin {op};result = a; `{op_raw}=`(result, b)){'\n'}"""
      parseStmt(strBody)

    generateUpdateOperator(
      ("+=", "+="), ("-=", "-="), ("*=", "*="),
      ("div=", "/="), ("mod=", "%="),
      ("&=", "&="), ("and=", "&="), 
      ("|=", "|="), ("or=", "|="),
      ("xor=", "^="),
      ("<<=", "<<="), ("shl=", "<<="),
      (">>=", ">>="), ("shr=", ">>=")
    )

    generateBinaryOperator(
      `+`, `-`, `*`, `div`, `mod`, 
      `&`, `and`, `|`, `or`, `xor`, 
      `<<`, `shl`, `>>`, `shr`)

    proc `>`*[T: Int128 or Uint128](x, y: T): bool {.importcpp: "((#) > (#))", nodecl.}
    proc `>=`*[T: Int128 or Uint128](x, y: T): bool {.importcpp: "((#) >= (#))", nodecl.}
    proc `<`*[T: Int128 or Uint128](x, y: T): bool {.importcpp: "((#) < (#))", nodecl.}
    proc `<=`*[T: Int128 or Uint128](x, y: T): bool {.importcpp: "((#) <= (#))", nodecl.}
    proc `==`*[T: Int128 or Uint128](x, y: T): bool {.importcpp: "((#) == (#))", nodecl.}
    proc abs*(x: Int128): Int128 = (if x >= 0:x else: -x)
    proc cmp*[T: Int128 or Uint128](x, y: T): int = (if x < y: -1 elif x == y: 0 else: 1)
    proc hash*[T: Int128 or Uint128](x: T): Hash = hash(x div int(100000000000000000)) !& hash(x mod int(100000000000000000))
    const
      D18 = 1000000000000000000
      logD = 18
    proc parseUint128*(s: string): Uint128 =
      var
        p = Uint128(1)
        r = s.len
      result = Uint128(0)
      while r > 0:
        let l = max(0, r - logD)
        result += Uint128(parseInt(s[l ..< r])) * p
        r -= logD
        p *= D18
    proc parseInt128*(s: string): Int128 =
      if s[0] == '-': return -Int128(parseUint128(s[1 .. ^1]))
      else: Int128(parseUint128(s))

    proc pow*(x, n, m: Int128): Int128 =
        result = 1
        var x = x
        var n = n
        while n > 0:
            if (n & 1) == 1: result = (result * x) mod m
            x *= x
            n >>= 1
    proc `^`*(x, n: Int128): Int128 =
        result = 1
        var x = x
        var n = n
        while n > 0:
            if (n & 1) == 1: result = (result * x)
            x *= x
            n >>= 1

    # 18桁ずつ
    proc to_string[T: Int128 or Uint128](x: T):string =
      when x is Int128:
        if x < 0:
          return "-" & to_string((not Uint128(x)) + Uint128(1))
      if x == T(0): return "0"
      var
        x = x
        a = newSeq[string]()
      while x > T(0):
        let
          q = x div T(D18)
          r = $to_int(x mod D18)
        var s = $r
        if q > T(0):
          s = '0'.repeat(18 - s.len) & s
        a.add s
        x = q
      a.reverse
      return a.join()
    proc `$`*(x: Int128): string = $(to_string(x))
    proc `$`*(x: Uint128): string = $(to_string(x))

    proc floorDiv*(x, y: Int128): Int128 =
      result = x div y
      let r = x mod y
      if (r > 0 and y < 0) or (r < 0 and y > 0): result -= 1
    proc floorMod*(x, y: Int128): Int128 =
      result = x mod y
      if (result > 0 and y < 0) or (result < 0 and y > 0): result += y

