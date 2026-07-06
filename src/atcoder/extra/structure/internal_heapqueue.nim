# {{{ heapqueue
when not declared ATCODER_INTERNAL_HEAPQUEUE:
  const ATCODER_INTERNAL_HEAPQUEUE* = 1
  type HeapQueue*[T; heapCmp:static[auto]] = object
    ## A heap queue, commonly known as a priority queue.
    data: seq[T]
  
  proc initHeapQueue*[T](heapCmp:static[proc(a, b:T):bool]): auto =
    ## Create a new empty heap.
    HeapQueue[T, heapCmp]()
  proc initHeapQueue*[T](): auto =
    ## Create a new empty heap.
    HeapQueue[T, proc(a, b:T):bool = a < b]()
  
  proc len*[H:HeapQueue](heap: H): int {.inline.} =
    ## Return the number of elements of `heap`.
    heap.data.len
  
  proc `[]`*[H:HeapQueue](heap: H, i: Natural): H.T {.inline.} =
    ## Access the i-th element of `heap`.
    heap.data[i]
  
  #proc heapCmp[T](x, y: T): bool {.inline.} =
  #  return (x < y)
  
  proc siftdown[H:HeapQueue](heap: var H, startpos, p: int) =
    ## 'heap' is a heap at all indices >= startpos, except possibly for pos.  pos
    ## is the index of a leaf with a possibly out-of-order value.  Restore the
    ## heap invariant.
    var pos = p
    var newitem = heap[pos]
    # Follow the path to the root, moving parents down until finding a place
    # newitem fits.
    while pos > startpos:
      let parentpos = (pos - 1) shr 1
      let parent = heap[parentpos]
      let heapCmp = H.heapCmp
      if heapCmp(newitem, parent):
        heap.data[pos] = parent
        pos = parentpos
      else:
        break
    heap.data[pos] = newitem
  
  proc siftup[H:HeapQueue](heap: var H, p: int) =
    let endpos = len(heap)
    var pos = p
    let startpos = pos
    let newitem = heap[pos]
    # Bubble up the smaller child until hitting a leaf.
    var childpos = 2*pos + 1 # leftmost child position
    while childpos < endpos:
      # Set childpos to index of smaller child.
      let rightpos = childpos + 1
      let heapCmp = H.heapCmp
      if rightpos < endpos and not heapCmp(heap[childpos], heap[rightpos]):
        childpos = rightpos
      # Move the smaller child up.
      heap.data[pos] = heap[childpos]
      pos = childpos
      childpos = 2*pos + 1
    # The leaf at pos is empty now.  Put newitem there, and bubble it up
    # to its final resting place (by sifting its parents down).
    heap.data[pos] = newitem
    siftdown(heap, startpos, pos)
  
  proc push*[H:HeapQueue](heap: var H, item: H.T) =
    ## Push `item` onto heap, maintaining the heap invariant.
    heap.data.add(item)
    siftdown(heap, 0, len(heap)-1)
  
  proc pop*[H:HeapQueue](heap: var H): H.T =
    ## Pop and return the smallest item from `heap`,
    ## maintaining the heap invariant.
    let lastelt = heap.data.pop()
    if heap.len > 0:
      result = heap[0]
      heap.data[0] = lastelt
      siftup(heap, 0)
    else:
      result = lastelt
  
  proc del*[H:HeapQueue](heap: var H, index: Natural) =
    ## Removes the element at `index` from `heap`, maintaining the heap invariant.
    swap(heap.data[^1], heap.data[index])
    let newLen = heap.len - 1
    heap.data.setLen(newLen)
    if index < newLen:
      heap.siftup(index)
  
  proc replace*[H:HeapQueue](heap: var H, item: H.T): H.T =
    ## Pop and return the current smallest value, and add the new item.
    ## This is more efficient than pop() followed by push(), and can be
    ## more appropriate when using a fixed-size heap. Note that the value
    ## returned may be larger than item! That constrains reasonable uses of
    ## this routine unless written as part of a conditional replacement:
    ##
    ## .. code-block:: nim
    ##    if item > heap[0]:
    ##        item = replace(heap, item)
    result = heap[0]
    heap.data[0] = item
    siftup(heap, 0)
  
  proc pushpop*[H:HeapQueue](heap: var H, item: H.T): H.T =
    ## Fast version of a push followed by a pop.
    let heapCmp = H.heapCmp
    if heap.len > 0 and heapCmp(heap[0], item):
      swap(item, heap[0])
      siftup(heap, 0)
    return item
  
  proc clear*[H:HeapQueue](heap: var H) =
    ## Remove all elements from `heap`, making it empty.
    runnableExamples:
      var heap = initHeapQueue[int]()
      heap.push(1)
      heap.clear()
      assert heap.len == 0
    heap.data.setLen(0)
  
  proc `$`*[H:HeapQueue](heap: H): string =
    ## Turn a heap into its string representation.
    runnableExamples:
      var heap = initHeapQueue[int]()
      heap.push(1)
      heap.push(2)
      assert $heap == "[1, 2]"
    result = "["
    for x in heap.data:
      if result.len > 1: result.add(", ")
      result.addQuoted(x)
    result.add("]")
  
# }}}
