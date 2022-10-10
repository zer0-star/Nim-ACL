when not declared ATCODER_SINCE_HPP:
  const ATCODER_SINCE_HPP* = 1
  template since*(version: (int, int), body: untyped) {.dirty.} =
    when (NimMajor, NimMinor) >= version:
      body

  template since*(version: (int, int, int), body: untyped) {.dirty.} =
    when (NimMajor, NimMinor, NimPatch) >= version:
      body

  template until*(version: (int, int), body: untyped) {.dirty.} =
    when (NimMajor, NimMinor) <= version:
      body

  template until*(version: (int, int, int), body: untyped) {.dirty.} =
    when (NimMajor, NimMinor, NimPatch) >= version:
      body
