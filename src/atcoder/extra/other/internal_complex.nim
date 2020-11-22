#
#
#            Nim's Runtime Library
#        (c) Copyright 2010 Andreas Rumpf
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

## This module implements complex numbers.
## Complex numbers are currently implemented as generic on a 64-bit or 32-bit float.

{.push checks: off, line_dir: off, stack_trace: off, debugger: off.}
# the user does not want to trace a part of the standard library!

import math

type
  Complex*[T] = object
    re*, im*: T
    ## A complex number, consisting of a real and an imaginary part.

proc complex*[T](re: T; im: T = T(0)): Complex[T] =
  result.re = re
  result.im = im

template im*[T](arg: typedesc[T]): Complex[T] = complex[T](0, 1)

proc abs*[T](z: Complex[T]): T =
  ## Return the distance from (0,0) to ``z``.
  result = hypot(z.re, z.im)

proc abs2*[T](z: Complex[T]): T =
  ## Return the squared distance from (0,0) to ``z``.
  result = z.re*z.re + z.im*z.im

proc conjugate*[T](z: Complex[T]): Complex[T] =
  ## Conjugate of complex number ``z``.
  result.re = z.re
  result.im = -z.im

proc inv*[T](z: Complex[T]): Complex[T] =
  ## Multiplicative inverse of complex number ``z``.
  conjugate(z) / abs2(z)

proc `==` *[T](x, y: Complex[T]): bool =
  ## Compare two complex numbers ``x`` and ``y`` for equality.
  result = x.re == y.re and x.im == y.im

proc `+` *[T](x: T; y: Complex[T]): Complex[T] =
  ## Add a real number to a complex number.
  result.re = x + y.re
  result.im = y.im

proc `+` *[T](x: Complex[T]; y: T): Complex[T] =
  ## Add a complex number to a real number.
  result.re = x.re + y
  result.im = x.im

proc `+` *[T](x, y: Complex[T]): Complex[T] =
  ## Add two complex numbers.
  result.re = x.re + y.re
  result.im = x.im + y.im

proc `-` *[T](z: Complex[T]): Complex[T] =
  ## Unary minus for complex numbers.
  result.re = -z.re
  result.im = -z.im

proc `-` *[T](x: T; y: Complex[T]): Complex[T] =
  ## Subtract a complex number from a real number.
  x + (-y)

proc `-` *[T](x: Complex[T]; y: T): Complex[T] =
  ## Subtract a real number from a complex number.
  result.re = x.re - y
  result.im = x.im

proc `-` *[T](x, y: Complex[T]): Complex[T] =
  ## Subtract two complex numbers.
  result.re = x.re - y.re
  result.im = x.im - y.im

proc `/` *[T](x: Complex[T]; y: T): Complex[T] =
  ## Divide complex number ``x`` by real number ``y``.
  result.re = x.re / y
  result.im = x.im / y

proc `/` *[T](x: T; y: Complex[T]): Complex[T] =
  ## Divide real number ``x`` by complex number ``y``.
  result = x * inv(y)

proc `/` *[T](x, y: Complex[T]): Complex[T] =
  ## Divide ``x`` by ``y``.
  var r, den: T
  if abs(y.re) < abs(y.im):
    r = y.re / y.im
    den = y.im + r * y.re
    result.re = (x.re * r + x.im) / den
    result.im = (x.im * r - x.re) / den
  else:
    r = y.im / y.re
    den = y.re + r * y.im
    result.re = (x.re + r * x.im) / den
    result.im = (x.im - r * x.re) / den

proc `*` *[T](x: T; y: Complex[T]): Complex[T] =
  ## Multiply a real number and a complex number.
  result.re = x * y.re
  result.im = x * y.im

proc `*` *[T](x: Complex[T]; y: T): Complex[T] =
  ## Multiply a complex number with a real number.
  result.re = x.re * y
  result.im = x.im * y

proc `*` *[T](x, y: Complex[T]): Complex[T] =
  ## Multiply ``x`` with ``y``.
  result.re = x.re * y.re - x.im * y.im
  result.im = x.im * y.re + x.re * y.im


proc `+=` *[T](x: var Complex[T]; y: Complex[T]) =
  ## Add ``y`` to ``x``.
  x.re += y.re
  x.im += y.im

