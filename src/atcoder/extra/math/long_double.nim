# f128.nim: c long double  wrapper w/ complex numbers, cpp backend

{.passL: "-lm".} # link with -lm

{.emit: "#include<cstdio>".}
type f128* {.importcpp: "long double".} = object
#const math_header = "<math.h>"
const math_header = "<cmath>"

# wrap
{.push inline.}

proc `+`*(x, y: f128): f128 {.importcpp:"# + #", header: math_header.}
proc `-`*(x, y: f128): f128 {.importcpp:"# - #", header: math_header.}
proc `-`*(x: f128): f128  {.importcpp:"- #", header: math_header.}
proc `*`*(x, y: f128): f128 {.importcpp:"# * #", header: math_header.}
proc `/`*(x, y: f128): f128 {.importcpp:"# / #", header: math_header.}
proc `^`*(x, y: f128): f128{.importcpp:"pow(@)", header: math_header.}

proc `+=`*(x: var f128, y: f128) {.importcpp:"# += #", header: math_header.}
proc `-=`*(x: var f128, y: f128) {.importcpp:"# -= #", header: math_header.}
proc `*=`*(x: var f128, y: f128) {.importcpp:"# *= #", header: math_header.}
proc `/=`*(x: var f128, y: f128) {.importcpp:"# /= #", header: math_header.}

proc `==`*(x, y: f128): bool {.importcpp:"# == #", header: math_header.}
proc `!=`*(x, y: f128): bool {.importcpp:"# != #", header: math_header.}
proc `>=`*(x, y: f128): bool {.importcpp:"# >= #", header: math_header.}
proc `<=`*(x, y: f128): bool {.importcpp:"# <= #", header: math_header.}
proc `>`*(x, y: f128): bool {.importcpp:"# > #", header: math_header.}
proc `<`*(x, y: f128): bool {.importcpp:"# < #", header: math_header.}

proc sin*(x: f128): f128 {.importcpp: "sin(#)", header: math_header.}
proc cos*(x: f128): f128 {.importcpp: "cos(#)", header: math_header.}
proc tan*(x: f128): f128 {.importcpp: "tan(#)", header: math_header.}
proc sinh*(x: f128): f128 {.importcpp: "sinh(#)", header: math_header.}
proc cosh*(x: f128): f128 {.importcpp: "cosh(#)", header: math_header.}
proc tanh*(x: f128): f128 {.importcpp: "tanh(#)", header: math_header.}
proc asin*(x: f128): f128 {.importcpp: "asin(#)", header: math_header.}
proc acos*(x: f128): f128 {.importcpp: "acos(#)", header: math_header.}
proc atan*(x: f128): f128 {.importcpp: "atan(#)", header: math_header.}
proc atan2*(x, y: f128): f128 {.importcpp: "atan2(@)", header: math_header.}

proc pow*(x, y: f128): f128 {.importcpp: "pow(#)", header: math_header.}
proc exp*(x: f128): f128 {.importcpp: "exp(#)", header: math_header.}
proc log*(x: f128): f128 {.importcpp: "log(#)", header: math_header.}
proc log10*(x: f128): f128 {.importcpp: "log10(#)", header: math_header.}
proc sqrt*(x: f128): f128 {.importcpp: "sqrt(#)", header: math_header.}

proc floor*(x: f128): f128 {.importcpp: "floor(#)", header: math_header.}
proc ceil*(x: f128): f128 {.importcpp: "ceil(#)", header: math_header.}
proc abs*(x: f128): f128 {.importcpp: "fabs(#)", header: math_header.}

proc lmod*(x: f128): (f128, int) =
  var
    i: float
    fract: f128
  {.emit: "fract=modf(x, &i);".}
  (fract, i.int)

# conversions
converter fto128*(f: float) : f128 {.importcpp: "(long double)#", header: math_header.}
converter ito128*(i: int)   : f128 {.importcpp: "(long double)#", header: math_header.}
converter sto128*(s: cstring): f128 {.importcpp: "strtold (#, NULL);", header: "<stdlib.h>".}

