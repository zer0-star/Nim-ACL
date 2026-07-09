when not declared ATCODER_TEST_EXTRA_ARBITRARY_MOD_COMBINATION:
  const ATCODER_TEST_EXTRA_ARBITRARY_MOD_COMBINATION* = 1

  import std/unittest
  import atcoder/extra/math/arbitrary_mod_combination

  proc bruteCMod(n, r0, md: int): int =
    if md == 1:
      return 0

    if r0 < 0 or n < r0:
      return 0

    var r = min(r0, n - r0)
    var ans = 1

    for i in 1 .. r:
      ans = ans * (n - r + i) div i

    return ans mod md

  suite "extra math arbitrary_mod_combination":
    test "C works for composite moduli":
      let cases = @[
        (10, 5, 2),
        (10, 6, 2),
        (12, 8, 3),
        (1000, 20, 10),
        (998244352, 12, 5),
      ]

      for c in cases:
        let (md, n, r) = c
        let binom = initArbitraryModBinomial(md, 100)

        check binom.C(n, r) == bruteCMod(n, r, md)

    test "C handles prime modulus":
      let binom = initArbitraryModBinomial(13, 100)

      check binom.C(10, 3) == 120 mod 13
      check binom.C(12, 6) == 924 mod 13

    test "C handles out of range arguments":
      let binom = initArbitraryModBinomial(1000, 100)

      check binom.C(5, -1) == 0
      check binom.C(5, 6) == 0
      check binom.C(-1, 0) == 0

    test "modulo one is always zero":
      let binom = initArbitraryModBinomial(1, 10)

      check binom.C(0, 0) == 0
      check binom.C(10, 3) == 0
