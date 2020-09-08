when not defined ATCODER_INTERNAL_QUEUE_HPP:
  const ATCODER_INTERNAL_QUEUE_HPP = 1

  import sequtils
  
  type simple_queue[T] = object
    payload:seq[T]
    pos:int
  proc init_simple_queue[T]():auto = simple_queue[T](payload:newSeq[T](), pos:0)
# TODO
#      void reserve(int n) { payload.reserve(n); }
  proc len[T](self:simple_queue[T]):int = self.payload.len - pos
  proc empty[T](self:simple_queue[T]):bool = pos == payload.len
  proc push[T](self:var simple_queue[T], t:T) = payload.add(t)
  proc front[T](self:simple_queue[T]):T = self.payload[pos]
  proc clear[T](self:simple_queue[T]) =
    self.payload.setLen(0)
    self.pos = 0;
  proc pop[T](self:var simple_queue[T]) = self.pos.inc

#endif  // ATCODER_INTERNAL_QUEUE_HPP
