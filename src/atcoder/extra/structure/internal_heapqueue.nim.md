---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: atcoder/extra/graph/dijkstra_multi_dimensional.nim
    title: atcoder/extra/graph/dijkstra_multi_dimensional.nim
  - icon: ':warning:'
    path: atcoder/extra/graph/dijkstra_multi_dimensional.nim
    title: atcoder/extra/graph/dijkstra_multi_dimensional.nim
  - icon: ':warning:'
    path: atcoder/extra/graph/dijkstra_multi_dimensional.nim
    title: atcoder/extra/graph/dijkstra_multi_dimensional.nim
  - icon: ':warning:'
    path: atcoder/extra/graph/dijkstra_multi_dimensional.nim
    title: atcoder/extra/graph/dijkstra_multi_dimensional.nim
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# {{{ heapqueue\nwhen not declared ATCODER_INTERNAL_HEAPQUEUE:\n  const ATCODER_INTERNAL_HEAPQUEUE*\
    \ = 1\n  type HeapQueue*[T; heapCmp:static[auto]] = object\n    ## A heap queue,\
    \ commonly known as a priority queue.\n    data: seq[T]\n  \n  proc initHeapQueue*[T](heapCmp:static[proc(a,\
    \ b:T):bool]): auto =\n    ## Create a new empty heap.\n    HeapQueue[T, heapCmp]()\n\
    \  proc initHeapQueue*[T](): auto =\n    ## Create a new empty heap.\n    HeapQueue[T,\
    \ proc(a, b:T):bool = a < b]()\n  \n  proc len*[H:HeapQueue](heap: H): int {.inline.}\
    \ =\n    ## Return the number of elements of `heap`.\n    heap.data.len\n  \n\
    \  proc `[]`*[H:HeapQueue](heap: H, i: Natural): H.T {.inline.} =\n    ## Access\
    \ the i-th element of `heap`.\n    heap.data[i]\n  \n  #proc heapCmp[T](x, y:\
    \ T): bool {.inline.} =\n  #  return (x < y)\n  \n  proc siftdown[H:HeapQueue](heap:\
    \ var H, startpos, p: int) =\n    ## 'heap' is a heap at all indices >= startpos,\
    \ except possibly for pos.  pos\n    ## is the index of a leaf with a possibly\
    \ out-of-order value.  Restore the\n    ## heap invariant.\n    var pos = p\n\
    \    var newitem = heap[pos]\n    # Follow the path to the root, moving parents\
    \ down until finding a place\n    # newitem fits.\n    while pos > startpos:\n\
    \      let parentpos = (pos - 1) shr 1\n      let parent = heap[parentpos]\n \
    \     let heapCmp = H.heapCmp\n      if heapCmp(newitem, parent):\n        heap.data[pos]\
    \ = parent\n        pos = parentpos\n      else:\n        break\n    heap.data[pos]\
    \ = newitem\n  \n  proc siftup[H:HeapQueue](heap: var H, p: int) =\n    let endpos\
    \ = len(heap)\n    var pos = p\n    let startpos = pos\n    let newitem = heap[pos]\n\
    \    # Bubble up the smaller child until hitting a leaf.\n    var childpos = 2*pos\
    \ + 1 # leftmost child position\n    while childpos < endpos:\n      # Set childpos\
    \ to index of smaller child.\n      let rightpos = childpos + 1\n      let heapCmp\
    \ = H.heapCmp\n      if rightpos < endpos and not heapCmp(heap[childpos], heap[rightpos]):\n\
    \        childpos = rightpos\n      # Move the smaller child up.\n      heap.data[pos]\
    \ = heap[childpos]\n      pos = childpos\n      childpos = 2*pos + 1\n    # The\
    \ leaf at pos is empty now.  Put newitem there, and bubble it up\n    # to its\
    \ final resting place (by sifting its parents down).\n    heap.data[pos] = newitem\n\
    \    siftdown(heap, startpos, pos)\n  \n  proc push*[H:HeapQueue](heap: var H,\
    \ item: H.T) =\n    ## Push `item` onto heap, maintaining the heap invariant.\n\
    \    heap.data.add(item)\n    siftdown(heap, 0, len(heap)-1)\n  \n  proc pop*[H:HeapQueue](heap:\
    \ var H): H.T =\n    ## Pop and return the smallest item from `heap`,\n    ##\
    \ maintaining the heap invariant.\n    let lastelt = heap.data.pop()\n    if heap.len\
    \ > 0:\n      result = heap[0]\n      heap.data[0] = lastelt\n      siftup(heap,\
    \ 0)\n    else:\n      result = lastelt\n  \n  proc del*[H:HeapQueue](heap: var\
    \ H, index: Natural) =\n    ## Removes the element at `index` from `heap`, maintaining\
    \ the heap invariant.\n    swap(heap.data[^1], heap.data[index])\n    let newLen\
    \ = heap.len - 1\n    heap.data.setLen(newLen)\n    if index < newLen:\n     \
    \ heap.siftup(index)\n  \n  proc replace*[H:HeapQueue](heap: var H, item: H.T):\
    \ H.T =\n    ## Pop and return the current smallest value, and add the new item.\n\
    \    ## This is more efficient than pop() followed by push(), and can be\n   \
    \ ## more appropriate when using a fixed-size heap. Note that the value\n    ##\
    \ returned may be larger than item! That constrains reasonable uses of\n    ##\
    \ this routine unless written as part of a conditional replacement:\n    ##\n\
    \    ## .. code-block:: nim\n    ##    if item > heap[0]:\n    ##        item\
    \ = replace(heap, item)\n    result = heap[0]\n    heap.data[0] = item\n    siftup(heap,\
    \ 0)\n  \n  proc pushpop*[H:HeapQueue](heap: var H, item: H.T): H.T =\n    ##\
    \ Fast version of a push followed by a pop.\n    let heapCmp = H.heapCmp\n   \
    \ if heap.len > 0 and heapCmp(heap[0], item):\n      swap(item, heap[0])\n   \
    \   siftup(heap, 0)\n    return item\n  \n  proc clear*[H:HeapQueue](heap: var\
    \ H) =\n    ## Remove all elements from `heap`, making it empty.\n    runnableExamples:\n\
    \      var heap = initHeapQueue[int]()\n      heap.push(1)\n      heap.clear()\n\
    \      assert heap.len == 0\n    heap.data.setLen(0)\n  \n  proc `$`*[H:HeapQueue](heap:\
    \ H): string =\n    ## Turn a heap into its string representation.\n    runnableExamples:\n\
    \      var heap = initHeapQueue[int]()\n      heap.push(1)\n      heap.push(2)\n\
    \      assert $heap == \"[1, 2]\"\n    result = \"[\"\n    for x in heap.data:\n\
    \      if result.len > 1: result.add(\", \")\n      result.addQuoted(x)\n    result.add(\"\
    ]\")\n  \n# }}}\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/structure/internal_heapqueue.nim
  requiredBy:
  - atcoder/extra/graph/dijkstra_multi_dimensional.nim
  - atcoder/extra/graph/dijkstra_multi_dimensional.nim
  - atcoder/extra/graph/dijkstra_multi_dimensional.nim
  - atcoder/extra/graph/dijkstra_multi_dimensional.nim
  timestamp: '2020-10-01 00:25:07+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/structure/internal_heapqueue.nim
layout: document
redirect_from:
- /library/atcoder/extra/structure/internal_heapqueue.nim
- /library/atcoder/extra/structure/internal_heapqueue.nim.html
title: atcoder/extra/structure/internal_heapqueue.nim
---
