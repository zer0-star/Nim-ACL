# FPS facade

`atcoder/extra/math/fps` is a convenience facade for modint-based formal power series.

The existing `atcoder/extra/math/formal_power_series` module is kept compatible. If you want to explicitly choose a convolution backend or use more generic coefficient types, import `formal_power_series` directly.

## Import

~~~nim
import atcoder/extra/math/fps
~~~

The `fps` module is intended as a short competitive-programming entry point for modint + NTT based formal power series.

## Basic usage

~~~nim
import atcoder/extra/math/fps

type mint = modint998244353

useFPS(mint{x}, F, prec = 100)

let f = F(@[0, 1]) # resized to length 100
let g = f.exp()    # length 100
let h = f.exp(50)  # explicit length 50 overrides the default
~~~

`useFPS(mint{x}, F, prec = 100)` declares the coefficient type `mint`, the variable name `x`, the constructor name `F`, and the default precision `100`.

## Custom variable name

~~~nim
useFPS(mint{y}, G, prec = 50)

let f = G(y)
~~~

Use `mint{y}` to inject `y` as the formal variable.

## Default precision

When the length is omitted, constructors such as `F(@[...])` and `F(x)` resize the series to the default precision.

~~~nim
useFPS(mint{x}, F, prec = 8)

let f = F(@[0, 1])
doAssert f.len == 8
~~~

An explicit length always overrides the default.

~~~nim
let f = F(@[0, 1], 3)
doAssert f.len == 3
~~~

Existing FPS methods such as `f.exp()` usually use the current length of the input series. Therefore, resizing at construction time makes `f.exp()` use the declared default precision.

## Difference from formal_power_series

- `formal_power_series` is the compatibility-oriented low-level module.
- `fps` is a convenience facade for modint + NTT usage.
- The existing behavior of `formal_power_series` is not changed.

## SageMath-like string declaration

`useFPSDecl` provides a SageMath-like string declaration helper.

~~~nim
useFPSDecl(H = mint{z}, prec = 6)

let f = H(z)
let g = f.exp()
~~~

This declares `H` as the constructor name, `mint` as the coefficient type, `z` as the formal variable name, and `6` as the default precision.

The more basic Nim-style syntax is:

~~~nim
useFPS(mint{z}, H, prec = 6)
~~~

`useFPSDecl` is a convenience helper for readability. If you prefer type resolution and editor support, use `useFPS(mint{z}, H, prec = 6)`.

You can also write the declaration as a string.

~~~nim
useFPSDecl("H = mint{z}", prec = 6)
~~~