#converter f128tof*(f:f128):float {.importcpp: "(double)#", header: math_header.}

proc sign*(x: f128): int =
  if x<0: -1
  elif x>0: 1
  else: 0

{.pop.}

# std::complex wrapper

type Complex[T] {.header:"<complex>", importcpp: "std::complex<'0>".} = object 
  re, im : T


proc complex*[T](re, im:T):Complex[T] {.importcpp: "'0 (@)".}

proc `+`*[T](a,b:Complex[T]):Complex[T] {.importcpp:"# + #".}
proc `-`*[T](a,b:Complex[T]):Complex[T] {.importcpp:"# - #".}
proc `-`*[T](a:Complex[T]):Complex[T] {.importcpp:"-#".}
proc `*`*[T](a,b:Complex[T]):Complex[T] {.importcpp:"# * #".}
proc `/`*[T](a,b:Complex[T]):Complex[T] {.importcpp:"# / #".}

proc `+=`*[T](a,b:Complex[T]) {.importcpp:"# += #".}
proc `-=`*[T](a,b:Complex[T]) {.importcpp:"# -= #".}
proc `*=`*[T](a,b:Complex[T]) {.importcpp:"# *= #".}
proc `/=`*[T](a,b:Complex[T]) {.importcpp:"# /= #".}

proc `==`*[T](a,b:Complex[T]):bool {.importcpp:"# == #".}
proc `!=`*[T](a,b:Complex[T]):bool {.importcpp:"# != #".}

proc real*[T](z:Complex[T]):T {.importcpp: "#.real()".}
proc imag*[T](z:Complex[T]):T {.importcpp: "#.imag()".}
proc abs*[T](z:Complex[T]):T {.importcpp: "abs(#)".}
proc arg*[T](z:Complex[T]):T {.importcpp: "std::arg(#)".}
proc norm*[T](z:Complex[T]):T {.importcpp: "std::norm(#)".}
proc conj*[T](z:Complex[T]):Complex[T] {.importcpp: "std::conj(#)".}
proc proj*[T](z:Complex[T]):Complex[T] {.importcpp: "std::proj(#)".}
proc polar*[T](r, theta:T):Complex[T] {.importcpp: "std::polar(@)".}

proc exp*[T](z:Complex[T]):Complex[T] {.importcpp: "std::exp(#)".}
proc log*[T](z:Complex[T]):Complex[T] {.importcpp: "std::log(#)".}
proc log10*[T](z:Complex[T]):Complex[T] {.importcpp: "std::log10(#)".}

proc pow*[T](z,y:Complex[T]):Complex[T] {.importcpp: "std::pow(@)".}

proc sin*[T](z:Complex[T]):Complex[T] {.importcpp: "std::sin(#)".}
proc cos*[T](z:Complex[T]):Complex[T] {.importcpp: "std::cos(#)".}
proc tan*[T](z:Complex[T]):Complex[T] {.importcpp: "std::tan(#)".}
proc asin*[T](z:Complex[T]):Complex[T] {.importcpp: "std::asin(#)".}
proc acos*[T](z:Complex[T]):Complex[T] {.importcpp: "std::acos(#)".}
proc atan*[T](z:Complex[T]):Complex[T] {.importcpp: "std::atan(#)".}

proc sinh*[T](z:Complex[T]):Complex[T] {.importcpp: "std::sinh(#)".}
proc cosh*[T](z:Complex[T]):Complex[T] {.importcpp: "std::cosh(#)".}
proc tanh*[T](z:Complex[T]):Complex[T] {.importcpp: "std::tanh(#)".}
proc asinh*[T](z:Complex[T]):Complex[T] {.importcpp: "std::asinh(#)".}
proc acosh*[T](z:Complex[T]):Complex[T] {.importcpp: "std::acosh(#)".}
proc atanh*[T](z:Complex[T]):Complex[T] {.importcpp: "std::atanh(#)".}

proc `$`*[T](z:Complex[T]):string = "(" & $(z.real()) & ", " & $(z.imag()) & ")"

