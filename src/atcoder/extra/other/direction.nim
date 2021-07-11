when not declared ATCODER_DIRECTION:
  const ATCODER_DIRECTION* = 1
  let dir4* = [(1, 0), (0, 1), (-1, 0), (0, -1)]
  let dir8* = [(1, 0), (1, 1), (0, 1), (-1, 1), (-1, 0), (-1, -1), (0, -1), (1, -1)]
  
  iterator neighbor*(p:(int, int), d:openArray[(int, int)], 
    limit = ((int.low..int.high), (int.low..int.high))):(int, int) =
    for d in d:
      let (i, j) = (p[0] + d[0], p[1] + d[1])
      if i notin limit[0] or j notin limit[1]: continue
      yield (i, j)
