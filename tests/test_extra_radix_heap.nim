
discard """
  cmd: "nim cpp -r $file"
"""

import atcoder/extra/structure/radix_heap

block:
  var heap = initRadixHeap[int, string]()

  heap.push(-5, "a")
  heap.push(-2, "b")
  heap.push(0, "c")

  doAssert heap.len == 3
  doAssert heap.pop() == (-5, "a")

  heap.push(-4, "d")
  heap.push(3, "e")

  doAssert heap.pop() == (-4, "d")
  doAssert heap.pop() == (-2, "b")
  doAssert heap.pop() == (0, "c")
  doAssert heap.pop() == (3, "e")
  doAssert heap.empty()

block:
  var heap = initRadixHeap[uint64, int]()

  heap.push(0'u64, 0)
  heap.push(1'u64 shl 63, 1)
  heap.push(uint64.high, 2)

  doAssert heap.pop() == (0'u64, 0)
  doAssert heap.pop() == (1'u64 shl 63, 1)
  doAssert heap.pop() == (uint64.high, 2)
  doAssert heap.empty()

block:
  var heap = initRadixHeap[uint32, int]()

  heap.push(0'u32, 0)
  heap.push(uint32.high, 1)

  doAssert heap.pop() == (0'u32, 0)
  doAssert heap.pop() == (uint32.high, 1)
