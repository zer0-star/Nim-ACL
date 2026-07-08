discard """
  cmd: "nim cpp -r $file"
"""

import std/unittest
import atcoder/extra/math/fps

type mint = modint998244353

useFPS(mint{x}, F, prec = 8)
useFPS(mint{y}, G, prec = 5)
useFPSDecl("H = mint{z}", prec = 6)
useFPSDecl(K = mint{w}, prec = 7)
useFPSDecl("L = mint<t>", prec = 9)
useFPSDecl("M=mint<u>", prec = 10)

suite "fps facade":
  test "constructor uses default precision":
    let f = F(@[0, 1])
    check f.len == 8
    check f[0] == mint(0)
    check f[1] == mint(1)
    check f[7] == mint(0)

  test "explicit constructor precision overrides default precision":
    let f = F(@[0, 1], 3)
    check f.len == 3
    check f[0] == mint(0)
    check f[1] == mint(1)

  test "omitted precision in fps methods follows series length":
    let f = F(@[0, 1])
    let g = f.exp()
    check g.len == 8
    check g[0] == mint(1)
    check g[1] == mint(1)

  test "explicit precision in fps methods still overrides":
    let f = F(@[0, 1])
    let g = f.exp(4)
    check g.len == 4
    check g[0] == mint(1)
    check g[1] == mint(1)

  test "custom variable name via mint{y}":
    let h = G(y)
    check h.len == 5
    check h[0] == mint(0)
    check h[1] == mint(1)

  test "SageMath-like declaration helper":
    let h = H(z)
    check h.len == 6
    check h[0] == mint(0)
    check h[1] == mint(1)

  test "SageMath-like declaration helper with exp":
    let h = H(z)
    let e = h.exp()
    check e.len == 6
    check e[0] == mint(1)
    check e[1] == mint(1)

  test "SageMath-like unquoted declaration helper":
    let k = K(w)
    check k.len == 7
    check k[0] == mint(0)
    check k[1] == mint(1)

  test "SageMath-like unquoted declaration helper with exp":
    let k = K(w)
    let e = k.exp()
    check e.len == 7
    check e[0] == mint(1)
    check e[1] == mint(1)

  test "SageMath-like angle string declaration helper":
    let l = L(t)
    check l.len == 9
    check l[0] == mint(0)
    check l[1] == mint(1)

  test "SageMath-like angle string declaration helper without spaces":
    let m = M(u)
    check m.len == 10
    check m[0] == mint(0)
    check m[1] == mint(1)

