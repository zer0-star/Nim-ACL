when not declared ATCODER_RANDOM_TREE_HPP:
  const ATCODER_RANDOM_TREE_HPP* = 1
  import heapqueue, random
  proc pruefer_decode*(code:seq[int]):seq[(int, int)] =
    let n = code.len + 2
    var degree = newSeq[int](n)
    for i in 0 ..< n: degree[i] = 1
    for i in code:
      degree[i].inc
    var leaves = initHeapQueue[int]()
    for i in 0 ..< n:
      if degree[i] == 1:
        leaves.push(i)
    for v in code:
      let leaf = leaves.pop()

      result.add((leaf, v))
      degree[v].dec
      if degree[v] == 1:
        leaves.push(v)

    result.add((leaves.pop(), n - 1))
  proc random_tree*(n:int):seq[(int, int)] =
    doAssert n >= 2
    var code = newSeq[int](n - 2)
    for i in 0 ..< code.len:
      code[i] = random.rand(0 ..< n)
    return pruefer_decode(code)
  iterator enumerate_tree*(n:int):seq[(int, int)] =
    var
      code = newSeq[int](n - 2)
      next = true
    while next:
      yield pruefer_decode(code)
      for i in 0 ..< code.len:
        if code[i] < n - 1:
          code[i].inc
          break
        else:
          code[i] = 0
          if i == code.len - 1: next = false