proc `-=` *[T](x: var Complex[T]; y: Complex[T]) =
  ## Subtract ``y`` from ``x``.
  x.re -= y.re
  x.im -= y.im

proc `*=` *[T](x: var Complex[T]; y: Complex[T]) =
  ## Multiply ``y`` to ``x``.
  let im = x.im * y.re + x.re * y.im
  x.re = x.re * y.re - x.im * y.im
  x.im = im

proc `/=` *[T](x: var Complex[T]; y: Complex[T]) =
  ## Divide ``x`` by ``y`` in place.
  x = x / y


proc sqrt*[T](z: Complex[T]): Complex[T] =
  ## Square root for a complex number ``z``.
  var x, y, w, r: T

  if z.re == T(0) and z.im == T(0):
    result = z
  else:
    x = abs(z.re)
    y = abs(z.im)
    if x >= y:
      r = y / x
      w = sqrt(x) * sqrt((T(1) + sqrt(T(1) + r * r)) / T(2))
    else:
      r = x / y
      w = sqrt(y) * sqrt((r + sqrt(T(1) + r * r)) / T(2))

    if z.re >= T(0):
      result.re = w
      result.im = z.im / (w * T(2))
    else:
      result.im = if z.im >= T(0): w else: -w
      result.re = z.im / (result.im + result.im)

proc exp*[T](z: Complex[T]): Complex[T] =
  ## ``e`` raised to the power ``z``.
  var
    rho = exp(z.re)
    theta = z.im
  result.re = rho * cos(theta)
  result.im = rho * sin(theta)

proc ln*[T](z: Complex[T]): Complex[T] =
  ## Returns the natural log of ``z``.
  result.re = ln(abs(z))
  result.im = arctan2(z.im, z.re)

proc log10*[T](z: Complex[T]): Complex[T] =
  ## Returns the log base 10 of ``z``.
  result = ln(z) / ln(T(10))

proc log2*[T](z: Complex[T]): Complex[T] =
  ## Returns the log base 2 of ``z``.
  result = ln(z) / ln(T(2))

proc pow*[T](x, y: Complex[T]): Complex[T] =
  ## ``x`` raised to the power ``y``.
  if x.re == T(0) and x.im == T(0):
    if y.re == T(0) and y.im == T(0):
      result.re = T(1)
      result.im = T(0)
    else:
      result.re = T(0)
      result.im = T(0)
  elif y.re == T(1) and y.im == T(0):
    result = x
  elif y.re == -T(1) and y.im == T(0):
    result = T(1) / x
  else:
    var
      rho = abs(x)
      theta = arctan2(x.im, x.re)
      s = pow(rho, y.re) * exp(-y.im * theta)
      r = y.re * theta + y.im * ln(rho)
    result.re = s * cos(r)
    result.im = s * sin(r)

proc pow*[T](x: Complex[T]; y: T): Complex[T] =
  ## Complex number ``x`` raised to the power ``y``.
  pow(x, complex[T](y))


proc sin*[T](z: Complex[T]): Complex[T] =
  ## Returns the sine of ``z``.
  result.re = sin(z.re) * cosh(z.im)
  result.im = cos(z.re) * sinh(z.im)

proc arcsin*[T](z: Complex[T]): Complex[T] =
  ## Returns the inverse sine of ``z``.
  result = -im(T) * ln(im(T) * z + sqrt(T(1) - z*z))

proc cos*[T](z: Complex[T]): Complex[T] =
  ## Returns the cosine of ``z``.
  result.re = cos(z.re) * cosh(z.im)
  result.im = -sin(z.re) * sinh(z.im)

proc arccos*[T](z: Complex[T]): Complex[T] =
  ## Returns the inverse cosine of ``z``.
  result = -im(T) * ln(z + sqrt(z*z - T(1)))

proc tan*[T](z: Complex[T]): Complex[T] =
  ## Returns the tangent of ``z``.
  result = sin(z) / cos(z)

proc arctan*[T](z: Complex[T]): Complex[T] =
  ## Returns the inverse tangent of ``z``.
  result = im(T) * (ln(T(1) - im(T)*z) - ln(T(1) + im(T)*z)) / T(2)

