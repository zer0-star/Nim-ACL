when not declared ATCODER_DIRECTION:
  const ATCODER_DIRECTION* = 1
  let dir4* = [(1, 0), (0, 1), (-1, 0), (0, -1)]
  let dir8* = [(1, 0), (1, 1), (0, 1), (-1, 1), (-1, 0), (-1, -1), (0, -1), (1, -1)]

  iterator neighbor*(p:(int, int), d:openArray[(int, int)]):(int, int) =
    for d in d:
      let (i, j) = (p[0] + d[0], p[1] + d[1])
      yield (i, j)
  iterator neighbor*(p:(int, int), d:openArray[(int, int)], limit:(Slice[int], Slice[int])):(int, int) =
    for (i, j) in p.neighbor(d):
      if i notin limit[0] or j notin limit[1]: continue
      yield (i, j)
