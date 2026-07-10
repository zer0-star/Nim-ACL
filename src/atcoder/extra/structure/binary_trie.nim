when not declared ATCODER_EXTRA_STRUCTURE_BINARY_TRIE_HPP:
  const ATCODER_EXTRA_STRUCTURE_BINARY_TRIE_HPP* = 1

  type
    BinaryTrieNode* = object
      child*: array[2, int]
      count*: int

    BinaryTrie*[T: SomeInteger] = object
      maxLog*: int
      nodes*: seq[BinaryTrieNode]

  proc newBinaryTrieNode(): BinaryTrieNode =
    result.child[0] = -1
    result.child[1] = -1
    result.count = 0

  proc initBinaryTrie*[T: SomeInteger](maxLog: int = 60): BinaryTrie[T] =
    ## Creates an empty binary trie.
    ##
    ## `maxLog` is the highest bit index to inspect.
    ## For example, `maxLog = 30` handles values in `[0, 2^31)`.
    doAssert 0 <= maxLog and maxLog < 64
    result.maxLog = maxLog
    result.nodes = @[newBinaryTrieNode()]

  proc len*[T: SomeInteger](tr: BinaryTrie[T]): int {.inline.} =
    tr.nodes[0].count

  proc empty*[T: SomeInteger](tr: BinaryTrie[T]): bool {.inline.} =
    tr.len == 0

  proc bitAt[T: SomeInteger](x: T, b: int): int {.inline.} =
    int((uint64(x) shr b) and 1'u64)

  proc add*[T: SomeInteger](tr: var BinaryTrie[T], x: T, c: int) =
    ## Adds `c` copies of `x`.
    doAssert c >= 0
    if c == 0: return

    var v = 0
    tr.nodes[v].count += c

    for b in countdown(tr.maxLog, 0):
      let k = bitAt(x, b)
      if tr.nodes[v].child[k] < 0:
        tr.nodes[v].child[k] = tr.nodes.len
        tr.nodes.add newBinaryTrieNode()

      v = tr.nodes[v].child[k]
      tr.nodes[v].count += c

  proc insert*[T: SomeInteger](tr: var BinaryTrie[T], x: T) =
    ## Inserts one copy of `x`.
    tr.add(x, 1)

  proc count*[T: SomeInteger](tr: BinaryTrie[T], x: T): int =
    ## Returns the multiplicity of `x`.
    var v = 0

    for b in countdown(tr.maxLog, 0):
      let k = bitAt(x, b)
      let nxt = tr.nodes[v].child[k]

      if nxt < 0:
        return 0

      v = nxt

    tr.nodes[v].count

  proc contains*[T: SomeInteger](tr: BinaryTrie[T], x: T): bool =
    tr.count(x) > 0

  proc erase*[T: SomeInteger](tr: var BinaryTrie[T], x: T, c: int = 1) =
    ## Erases `c` copies of `x`.
    doAssert c >= 0
    if c == 0: return
    doAssert tr.count(x) >= c

    var v = 0
    tr.nodes[v].count -= c

    for b in countdown(tr.maxLog, 0):
      let k = bitAt(x, b)
      v = tr.nodes[v].child[k]
      tr.nodes[v].count -= c

  proc bestElementXor[T: SomeInteger](tr: BinaryTrie[T], x: T, maximize: bool): T =
    doAssert not tr.empty()

    var
      v = 0
      y = 0'u64

    for b in countdown(tr.maxLog, 0):
      let xb = bitAt(x, b)
      var take = if maximize: 1 - xb else: xb
      var nxt = tr.nodes[v].child[take]

      if nxt < 0 or tr.nodes[nxt].count <= 0:
        take = 1 - take
        nxt = tr.nodes[v].child[take]

      doAssert nxt >= 0
      doAssert tr.nodes[nxt].count > 0

      if take == 1:
        y = y or (1'u64 shl b)

      v = nxt

    T(y)

  proc minElementXor*[T: SomeInteger](tr: BinaryTrie[T], x: T): T =
    ## Returns an element `y` in the trie minimizing `x xor y`.
    tr.bestElementXor(x, false)

  proc maxElementXor*[T: SomeInteger](tr: BinaryTrie[T], x: T): T =
    ## Returns an element `y` in the trie maximizing `x xor y`.
    tr.bestElementXor(x, true)

  proc minXor*[T: SomeInteger](tr: BinaryTrie[T], x: T): T =
    ## Returns the minimum value of `x xor y` over stored elements `y`.
    let y = tr.minElementXor(x)
    T(uint64(x) xor uint64(y))

  proc maxXor*[T: SomeInteger](tr: BinaryTrie[T], x: T): T =
    ## Returns the maximum value of `x xor y` over stored elements `y`.
    let y = tr.maxElementXor(x)
    T(uint64(x) xor uint64(y))
