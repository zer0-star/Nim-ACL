when not declared ATCODER_EXTRA_STRING_SUFFIX_AUTOMATON_HPP:
  const ATCODER_EXTRA_STRING_SUFFIX_AUTOMATON_HPP* = 1

  import std/tables

  type
    SuffixAutomatonState* = object
      len*: int
      link*: int
      next*: Table[char, int]
      occurrences*: int

    SuffixAutomaton* = object
      states*: seq[SuffixAutomatonState]
      last*: int
      textLength*: int
      occurrencesBuilt*: bool

  proc initState(length = 0, link = -1, occurrences = 0): SuffixAutomatonState =
    result.len = length
    result.link = link
    result.next = initTable[char, int]()
    result.occurrences = occurrences

  proc initSuffixAutomaton*(): SuffixAutomaton =
    ## Creates an empty suffix automaton.
    result.states = @[initState()]
    result.last = 0
    result.textLength = 0
    result.occurrencesBuilt = false

  proc len*(sam: SuffixAutomaton): int {.inline.} =
    ## Returns the number of automaton states.
    sam.states.len

  proc extend*(sam: var SuffixAutomaton, ch: char): int =
    ## Appends one character and returns the new terminal state.
    doAssert not sam.occurrencesBuilt

    let cur = sam.states.len
    sam.states.add initState(
      length = sam.states[sam.last].len + 1,
      link = 0,
      occurrences = 1,
    )

    var p = sam.last

    while p >= 0 and ch notin sam.states[p].next:
      sam.states[p].next[ch] = cur
      p = sam.states[p].link

    if p < 0:
      sam.states[cur].link = 0
    else:
      let q = sam.states[p].next[ch]

      if sam.states[p].len + 1 == sam.states[q].len:
        sam.states[cur].link = q
      else:
        let clone = sam.states.len

        var cloneState = initState(
          length = sam.states[p].len + 1,
          link = sam.states[q].link,
          occurrences = 0,
        )

        for c, to in sam.states[q].next:
          cloneState.next[c] = to

        sam.states.add cloneState

        while p >= 0:
          if ch notin sam.states[p].next:
            break

          if sam.states[p].next[ch] != q:
            break

          sam.states[p].next[ch] = clone
          p = sam.states[p].link

        sam.states[q].link = clone
        sam.states[cur].link = clone

    sam.last = cur
    sam.textLength.inc
    cur

  proc add*(sam: var SuffixAutomaton, s: string) =
    ## Appends all characters in `s`.
    for ch in s:
      discard sam.extend(ch)

  proc buildOccurrences*(sam: var SuffixAutomaton) =
    ## Propagates occurrence counts through suffix links.
    doAssert not sam.occurrencesBuilt

    var maxLen = 0

    for st in sam.states:
      maxLen = max(maxLen, st.len)

    var count = newSeq[int](maxLen + 1)

    for st in sam.states:
      count[st.len].inc

    for i in 1 .. maxLen:
      count[i] += count[i - 1]

    var order = newSeq[int](sam.states.len)

    for i in countdown(sam.states.len - 1, 0):
      let length = sam.states[i].len
      count[length].dec
      order[count[length]] = i

    for i in countdown(order.len - 1, 1):
      let v = order[i]
      let p = sam.states[v].link

      if p >= 0:
        sam.states[p].occurrences += sam.states[v].occurrences

    sam.occurrencesBuilt = true

  proc initSuffixAutomaton*(s: string): SuffixAutomaton =
    ## Builds a suffix automaton and occurrence counts for `s`.
    result = initSuffixAutomaton()
    result.add(s)
    result.buildOccurrences()

  proc stateFor*(sam: SuffixAutomaton, pattern: string): int =
    ## Returns the state reached by `pattern`, or `-1` if absent.
    var v = 0

    for ch in pattern:
      if ch notin sam.states[v].next:
        return -1

      v = sam.states[v].next[ch]

    v

  proc contains*(sam: SuffixAutomaton, pattern: string): bool =
    ## Returns whether `pattern` is a substring.
    sam.stateFor(pattern) >= 0

  proc occurrenceCount*(sam: SuffixAutomaton, pattern: string): int =
    ## Returns the number of occurrences of a non-empty pattern.
    doAssert sam.occurrencesBuilt
    doAssert pattern.len > 0

    let v = sam.stateFor(pattern)

    if v < 0:
      0
    else:
      sam.states[v].occurrences

  proc distinctSubstringCount*(sam: SuffixAutomaton): int64 =
    ## Returns the number of distinct non-empty substrings.
    for v in 1 ..< sam.states.len:
      result += int64(sam.states[v].len - sam.states[sam.states[v].link].len)

  proc longestCommonSubstring*(
    sam: SuffixAutomaton,
    text: string
  ): tuple[length, l, r: int] =
    ## Returns one longest common substring as a range `[l, r)` in `text`.
    var
      state = 0
      currentLength = 0
      bestLength = 0
      bestEnd = 0

    for i, ch in text:
      while state != 0 and ch notin sam.states[state].next:
        state = sam.states[state].link
        currentLength = min(currentLength, sam.states[state].len)

      if ch in sam.states[state].next:
        state = sam.states[state].next[ch]
        currentLength.inc
      else:
        state = 0
        currentLength = 0

      if currentLength > bestLength:
        bestLength = currentLength
        bestEnd = i + 1

    (
      length: bestLength,
      l: bestEnd - bestLength,
      r: bestEnd,
    )