# end std::complex

proc `$`*(x: f128): string =
  var
    conv_buff: array[128, char]
    cl: cint = conv_buff.high

  {.emit: " cl = snprintf(conv_buff, cl, \"%Le\", x); ".}
  for i in 0..<cl: result.add(conv_buff[i])


# factorial
proc `!`*(n: int): f128 =
  if n > 0: n.f128 * !(n-1) else: 1.0

# test

when isMainModule:
  proc test_f128=
    var f0, f1, f2: f128

    f1 = 1
    f2 = 2.0
    f1 = "1".cstring

    echo "1+2=", 1.0.fto128 + 2.0.fto128
    echo "f1=", f1, ", f2=", f2, ", f1+f2", f1+f2, ", 123+111.11=", (123.0.fto128 + 111.11.fto128)
    echo f1+f2,"==",123.45.f128 + 456.78.f128, ":", f1+f2==(123.45.f128 + 456.78.f128)
    var ff0 =  (f1+f2) - (2.0.f128 + 5.1.f128)
    echo ff0

    # assert comps
    assert f1 != f2
    assert f1 == f1
    assert f2 >= f1
    assert f2 > f1
    assert f1 < f2
    assert f1 <= f2

    # assert algebra
    assert f1+f2 == 1.f128 + 2.f128, "+ doesn't work"
    assert f1-f2 == f1-f2, "- doesn't work"
    assert f1*f2 == f1*f2, "* doesn't work"
    assert f1/f2 == f1/f2, "/ doesn't work"
    assert f1+f2 != (123.45 + 456.78).f128

    f1+=f2
    echo "+=", f1, "==", 123.45+456.78

    f0 = f1+f2*f1
    echo "f0=f1+f2*f1=", f0, ", f1=", f1, ", f2=", f2
    echo "factorial(900) * 4 = ", !900 * 4
    f1 = f1^(f2/10)
    echo "f1.some func = ", f1.sin.sinh.atan.floor.exp.log
    f2 = 123.456.f128.sqrt
    f0 = -678.89.f128
    echo f0, ", ", f0.abs
    echo 123.456.sqrt, ", ", f2.abs
    echo f2, ", ", f2.lmod

    echo "atan2=", atan2(f1,f2)

    # seq's
    var sf: seq[f128]

    for i in 0..100:
      var f: f128
      case i %% 3:
        of 0: f = f0
        of 1: f = f1
        of 2: f = f2
        else: f = f0
      sf.add(f)
    echo sf[0..10], sf[sf.high-10..sf.high]

  import times, sugar, strutils

  proc test_c128=
    type c128=Complex[f128]
    proc complex128(r,i:f128):c128=complex[f128](r,i)

    var
      c0 = complex128(1, 0)
      z = c0
      zv = newSeq[c128](100)

    # init all items in vect, notice that z=c0 will not work
    for z in zv.mitems: z = c0

    let zzv = collect(newSeq):
      for i in 0..100:
        z
    for zz in zzv: z+=zz
    echo "z=", z
    z = c0

    c0+=complex128(123.67, 123.67)
    let n = 10000
    echo "generating c128 ", n*n

    var t0 = now()
    for i in 0..n*n: # simulate mandelbrot fractal generation
      z = c0 + complex128(i.float, i.float)
      for it in 0..200:
        z = z*z+c0
        if z.abs > 4.0: break
    echo z
    echo n*n, " iters, lap c128:", (now()-t0).inMilliseconds, "ms"

    var
      dz = complex[float](1, 0)
      dc0 = dz

    dc0 += complex[float](123.67, 123.67)

    t0 = now()
    for i in 0..n*n:
      dz = dc0 + complex[float](i.float, i.float)
      for it in 0..200:
        dz = dz*dz+dc0
        if dz.abs > 4.0: break
    echo dz
    echo "lap complex 64:", (now()-t0).inMilliseconds, "ms"

  echo "=".repeat(50), " f128 test "
  test_f128()
  echo "-".repeat(50), " c128 test "
  test_c128()
