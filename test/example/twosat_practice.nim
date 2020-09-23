import atcoder/header
import atcoder/twosat

let n, d = nextInt()
var x, y = newSeq[int](n)
for i in 0..<n:
  (x[i], y[i]) = (nextInt(), nextInt())

# ts[i] = (i-th flag is located on x[i])
var ts = init_two_sat(n)

for i in 0..<n:
  for j in i + 1 ..< n:
    if abs(x[i] - x[j]) < d:
      # cannot use both of x[i] and x[j]
      ts.add_clause(i, false, j, false)
    if abs(x[i] - y[j]) < d:
      ts.add_clause(i, false, j, true)
    if abs(y[i] - x[j]) < d:
      ts.add_clause(i, true, j, false)
    if abs(y[i] - y[j]) < d:
      ts.add_clause(i, true, j, true)

if not ts.satisfiable():
  echo "No"
else:
  echo "Yes"
  let answer = ts.answer
  for i in 0..<n:
    if answer[i]:
      echo x[i]
    else:
      echo y[i]
