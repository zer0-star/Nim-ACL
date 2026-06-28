when not declared ATCODER_SLIDING_WINDOW_HPP:
  const ATCODER_SLIDING_WINDOW_HPP* = 1
  type
    SlidingWindowAggregationNode[T] = object
      val, sum:T
    SlidingWindowAggregation*[T] = object
      f:proc(a, b:T):T
      e:proc():T
      front, back:seq[SlidingWindowAggregationNode[T]]

  proc initSlidingWindowAggregation*[T](f:proc(a, b:T):T, e:proc():T):SlidingWindowAggregation[T] = 
    result.f = f
    result.e = e

  proc empty*[T](self:SlidingWindowAggregation[T]):bool =
    return self.front.len == 0 and self.back.len == 0

  proc len*[T](self:SlidingWindowAggregation[T]):int =
    self.front.len + self.back.len

  proc fold_all*[T](self:SlidingWindowAggregation[T]):T =
    if self.front.len == 0 and self.back.len == 0:
      return self.e()
    elif self.front.len == 0:
      return self.back[^1].sum
    elif self.back.len == 0:
      return self.front[^1].sum
    else:
      return self.f(self.front[^1].sum, self.back[^1].sum);

  proc push*[T](self:var SlidingWindowAggregation[T], x:T) =
    if self.back.len == 0:
      self.back.add(SlidingWindowAggregationNode[T](val:x, sum:x))
    else:
      self.back.add(SlidingWindowAggregationNode[T](val:x, sum:self.f(self.back[^1].sum, x)))

  proc pop*[T](self:var SlidingWindowAggregation[T]) =
    if self.front.len == 0:
      var b = self.back.pop()
      b.sum = b.val
      self.front.add(b)
      while self.back.len > 0:
        let b = self.back.pop()
        self.front.add(SlidingWindowAggregationNode[T](val:b.val, sum:self.f(b.val, self.front[^1].sum)));
    discard self.front.pop()
