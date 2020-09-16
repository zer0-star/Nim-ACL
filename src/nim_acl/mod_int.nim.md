---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 70, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir).decode()\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# ModInt {{{\n# ModInt[Mod] {{{\ntype ModInt[Mod: static[int]] = object\n\
    \  v:int32\n \nproc initModInt(a:SomeInteger, Mod:static[int]):ModInt[Mod] =\n\
    \  var a = a.int\n  a = a mod Mod\n  if a < 0: a += Mod\n  result.v = a.int32\n\
    \ \nproc getMod[Mod:static[int]](self: ModInt[Mod]):static int32 = self.Mod\n\
    proc getMod[Mod:static[int]](self: typedesc[ModInt[Mod]]):static int32 = self.Mod\n\
    \ \nmacro declareModInt(Mod:static[int], t: untyped):untyped =\n  var strBody\
    \ = \"\"\n  strBody &= fmt\"\"\"\ntype {t.repr} = ModInt[{Mod.repr}]\nproc init{t.repr}(a:SomeInteger):{t.repr}\
    \ = initModInt(a, {Mod.repr})\nproc `$`(a:{t.repr}):string = $(a.v)\nconverter\
    \ to{t.repr}(a:SomeInteger):{t.repr} = initModInt(a, {Mod.repr})\n\"\"\"\n  parseStmt(strBody)\n\
    \ \nwhen declared(Mod): declareModInt(Mod, Mint)\n##}}}\n \n# DynamicModInt {{{\n\
    type DMint = object\n  v:int32\n \nproc setModSub(self:typedesc[not ModInt], m:int\
    \ = -1, update = false):int32 =\n  {.noSideEffect.}:\n    var DMOD {.global.}:int32\n\
    \    if update: DMOD = m.int32\n    return DMOD\n \nproc fastMod(a:int,m:uint32):uint32{.inline.}\
    \ =\n  var\n    minus = false\n    a = a\n  if a < 0:\n    minus = true\n    a\
    \ = -a\n  elif a < m.int:\n    return a.uint32\n  var\n    xh = (a shr 32).uint32\n\
    \    xl = a.uint32\n    d:uint32\n  asm \"\"\"\n    \"divl %4; \\n\\t\"\n    :\
    \ \"=a\" (`d`), \"=d\" (`result`)\n    : \"d\" (`xh`), \"a\" (`xl`), \"r\" (`m`)\n\
    \  \"\"\"\n  if minus and result > 0'u32: result = m - result\nproc initDMint(a:SomeInteger,\
    \ Mod:int):DMint = result.v = fastMod(a.int, Mod.uint32).int32\n \nproc getMod[T:not\
    \ ModInt](self: T):int32 = T.type.setModSub()\nproc getMod(self: typedesc[not\
    \ ModInt]):int32 = self.setModSub()\nproc setMod(self: typedesc[not ModInt], m:int)\
    \ = discard self.setModSub(m, update = true)\n#}}}\n \n# Operations {{{\ntype\
    \ ModIntC = concept x, type T\n  x.v\n#  x.v is int32\n#  x.getMod() is int32\n\
    #  when T isnot ModInt: setMod(T, int)\ntype SomeIntC = concept x\n  x is SomeInteger\
    \ or x is ModIntC\n \nproc Identity(self:ModIntC):auto = result = self;result.v\
    \ = 1\nproc init[Mod:static[int]](self:ModInt[Mod], a:SomeIntC):ModInt[Mod] =\n\
    \  when a is SomeInteger: initModInt(a, Mod)\n  else: a\nproc init(self:ModIntC\
    \ and not ModInt, a:SomeIntC):auto =\n  when a is SomeInteger:\n    var r = self.type.default\n\
    \    r.v = fastMod(a.int, self.getMod().uint32).int32\n    r\n  else: a\n \nmacro\
    \ declareDMintConverter(t:untyped) =\n  parseStmt(fmt\"\"\"\nconverter to{t.repr}(a:SomeInteger):{t.repr}\
    \ =\n  let Mod = {t.repr}.getMod()\n  if Mod > 0:\n    result.v = fastMod(a.int,\
    \ Mod.uint32).int32\n  else:\n    result.v = a.int32\n  return result\n\"\"\"\
    )\n \ndeclareDMintConverter(DMint)\n \nmacro declareDMint(t:untyped) =\n  parseStmt(fmt\"\
    \"\"\ntype {t.repr} {{.borrow: `.`.}} = distinct DMint\ndeclareDMintConverter({t.repr})\n\
    \"\"\")\n \nproc `*=`(self:var ModIntC, a:SomeIntC) =\n  when self is ModInt:\n\
    \    self.v = (self.v.int * self.init(a).v.int mod self.getMod().int).int32\n\
    \  else:\n    self.v = fastMod(self.v.int * self.init(a).v.int, self.getMod().uint32).int32\n\
    proc `==`(a:ModIntC, b:SomeIntC):bool = a.v == a.init(b).v\nproc `!=`(a:ModIntC,\
    \ b:SomeIntC):bool = a.v != a.init(b).v\nproc `-`(self:ModIntC):auto =\n  if self.v\
    \ == 0: return self\n  else: return self.init(self.getMod() - self.v)\nproc `$`(a:ModIntC):string\
    \ = return $(a.v)\n \nproc `+=`(self:var ModIntC; a:SomeIntC) =\n  self.v += self.init(a).v\n\
    \  if self.v >= self.getMod(): self.v -= self.getMod()\nproc `-=`(self:var ModIntC,\
    \ a:SomeIntC) =\n  self.v -= self.init(a).v\n  if self.v < 0: self.v += self.getMod()\n\
    proc `^=`(self:var ModIntC, n:SomeInteger) =\n  var (x,n,a) = (self,n,self.Identity)\n\
    \  while n > 0:\n    if (n and 1) > 0: a *= x\n    x *= x\n    n = (n shr 1)\n\
    \  swap(self, a)\nproc inv(self: ModIntC):auto =\n  var\n    a = self.v.int\n\
    \    b = self.getMod().int\n    u = 1\n    v = 0\n  while b > 0:\n    let t =\
    \ a div b\n    a -= t * b;swap(a, b)\n    u -= t * v;swap(u, v)\n  return self.init(u)\n\
    proc `/=`(a:var ModIntC,b:SomeIntC) = a *= a.init(b).inv()\nproc `+`(a:ModIntC,b:SomeIntC):auto\
    \ = result = a;result += b\nproc `-`(a:ModIntC,b:SomeIntC):auto = result = a;result\
    \ -= b\nproc `*`(a:ModIntC,b:SomeIntC):auto = result = a;result *= b\nproc `/`(a:ModIntC,b:SomeIntC):auto\
    \ = result = a;result /= b\nproc `^`(a:ModIntC,b:SomeInteger):auto = result =\
    \ a;result ^= b\n# }}}\n# }}}\n"
  dependsOn: []
  isVerificationFile: false
  path: src/nim_acl/mod_int.nim
  requiredBy: []
  timestamp: '2020-09-13 17:59:04+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/nim_acl/mod_int.nim
layout: document
redirect_from:
- /library/src/nim_acl/mod_int.nim
- /library/src/nim_acl/mod_int.nim.html
title: src/nim_acl/mod_int.nim
---
