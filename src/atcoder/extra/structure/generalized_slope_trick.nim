when not declared ATCODER_GENERALIZED_SLOPE_TRICK:
  const ATCODER_GENERALIZED_SLOPE_TRICK* = 1
  import atcoder/extra/structure/splay_tree

  proc split_lower_bound*[T:SomeSplayTree](self:T, t:T.Node, key:T.D):(T.Node, T.Node) =
    if t == self.leaf: return (self.leaf, self.leaf)
    self.push(t)
    if key <= t.key:
      var x = self.split_lower_bound(t.l, key)
      t.l = x[1]
      t.p = nil
      if x[1] != self.leaf: x[1].p = t
      return (x[0], self.update(t))
    else:
      var x = self.split_lower_bound(t.r, key)
      t.r = x[0]
      t.p = nil
      if x[0] != self.leaf: x[0].p = t
      return (self.update(t), x[1])

  proc merge_wuh*[T:SomeSplayTree](self: T, t1, t2:T.Node):T.Node =
    if t1 == self.leaf and t2 == self.leaf: return self.leaf
    if t1 == self.leaf: self.splay(t2); return t2
    if t2 == self.leaf: self.splay(t1); return t1
    self.splay(t1); self.splay(t2)
    var (t1, t2) = (t1, t2)
    if self.count(t1) < self.count(t2): swap(t1, t2)
    let ct2 = self.count(t2) div 2
    var (t2l, v, t2r) = self.split_index3(t2, ct2, ct2 + 1)
    var (t1l, t1r) = self.split_lower_bound(t1, v.key)
    return self.merge(self.merge_wuh(t1l, t2l), v, self.merge_wuh(t1r, t2r))

  proc insert_lower_bound*[T:SomeSplayTree](self: var T, t:T.Node, v:T.D):T.Node =
    if t != self.leaf:
      self.splay(t)
      var x = self.split_lower_bound(t, v)
      return self.merge(self.merge(x[0], self.alloc(v)), x[1])
    else:
      return self.alloc(v)

  type GeneralizedSlopeTrick*[T, ST] = object
    inf*:int
    min_f*:T
    st*: ST
    L*, R*: SplayTreeNode[T, T, void, int]

  proc initGeneralizedSlopeTrick*[T]:auto =
    proc f(a, b:T):T = a + b
    proc g(a:T, b:int):T = a * b
    var st = initLazySplayTree(f, f, f, g, 0, 0)
    result = GeneralizedSlopeTrick[T, st.type](st:st, inf:T.high div 3, min_f: T(0))
    result.st.init()
    result.L = result.st.leaf
    result.R = result.st.leaf
  proc like*[T, ST](self: GeneralizedSlopeTrick[T, ST]):auto =
    result = GeneralizedSlopeTrick[T, ST](inf:T.high div 3, min_f: T(0))
    result.st.init(leaf = self.st.leaf)
    result.L = result.st.leaf
    result.R = result.st.leaf


  proc push_R*[T](self:var GeneralizedSlopeTrick, a: T) =
    self.R = self.st.insert_lower_bound(self.R, a)

  proc top_R*[ST:GeneralizedSlopeTrick](self: var ST):ST.T =
    if self.R != self.st.leaf:
      self.R = self.st.get_left(self.R)
      self.st.splay(self.R)
      return self.R.key
    else:
      return self.inf

  proc pop_R*[ST:GeneralizedSlopeTrick](self:var ST):ST.T =
    result = self.top_R()
    if self.R != self.st.leaf: self.R = self.st.erase(self.R, false)

  proc push_L*[T](self: var GeneralizedSlopeTrick, a:T) =
    self.L = self.st.insert_lower_bound(self.L, a)

  proc top_L*[ST:GeneralizedSlopeTrick](self: var ST):ST.T =
    if self.L != self.st.leaf:
      self.L = self.st.get_right(self.L)
      self.st.splay(self.L)
      return self.L.key
    else:
      return -self.inf

  proc pop_L*[ST:GeneralizedSlopeTrick](self: var ST):ST.T =
    result = self.top_L()
    if self.L != self.st.leaf: self.L = self.st.erase(self.L, false)

  proc len*[T](self:GeneralizedSlopeTrick):int =
    self.st.count(self.L) + self.st.count(self.R)

  type Query*[T] = object
    lx*, rx*, min_f*: T

  # return min f(x)
  proc query*[ST:GeneralizedSlopeTrick](self:var ST):Query[ST.T] =
    return Query[ST.T](lx:self.top_L(), rx:self.top_R(), min_f:self.min_f)

  # f(x) += a
  proc add_all*[ST:GeneralizedSlopeTrick](self:var ST, a:ST.T) =
    self.min_f += a

  # add \_
  # f(x) += max(a - x, 0)
  proc add_a_minus_x*[ST:GeneralizedSlopeTrick](self: var ST, a:ST.T) =
    self.min_f += max(ST.T(0), a - self.top_R())
    self.push_R(a)
    self.push_L(self.pop_R())

  # add _/
  # f(x) += max(x - a, 0)
  proc add_x_minus_a*[ST:GeneralizedSlopeTrick](self: var ST, a:ST.T) =
    self.min_f += max(ST.T(0), self.top_L() - a)
    self.push_L(a)
    self.push_R(self.pop_L())

  # add \/
  # f(x) += abs(x - a)
  proc add_abs*[ST:GeneralizedSlopeTrick](self: var ST, a:ST.T) =
    self.add_a_minus_x(a)
    self.add_x_minus_a(a)

  # \/ -> \_
  # f_{new} (x) = min f(y) (y <= x)
  proc clear_right*[ST:GeneralizedSlopeTrick](self: var ST) =
    self.R = self.st.leaf

  # \/ -> _/
  # f_{new} (x) = min f(y) (y >= x)
  proc clear_left*[ST:GeneralizedSlopeTrick](self: var ST) =
    self.L = self.st.leaf

  # \/ -> \_/
  # f_{new} (x) = min f(y) (x-b <= y <= x-a)
  proc shift*[ST:GeneralizedSlopeTrick](self: var ST, a, b:ST.T) =
    assert a <= b
    if self.L != self.st.leaf: self.st.apply_all(self.L, a)
    if self.R != self.st.leaf: self.st.apply_all(self.R, b)

  # \/. -> .\/
  # f_{new} (x) = f(x - a)
  proc shift*[ST:GeneralizedSlopeTrick](self: var ST, a:ST.T) =
    self.shift(a, a)

  # return f(x) L, R を破壊する
  proc get*[ST:GeneralizedSlopeTrick](self: var ST, x:ST.T):ST.T =
    type T = ST.T
    result = self.min_f
    block:
      var (l, r) = self.st.split_lower_bound(self.L, x)
      if r != self.st.leaf:
        result += r.sum
        result -= x * T(self.st.count(r))
      self.L = self.st.merge(l, r)
    block:
      var (l, r) = self.st.split_lower_bound(self.R, x);
      if l != self.st.leaf:
        result += x * T(self.st.count(l))
        result -= l.sum
      self.R = self.st.merge(l, r)

  # f(x) += g(x)
  proc merge*[ST:GeneralizedSlopeTrick](self: var ST, g:var ST) =
    self.L = self.st.merge_wuh(self.L, g.L)
    self.R = self.st.merge_wuh(self.R, g.R)
    self.min_f += g.min_f;
