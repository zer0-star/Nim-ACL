when not declared ATCODER_EXTRA_STRING_AHO_CORASICK_HPP:
  const ATCODER_EXTRA_STRING_AHO_CORASICK_HPP* = 1

  type
    AhoCorasickNode* = object
      next*: array[256, int]
      link*: int
      `out`*: seq[int]

    AhoCorasickMatch* = object
      l*, r*, patternId*: int

    AhoCorasick* = object
      nodes*: seq[AhoCorasickNode]
      patternLength*: seq[int]
      built*: bool

  proc initAhoCorasickNode(): AhoCorasickNode =
    for i in 0 ..< 256:
      result.next[i] = -1

    result.link = 0
    result.`out` = @[]

  proc initAhoCorasick*(): AhoCorasick =
    ## Creates an empty Aho-Corasick automaton.
    result.nodes = @[initAhoCorasickNode()]
    result.patternLength = @[]
    result.built = false

  proc addPattern*(ac: var AhoCorasick, pattern: string): int =
    ## Adds a pattern and returns its pattern id.
    ##
    ## Call this before `build`.
    doAssert not ac.built
    doAssert pattern.len > 0

    var v = 0

    for ch in pattern:
      let c = ord(ch)

      if ac.nodes[v].next[c] < 0:
        ac.nodes[v].next[c] = ac.nodes.len
        ac.nodes.add initAhoCorasickNode()

      v = ac.nodes[v].next[c]

    result = ac.patternLength.len
    ac.patternLength.add pattern.len
    ac.nodes[v].`out`.add result

  proc build*(ac: var AhoCorasick) =
    ## Builds failure links and transition table.
    doAssert not ac.built

    var queue: seq[int] = @[]

    for c in 0 ..< 256:
      let to = ac.nodes[0].next[c]

      if to >= 0:
        ac.nodes[to].link = 0
        queue.add to
      else:
        ac.nodes[0].next[c] = 0

    var head = 0

    while head < queue.len:
      let v = queue[head]
      head.inc

      let link = ac.nodes[v].link
      let linkOut = ac.nodes[link].`out`

      for id in linkOut:
        ac.nodes[v].`out`.add id

      for c in 0 ..< 256:
        let to = ac.nodes[v].next[c]

        if to >= 0:
          ac.nodes[to].link = ac.nodes[link].next[c]
          queue.add to
        else:
          ac.nodes[v].next[c] = ac.nodes[link].next[c]

    ac.built = true

  proc initAhoCorasick*(patterns: openArray[string]): AhoCorasick =
    ## Creates and builds an Aho-Corasick automaton from patterns.
    result = initAhoCorasick()

    for p in patterns:
      discard result.addPattern(p)

    result.build()

  proc len*(ac: AhoCorasick): int {.inline.} =
    ## Returns the number of states.
    ac.nodes.len

  proc patternCount*(ac: AhoCorasick): int {.inline.} =
    ## Returns the number of registered patterns.
    ac.patternLength.len

  proc nextState*(ac: AhoCorasick, state: int, ch: char): int {.inline.} =
    ## Returns the next automaton state.
    doAssert ac.built
    doAssert 0 <= state and state < ac.nodes.len

    ac.nodes[state].next[ord(ch)]

  proc transition*(ac: AhoCorasick, state: int, ch: char): int {.inline.} =
    ## Alias of `nextState`.
    ac.nextState(state, ch)

  proc findAll*(ac: AhoCorasick, text: string): seq[AhoCorasickMatch] =
    ## Returns all pattern occurrences in `text`.
    ##
    ## Each match is represented by a half-open interval `[l, r)`.
    doAssert ac.built

    var state = 0

    for i, ch in text:
      state = ac.nextState(state, ch)

      for id in ac.nodes[state].`out`:
        let length = ac.patternLength[id]

        result.add AhoCorasickMatch(
          l: i - length + 1,
          r: i + 1,
          patternId: id,
        )

  proc countMatches*(ac: AhoCorasick, text: string): int =
    ## Returns the total number of pattern occurrences in `text`.
    doAssert ac.built

    var state = 0

    for ch in text:
      state = ac.nextState(state, ch)
      result += ac.nodes[state].`out`.len

  proc matchCount*(ac: AhoCorasick, text: string): int =
    ## Alias of `countMatches`.
    ac.countMatches(text)

  proc contains*(ac: AhoCorasick, text: string): bool =
    ## Returns whether `text` contains at least one registered pattern.
    doAssert ac.built

    var state = 0

    for ch in text:
      state = ac.nextState(state, ch)

      if ac.nodes[state].`out`.len > 0:
        return true

    false
