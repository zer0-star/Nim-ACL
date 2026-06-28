when not declared ATCODER_CFOR_HPP:
  import std/macros
  const ATCODER_CFOR_HPP* = 1
  macro For*(preLoop, condition, postLoop, body:untyped):NimNode =
    var
      preLoop = if preLoop.repr == "()": ident("discard") else: preLoop
      condition = if condition.repr == "()": ident("true") else: condition
      postLoop = if postLoop.repr == "()": ident("discard") else: postLoop
    quote do:
      `preLoop`
      var start_cfor {.gensym.} = true
      while true:
        if start_cfor:
          start_cfor = false
        else:
          `postLoop`
        if not `condition`:
          break
        `body`
  template cfor*(preLoop, condition, postLoop, body:untyped):NimNode =
    For(preLoop, condition, postLoop, body)
