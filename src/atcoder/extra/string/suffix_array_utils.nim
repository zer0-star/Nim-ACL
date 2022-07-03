when not declared ATCODER_SUFFIX_ARRAY_UTILS:
  const ATCODER_SUFFIX_ARRAY_UTILS* = 1
  import atcoder/string
  type SuffixArray = object
    s:string
    SA:seq[int]
  
  proc lt_substr*(self: SuffixArray, t:string, si = 0, ti = 0):bool =
    let
      sn = self.s.len
      tn = t.len
    var
      si = si
      ti = ti
    while si < sn and ti < tn:
      if self.s[si] < t[ti]: return true
      if self.s[si] > t[ti]: return false
      si += 1;ti += 1
    return si >= sn and ti < tn
  
  proc initSuffixArray*(s:string):SuffixArray = 
    return SuffixArray(s:s, SA:s.suffixArray)
  
  proc `[]`*(self:SuffixArray, k:int):int =
    return self.SA[k]
  
  proc size*(self:SuffixArray):int =
    return self.s.len
  
  proc lowerBound*(self:SuffixArray, t:string):int =
    var
      low = -1
      high = self.size
    while high - low > 1:
      var mid = (low + high) div 2
      if self.lt_substr(t, self.SA[mid]): low = mid
      else: high = mid
    return high
  
  proc lowerUpperBound*(self:SuffixArray, t:string):(int,int) =
    var
      idx = self.lowerBound(t)
      low = idx - 1
      high = self.size
      t = t
    t[^1] = chr(ord(t[^1]) + 1)
    while high - low > 1:
      var mid = (low + high) div 2
      if self.lt_substr(t, self.SA[mid]): low = mid
      else: high = mid
    t[^1] = chr(ord(t[^1]) - 1)
    return (idx, high)
  
  proc output*(self:SuffixArray):void =
    for i in 0..<self.s.len:
      echo i, ": ", self.s.substr[self.SA[i]..<self.s.len]
  
