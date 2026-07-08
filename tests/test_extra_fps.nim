discard """
  cmd: "nim cpp -r $file"
"""

import std/unittest
import std/options
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

  test "constant constructor uses default precision":
    let f = F(3)
    check f.len == 8
    check f[0] == mint(3)
    check f[1] == mint(0)
    check f[7] == mint(0)

  test "sparse expression constructor uses default precision":
    let f = F(1 + x)
    check f.len == 8
    check f[0] == mint(1)
    check f[1] == mint(1)
    check f[7] == mint(0)

  test "inverse follows default precision through constructor length":
    let f = F(@[1, 1])
    let g = f.inv()
    check g.len == 8
    check g[0] == mint(1)
    check g[1] == -mint(1)

    let h = f * g
    check h[0] == mint(1)
    check h[1] == mint(0)
    check h[2] == mint(0)

  test "arithmetic between default precision series keeps usable length":
    let f = F(@[1, 2])
    let g = F(@[3, 4])
    let h = f + g
    check h.len == 8
    check h[0] == mint(4)
    check h[1] == mint(6)
    check h[7] == mint(0)


  test "sqrt follows default precision through constructor length":
    let f = F(1 + 2 * x + x^2)
    let opt = f.sqrt()
    check opt.isSome

    let g = opt.get
    check g.len == 8
    check g[0] == mint(1)
    check g[1] == mint(1)
    check g[2] == mint(0)
    check g[7] == mint(0)

  test "powMod works with fps facade constructors":
    let base = F(@[0, 1])
    let m = F(@[-1, 0, 0, 1], 4) # x^3 - 1
    let r = base.powMod(5, m)    # x^5 mod (x^3 - 1) = x^2

    check r.len == 3
    check r[0] == mint(0)
    check r[1] == mint(0)
    check r[2] == mint(1)

  test "eval works on default precision series":
    let f = F(@[1, 2, 3])
    check f.len == 8
    check f.eval(mint(2)) == mint(17)



  test "array constructor uses default precision":
    let f = F([1, 2, 3])
    check f.len == 8
    check f[0] == mint(1)
    check f[1] == mint(2)
    check f[2] == mint(3)
    check f[7] == mint(0)

  test "seq of mint constructor uses default precision":
    let f = F(@[mint(1), mint(2), mint(3)])
    check f.len == 8
    check f[0] == mint(1)
    check f[1] == mint(2)
    check f[2] == mint(3)
    check f[7] == mint(0)

  test "copy constructor can override precision":
    let f = F(@[1, 2, 3])
    let g = F(f, 5)
    check g.len == 5
    check g[0] == mint(1)
    check g[1] == mint(2)
    check g[2] == mint(3)
    check g[4] == mint(0)

    let h = F(f, 2)
    check h.len == 2
    check h[0] == mint(1)
    check h[1] == mint(2)

  test "formal variable constructor can override precision":
    let f = F(x, 4)
    check f.len == 4
    check f[0] == mint(0)
    check f[1] == mint(1)
    check f[2] == mint(0)
    check f[3] == mint(0)

  test "string constructor uses default precision":
    let f = F("x")
    check f.len == 8
    check f[0] == mint(0)
    check f[1] == mint(1)
    check f[7] == mint(0)

  test "log exp roundtrip follows default precision":
    let f = F(1 + x)
    let g = f.log()
    let h = g.exp()

    check g.len == 8
    check h.len == 8
    check h[0] == mint(1)
    check h[1] == mint(1)
    check h[2] == mint(0)
    check h[7] == mint(0)

  test "log exp roundtrip with explicit precision override":
    let f = F(1 + x)
    let g = f.log(5)
    let h = g.exp(5)

    check g.len == 5
    check h.len == 5
    check h[0] == mint(1)
    check h[1] == mint(1)
    check h[2] == mint(0)

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