proc cot*[T](z: Complex[T]): Complex[T] =
  ## Returns the cotangent of ``z``.
  result = cos(z)/sin(z)

proc arccot*[T](z: Complex[T]): Complex[T] =
  ## Returns the inverse cotangent of ``z``.
  result = im(T) * (ln(T(1) - im(T)/z) - ln(T(1) + im(T)/z)) / T(2)

proc sec*[T](z: Complex[T]): Complex[T] =
  ## Returns the secant of ``z``.
  result = T(1) / cos(z)

proc arcsec*[T](z: Complex[T]): Complex[T] =
  ## Returns the inverse secant of ``z``.
  result = -im(T) * ln(im(T) * sqrt(T(1) - T(1)/(z*z)) + T(1)/z)

proc csc*[T](z: Complex[T]): Complex[T] =
  ## Returns the cosecant of ``z``.
  result = T(1) / sin(z)

proc arccsc*[T](z: Complex[T]): Complex[T] =
  ## Returns the inverse cosecant of ``z``.
  result = -im(T) * ln(sqrt(T(1) - T(1)/(z*z)) + im(T)/z)

proc sinh*[T](z: Complex[T]): Complex[T] =
  ## Returns the hyperbolic sine of ``z``.
  result = (exp(z) - exp(-z)) / T(2)

proc arcsinh*[T](z: Complex[T]): Complex[T] =
  ## Returns the inverse hyperbolic sine of ``z``.
  result = ln(z + sqrt(z*z + T(1)))

proc cosh*[T](z: Complex[T]): Complex[T] =
  ## Returns the hyperbolic cosine of ``z``.
  result = (exp(z) + exp(-z)) / T(2)

proc arccosh*[T](z: Complex[T]): Complex[T] =
  ## Returns the inverse hyperbolic cosine of ``z``.
  result = ln(z + sqrt(z*z - T(1)))

proc tanh*[T](z: Complex[T]): Complex[T] =
  ## Returns the hyperbolic tangent of ``z``.
  result = sinh(z) / cosh(z)

proc arctanh*[T](z: Complex[T]): Complex[T] =
  ## Returns the inverse hyperbolic tangent of ``z``.
  result = (ln((T(1)+z) / (T(1)-z))) / T(2)

proc sech*[T](z: Complex[T]): Complex[T] =
  ## Returns the hyperbolic secant of ``z``.
  result = T(2) / (exp(z) + exp(-z))

proc arcsech*[T](z: Complex[T]): Complex[T] =
  ## Returns the inverse hyperbolic secant of ``z``.
  result = ln(T(1)/z + sqrt(T(1)/z+T(1)) * sqrt(T(1)/z-T(1)))

proc csch*[T](z: Complex[T]): Complex[T] =
  ## Returns the hyperbolic cosecant of ``z``.
  result = T(2) / (exp(z) - exp(-z))

proc arccsch*[T](z: Complex[T]): Complex[T] =
  ## Returns the inverse hyperbolic cosecant of ``z``.
  result = ln(T(1)/z + sqrt(T(1)/(z*z) + T(1)))

proc coth*[T](z: Complex[T]): Complex[T] =
  ## Returns the hyperbolic cotangent of ``z``.
  result = cosh(z) / sinh(z)

proc arccoth*[T](z: Complex[T]): Complex[T] =
  ## Returns the inverse hyperbolic cotangent of ``z``.
  result = (ln(T(1) + T(1)/z) - ln(T(1) - T(1)/z)) / T(2)

proc phase*[T](z: Complex[T]): T =
  ## Returns the phase of ``z``.
  arctan2(z.im, z.re)

proc polar*[T](z: Complex[T]): tuple[r, phi: T] =
  ## Returns ``z`` in polar coordinates.
  (r: abs(z), phi: phase(z))

proc rect*[T](r, phi: T): Complex[T] =
  ## Returns the complex number with polar coordinates ``r`` and ``phi``.
  ##
  ## | ``result.re = r * cos(phi)``
  ## | ``result.im = r * sin(phi)``
  complex(r * cos(phi), r * sin(phi))


proc `$`*(z: Complex): string =
  ## Returns ``z``'s string representation as ``"(re, im)"``.
  result = "(" & $z.re & ", " & $z.im & ")"

{.pop.}
