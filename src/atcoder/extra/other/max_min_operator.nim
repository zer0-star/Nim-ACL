when not declared ATCODER_MAX_MIN_OPERATOR_HPP:
  const ATCODER_MAX_MIN_OPERATOR_HPP* = 1
  template `max=`*(x,y:typed):void = x = max(x,y)
  template `>?=`*(x,y:typed):void = x.max= y
  template `min=`*(x,y:typed):void = x = min(x,y)
  template `<?=`*(x,y:typed):void = x.min= y
