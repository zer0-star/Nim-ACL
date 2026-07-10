when not declared ATCODER_EXTRA_JA_STRUCTURE_DSU_HPP:
  const ATCODER_EXTRA_JA_STRUCTURE_DSU_HPP* = 1

  import atcoder/dsu

  export dsu

  type
    素集合データ構造* = DSU

  proc 素集合データ構造を初期化*(
      n: int,
  ): 素集合データ構造 {.inline.} =
    ## `initDSU(n)` の日本語別名です。

    initDSU(n)

  proc 代表元*(
      self: 素集合データ構造,
      a: int,
  ): int {.inline.} =
    ## `a` が属する集合の代表元を返します。

    self.leader(a)

  proc 同じ集合か*(
      self: 素集合データ構造,
      a,
      b: int,
  ): bool {.inline.} =
    ## `a` と `b` が同じ集合に属するかを返します。

    self.same(a, b)

  proc 集合の大きさ*(
      self: 素集合データ構造,
      a: int,
  ): int {.inline.} =
    ## `a` が属する集合の要素数を返します。

    self.size(a)

  proc 併合*(
      self: 素集合データ構造,
      a,
      b: int,
  ): int {.inline, discardable.} =
    ## `a` と `b` の集合を併合し、代表元を返します。

    self.merge(a, b)

  proc 集合一覧*(
      self: 素集合データ構造,
  ): seq[seq[int]] {.inline.} =
    ## 全集合を頂点列の列として返します。

    self.groups()
