when not declared ATCODER_EXTRA_STRING_PALINDROMIC_TREE_HPP:
  const ATCODER_EXTRA_STRING_PALINDROMIC_TREE_HPP* = 1

  import std/tables

  type
    PalindromicTreeNode* = object
      len*: int
      link*: int
      next*: Table[char, int]
      occurrences*: int
      firstEnd*: int

    PalindromicTree* = object
      text*: seq[char]
      nodes*: seq[PalindromicTreeNode]
      suffix*: int
      occurrencesBuilt*: bool

  proc initNode(
    length: int,
    link: int,
    occurrences = 0,
    firstEnd = -1
  ): PalindromicTreeNode =
    result.len = length
    result.link = link
    result.next = initTable[char, int]()
    result.occurrences = occurrences
    result.firstEnd = firstEnd

  proc initPalindromicTree*(): PalindromicTree =
    ## Creates an empty palindromic tree.
    ##
    ## Node 0 is the imaginary palindrome of length -1.
    ## Node 1 is the empty palindrome of length 0.
    result.text = @[]
    result.nodes = @[
      initNode(length = -1, link = 0),
      initNode(length = 0, link = 0),
    ]
    result.suffix = 1
    result.occurrencesBuilt = false

  proc add*(pt: var PalindromicTree, ch: char): int =
    ## Appends one character and returns the longest suffix-palindrome node.
    doAssert not pt.occurrencesBuilt

    let pos = pt.text.len
    pt.text.add ch

    var cur = pt.suffix

    while true:
      let currentLength = pt.nodes[cur].len
      let left = pos - 1 - currentLength

      if left >= 0 and pt.text[left] == ch:
        break

      cur = pt.nodes[cur].link

    if ch in pt.nodes[cur].next:
      let existing = pt.nodes[cur].next[ch]
      pt.nodes[existing].occurrences.inc
      pt.suffix = existing
      return existing

    let newId = pt.nodes.len
    let newLength = pt.nodes[cur].len + 2

    pt.nodes.add initNode(
      length = newLength,
      link = 1,
      occurrences = 1,
      firstEnd = pos,
    )

    pt.nodes[cur].next[ch] = newId

    if newLength == 1:
      pt.nodes[newId].link = 1
    else:
      var candidate = pt.nodes[cur].link

      while true:
        let candidateLength = pt.nodes[candidate].len
        let left = pos - 1 - candidateLength

        if left >= 0 and pt.text[left] == ch:
          break

        candidate = pt.nodes[candidate].link

      pt.nodes[newId].link = pt.nodes[candidate].next[ch]

    pt.suffix = newId
    newId

  proc add*(pt: var PalindromicTree, s: string) =
    ## Appends all characters in `s`.
    for ch in s:
      discard pt.add(ch)

  proc buildOccurrences*(pt: var PalindromicTree) =
    ## Propagates occurrence counts through suffix links.
    doAssert not pt.occurrencesBuilt

    let n = pt.text.len
    var count = newSeq[int](n + 1)

    for i in 2 ..< pt.nodes.len:
      count[pt.nodes[i].len].inc

    for i in 1 .. n:
      count[i] += count[i - 1]

    var order = newSeq[int](max(0, pt.nodes.len - 2))

    for i in countdown(pt.nodes.len - 1, 2):
      let length = pt.nodes[i].len
      count[length].dec
      order[count[length]] = i

    if order.len > 0:
      for i in countdown(order.len - 1, 0):
        let v = order[i]
        let p = pt.nodes[v].link

        if p >= 2:
          pt.nodes[p].occurrences += pt.nodes[v].occurrences

    pt.occurrencesBuilt = true

  proc initPalindromicTree*(s: string): PalindromicTree =
    ## Builds a palindromic tree and occurrence counts for `s`.
    result = initPalindromicTree()
    result.add(s)
    result.buildOccurrences()

  proc len*(pt: PalindromicTree): int {.inline.} =
    ## Returns the number of automaton nodes, including two roots.
    pt.nodes.len

  proc distinctPalindromeCount*(pt: PalindromicTree): int {.inline.} =
    ## Returns the number of distinct non-empty palindromes.
    max(0, pt.nodes.len - 2)

  proc palindrome*(pt: PalindromicTree, node: int): string =
    ## Returns the palindrome represented by `node`.
    doAssert 2 <= node and node < pt.nodes.len

    let
      length = pt.nodes[node].len
      r = pt.nodes[node].firstEnd + 1
      l = r - length

    result = newString(length)

    for i in 0 ..< length:
      result[i] = pt.text[l + i]

  proc palindromes*(pt: PalindromicTree): seq[string] =
    ## Returns all distinct non-empty palindromes in node order.
    for node in 2 ..< pt.nodes.len:
      result.add pt.palindrome(node)

  proc totalPalindromeOccurrences*(pt: PalindromicTree): int =
    ## Returns the total number of palindromic substrings.
    doAssert pt.occurrencesBuilt

    for node in 2 ..< pt.nodes.len:
      result += pt.nodes[node].occurrences

  proc longestPalindromeRange*(pt: PalindromicTree): tuple[l, r: int] =
    ## Returns one longest palindrome as a half-open range `[l, r)`.
    result = (l: 0, r: 0)

    for node in 2 ..< pt.nodes.len:
      let
        length = pt.nodes[node].len
        r = pt.nodes[node].firstEnd + 1
        l = r - length

      if length > result.r - result.l:
        result = (l: l, r: r)

  proc longestPalindromeLength*(pt: PalindromicTree): int =
    ## Returns the length of a longest palindromic substring.
    let range = pt.longestPalindromeRange()
    range.r - range.l
