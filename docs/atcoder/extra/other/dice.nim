when not declared ATCODER_DICE:
  const ATCODER_DICE* = 1
  type FACE* = enum
    TOP, BOTTOM, FRONT, BACK, LEFT, RIGHT
  
  type dice*[T] = object
    val:array[6, T]
    id:array[6, int]
  
  proc initDice*[T]():dice[T] =
    var id:array[6, int]
    id[TOP.int] = 0; id[FRONT.int] = 1; id[LEFT.int] = 2;
    id[RIGHT.int] = 3; id[BACK.int] = 4; id[BOTTOM.int] = 5
    result.id = id
  
  proc `[]`*[T](self:dice[T], f:FACE):T = self.val[self.id[f.int]]
  proc `[]=`*[T](self:var dice[T], f:FACE, t:T) = self.val[self.id[f.int]] = t
  
  proc `==`*[T](self, b:dice[T]):bool =
    return self[TOP] == b[TOP] and self[BOTTOM] == b[BOTTOM] and
           self[FRONT] == b[FRONT] and self[BACK] == b[BACK] and
           self[LEFT] == b[LEFT] and self[RIGHT] == b[RIGHT]
  
  proc roll*[T](self: var dice[T], a, b, c, d:FACE) =
    let tmp = self.id[a.int]
    self.id[a.int] = self.id[b.int]; self.id[b.int] = self.id[c.int];
    self.id[c.int] = self.id[d.int]; self.id[d.int] = tmp
  
  proc roll_x*[T](self:var dice[T]) = self.roll(TOP, BACK, BOTTOM, FRONT)
  proc roll_y*[T](self:var dice[T]) = self.roll(TOP, LEFT, BOTTOM, RIGHT)
  proc roll_z*[T](self:var dice[T]) = self.roll(FRONT, RIGHT, BACK, LEFT)
  
  proc all_rolls*[T](self:dice[T]):seq[dice[T]] =
    var dice = dice
    var k = 0
    while k < 6:
      var i = 0
      while i < 4:
        result.add(dice)
        self.roll_z()
        i.inc
      if (k and 1) != 0: self.roll_y()
      else: self.roll_x()
      k.inc
  
  proc equivalent_to*[T](self, di: dice[T]):bool =
    var self = self
    var k = 0
    while k < 6:
      var i = 0
      while i < 4:
        if self == di: return true
        self.roll_z()
        i.inc
      if (k and 1) != 0: self.roll_y()
      else: self.roll_x()
      k.inc
    return false
