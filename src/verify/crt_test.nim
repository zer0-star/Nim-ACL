# verify-helper: PROBLEM https://yukicoder.me/problems/no/186

import atcoder/header
import atcoder/math

let X1, Y1, X2, Y2, X3, Y3 = nextInt()
var (y, z) = crt(@[X1, X2, X3], @[Y1, Y2, Y3])
if y == 0 and z == 0:
  echo -1
else:
  if y == 0: y += z
  echo y
