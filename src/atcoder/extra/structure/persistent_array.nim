when not declared ATCODER_PERSISTENT_ARRAY_HPP:
  const ATCODER_PERSISTENT_ARRAY_HPP* = 1
  const LOG = 3
  
  type
    PersistentArrayNode*[T] = ref object
      data:T
      child:array[1 shl LOG, PersistentArrayNode[T]]
    PersistentArray*[T] = object
      root: PersistentArrayNode[T]

  proc build[T](t:var PersistentArrayNode[T], data:T, k:int):PersistentArrayNode[T] =
    if t == nil: t = PersistentArrayNode[T]()
    if k == 0:
      t.data = data
      return t
    let p = build(t.child[k and ((1 shl LOG) - 1)], data, k shr LOG)
    t.child[k and ((1 shl LOG) - 1)] = p
    return t
  
  proc build[T](self:var PersistentArray[T], v:seq[T]) =
    self.root = nil
    for i in 0..<v.len:
      self.root = self.root.build(v[i], i)
  
  proc initPersistentArray*[T](v:seq[T]):auto =
    result = PersistentArray[T]()
    result.build(v)
  
  proc `[]`*[T](t:PersistentArrayNode[T], k:int):auto =
    if k == 0: return t.data
    return t.child[k and ((1 shl LOG) - 1)][k shr LOG]
  
  proc `[]`*[T](self:PersistentArray[T], k:int):auto = return self.root[k]
  
  proc `[]=`*[T](t:var PersistentArrayNode[T], k:int, val:T):PersistentArrayNode[T] {.discardable.}=
    t = if t != nil: PersistentArrayNode[T](data:t.data, child:t.child) else: PersistentArrayNode[T]()
    if k == 0:
      t.data = val
      return t
    var p = (t.child[k and ((1 shl LOG) - 1)][k shr LOG] = val)
    t.child[k and ((1 shl LOG) - 1)] = p
    return t
  
  proc `[]=`*[T](self:var PersistentArray[T], k:int, val:T) =
    var ret = (self.root[k] = val)
    self.root = ret
