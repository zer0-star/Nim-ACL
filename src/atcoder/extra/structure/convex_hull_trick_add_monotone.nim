when not declared ATCODER_CONVEX_HULL_TRICK_ADD_MONOTONE:
  const ATCODER_CONVEX_HULL_TRICK_ADD_MONOTONE* = 1
  import std/deques
  type ConvexHullTrickAddMonotone*[T] = object
    isMin:bool
    H:Deque[(T,T)]
  
  proc initConvexHullTrickAddMonotone*[T](isMin:bool):ConvexHullTrickAddMonotone[T] =
    return ConvexHullTrickAddMonotone[T](H:initDeque[(T, T)](), isMin:isMin)
  
  proc empty[T](self: ConvexHullTrickAddMonotone[T]):bool = self.H.len == 0
  
  #  void clear() { H.clear(); }
  
  proc sgn[T](self: ConvexHullTrickAddMonotone[T], x:T):int =
    return if x == T(0): 0 else: (if x < T(0):  -1 else: 1)
  
  proc check[T](self: ConvexHullTrickAddMonotone[T], a,b,c:(T,T)):bool =
    if b[1] == a[1] or c[1] == b[1]:
      return self.sgn(b[0] - a[0]) * self.sgn(c[1] - b[1]) >= self.sgn(c[0] - b[0]) * self.sgn(b[1] - a[1])
  
    #return (b[0]-a[0])*(c[1]-b[1]) >= (b[1]-a[1])*(c[0]-b[0]);
    return
        (b[0] - a[0]).float * self.sgn(c[1] - b[1]).float / abs(b[1] - a[1]).float >= (c[0] - b[0]).float * self.sgn(b[1] - a[1]).float / abs(c[1] - b[1]).float
  
  proc add*[T](self: var ConvexHullTrickAddMonotone[T], a, b:T) =
    var (a, b) = (a, b)
    if not self.isMin:
      a *= -1;b *= -1
    let line = (a, b)
    if self.empty():
      self.H.addFirst(line)
      return;
    if self.H[0][0] <= a:
      if self.H[0][0] == a:
        if self.H[0][1] <= b: return
        self.H.popFirst
      while self.H.len >= 2 and self.check(line, self.H[0], self.H[1]): self.H.popFirst
      self.H.addFirst(line)
    else:
      assert(a <= self.H[self.H.len-1][0])
      if self.H[self.H.len-1][0] == a:
        if self.H[self.H.len-1][1] <= b: return
        self.H.popLast()
      while self.H.len >= 2 and self.check(self.H[self.H.len-2], self.H[self.H.len-1], line): self.H.popLast
      self.H.addLast(line)
  
  proc get_y[T](self: ConvexHullTrickAddMonotone[T], a:(T, T), x:T):T =
    return a[0] * x + a[1];
  
  proc query*[T](self: ConvexHullTrickAddMonotone[T], x:T):T =
    assert(not self.empty())
    var (l, r) = (-1, self.H.len - 1)
    while l + 1 < r:
      let m = (l + r) shr 1
      if self.get_y(self.H[m], x) >= self.get_y(self.H[m + 1], x): l = m
      else: r = m
    if self.isMin: return self.get_y(self.H[r], x)
    return -self.get_y(self.H[r], x)
  
  proc query_monotone_inc*[T](self: var ConvexHullTrickAddMonotone[T], x:T):T =
    assert(not self.empty())
    while self.H.len >= 2 and self.get_y(self.H[0], x) >= self.get_y(self.H[1], x): self.H.popFirst
    if self.isMin: return self.get_y(self.H[0], x)
    return -self.get_y(self.H[0], x)
  
  proc query_monotone_dec*[T](self: var ConvexHullTrickAddMonotone[T], x:T):T =
    assert(not self.empty())
    while self.H.size() >= 2 and get_y(self.H[self.H.len - 1], x) >= self.get_y(self.H[self.H.len - 2], x): self.H.popLast
    if self.isMin: return self.get_y(self.H[self.H.len - 1], x)
    return -self.get_y(self.H[self.H.len - 1], x)
