when not declared ATCODER_GENERATE_DEFINITIONS_NIM:
  const ATCODER_GENERATE_DEFINITIONS_NIM* = 1
  import std/strformat, std/macros

  template generateDefinitions*(name, l, r, typeObj, typeBase, body: untyped): untyped {.dirty.} =
    proc name*(l, r: typeObj): auto {.inline.} =
      type T = l.type
      body
    proc name*(l: typeBase; r: typeObj): auto {.inline.} =
      type T = r.type
      body
    proc name*(l: typeObj; r: typeBase): auto {.inline.} =
      type T = l.type
      body

  template generatePow*(name) {.dirty.} =
    proc pow*(m: name; p: SomeInteger): name {.inline.} =
      if (p.type)(0) <= p:
        var
          p = p.uint
          m = m
        result = m.unit()
        while p > 0'u:
          if (p and 1'u) != 0'u: result *= m
          m *= m
          p = p shr 1'u
      else:
        return pow(m.inv(), -p)
    proc `^`*[T:name](m: T; p: SomeInteger): T {.inline.} = m.pow(p)

  macro generateConverter*(name, from_type, to_type) =
    parseStmt(fmt"""type {name.repr}* = {to_type.repr}{'\n'}converter to{name.repr}OfGenerateConverter*(a:{from_type}):{name.repr} {{.used.}} = {name.repr}.init(a){'\n'}""")
