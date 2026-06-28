when not declared ATCODER_LIST_UTILS_HPP:
  const ATCODER_LIST_UTILS_HPP* = 1
  import lists

  proc split*[T](f:var DoublyLinkedList[T], nd:DoublyLinkedNode[T]):DoublyLinkedList[T] =
    result = initDoublyLinkedList[T]()
    result.tail = f.tail
    result.head = nd
    f.tail = nd.prev
    if f.head == nd:
      f.head = nil
      f.tail = nil
    if nd.prev != nil:
      nd.prev.next = nil
    nd.prev = nil

  proc merge*[T](f, t:var DoublyLinkedList[T]) =
    if f.tail == nil:
      doAssert(f.head == nil)
      f.head = t.head
      f.tail = t.tail
    else:
      f.tail.next = t.head
      t.head.prev = f.tail
      f.tail = t.tail
