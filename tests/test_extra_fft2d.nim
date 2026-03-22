import atcoder/modint
import atcoder/extra/math/ntt
import atcoder/extra/math/formal_power_series
import ./fft2d
import atcoder/extra/math/combination
import std/sequtils
import std/unittest

type mint = modint998244353
import random

proc randMint():mint =
  mint(random.rand(0 ..< 998244353))

test "FFT2DTest, SMALL":
  for t in 0 ..< 10000:
    let Ha, Hb, Wa, Wb = random.rand(0 ..< 20)

    var
      a = newSeqWith(Ha, initFormalPowerSeries[mint](Wa))
      b = newSeqWith(Hb, initFormalPowerSeries[mint](Wb))
    for v in a.mitems:
      for x in v.mitems:
        x = randMint()
    for v in b.mitems:
      for x in v.mitems:
        x = randMint()

    let
      c1 = multiply2d_naive(a, b)
      c2 = multiply2d_partially_naive(a, b)
      c3 = multiply2d(a, b)
    check c1 == c2
    check c2 == c3

test "FFT2DTest, MIDDLE":

  for t in 0 ..< 50:
    let
      Ha, Hb, Wa, Wb = random.rand(60 ..< 70)
    var
      a = newSeqWith(Ha, initFormalPowerSeries[mint](Wa))
      b = newSeqWith(Hb, initFormalPowerSeries[mint](Wb))
    for v in a.mitems:
      for x in v.mitems:
        x = randMint()
    for v in b.mitems:
      for x in v.mitems:
        x = randMint()

    let
      c1 = multiply2d_naive(a, b)
      c2 = multiply2d_partially_naive(a, b)
      c3 = multiply2d(a, b)
    check c1 == c2
    check c2 == c3

test "FFT2DTest, LARGE":
  for t in 0 ..< 200:
    let
      Ha, Hb, Wa, Wb = random.rand(0 ..< 100)
    var
      a = newSeqWith(Ha, initFormalPowerSeries[mint](Wa))
      b = newSeqWith(Hb, initFormalPowerSeries[mint](Wb))
    for v in a.mitems:
      for x in v.mitems:
        x = randMint()
    for v in b.mitems:
      for x in v.mitems:
        x = randMint()

    let
      c1 = multiply2d_naive(a, b)
      c2 = multiply2d_partially_naive(a, b)
      c3 = multiply2d(a, b)
    check c1 == c2
    check c2 == c3
