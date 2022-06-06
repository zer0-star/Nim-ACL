when not declared ATCODER_RUN_ENUMERATE_HPP:
  const ATCODER_RUN_ENUMERATE_HPP* = 1
  import std/tables, std/algorithm
  import atcoder/string
  proc reversed*(s:string):string =
    for i in countdown(s.len - 1, 0):
      result.add s[i]
  
  proc RunEnumerate*(s:string):seq[(int,int,int)] =
    var ret = newSeq[(int,int,int)]()
    proc aux(first, second:string):auto =
      result = newSeq[(int,int,int)]()
  
      let
        a = z_algorithm(first.reversed)
        b = z_algorithm(second & '\0' & first & second)
  
      for i in 1..<first.len:
        let
          l1 = if i == first.len: 0 else: a[i]
          l2 = b[second.len + first.len - i + 1]
  
        if l1 + i == first.len or l2 == second.len or i > l1 + l2: continue
  
        let
          l = first.len - i - l1
          r = first.len + l2
          t = i
        result.add((t, l, r))
  
    proc run(s:string, left = 0) =
      if s.len == 1: return
  
      let
        N = s.len
        m = N div 2
        first = s[0..<m]
        second = s[m..<s.len]
    
      block:
        var res = aux(first, second)
  
        for (t,l,r) in res:
          ret.add((t, left + l, left + r))
      block:
        var res = aux(second.reversed, first.reversed)
  
        for (t, l, r) in res:
          ret.add((t, left + N - r, left + N - l))
  
      run(first, left)
      run(second, left + first.len)
  
    proc sub(s:string) =
      let N = s.len
      block:
        let a = z_algorithm(s)
        for i in 1..<N:
          if i <= a[i]:
            ret.add((i, 0, i + a[i]))
      block:
        let a = z_algorithm(s.reversed)
        for i in 1..<N:
          if i <= a[i]:
            ret.add((i, N - i - a[i], N))
  
    run(s)
    sub(s)
  
    var m = initTable[(int,int), int]()
  
    for (t,l,r) in ret:
      let p = (l, r)
      if p in m:
        m[p] = min(m[p], t)
      else:
        m[p] = t
  
    ret.setLen(0)
  
    for p, t in m.pairs:
      ret.add((t, p[0], p[1]))
    ret.sort
    return ret
