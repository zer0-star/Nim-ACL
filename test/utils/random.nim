import std/random

var rnd = initRand(2020)

# random choise from [a, b]
proc randint*[T](a, b:T):T =
  rnd.rand(a..b)

proc randbool*():bool = randint(0, 1) == 0

# random choice 2 disjoint elements from [lower, upper]
proc randpair*[T](lower, upper:T):(T, T) =
  assert upper - lower >= 1.T
  var a, b:T
  while true:
    a = randint(lower, upper)
    b = randint(lower, upper)
    if a != b: break
  if a > b: swap(a, b)
  return (a, b)
