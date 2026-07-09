# AC(AtCoder) Library Document

## How to Install

- There is `atcoder` folder in the `ac-library` folder, after extracting the zip file.
- With g++, you can compile by `g++ main.cpp -std=c++14 -I .` with putting `atcoder` folder on the same place as `main.cpp`.
  - You should compile with `-std=c++14` or `-std=c++17`.
- See [Appendix](./appendix.html) for further details.

## Note

- The behavior is undefined if the input does not match the constraints.
- For simplicity, we abbreviate the types as follows.
  - `unsigned int` → `uint`
  - `long long` → `ll`
  - `unsigned long long` → `ull`
- $0^0=1$.
- Multiple edges and self-loops are allowed unless specified.

## List

`#include <atcoder/all>` : include everything

### Data Structures

- [`#include <atcoder/fenwicktree>`](./fenwicktree.html)
- [`#include <atcoder/segtree>`](./segtree.html)
- [`#include <atcoder/lazysegtree>`](./lazysegtree.html)
- [`#include <atcoder/string>`](./string.html)

### Math

- [`#include <atcoder/math>`](./math.html)
- [`#include <atcoder/convolution>`](./convolution.html)
- 💻[`#include <atcoder/modint>`](./modint.html)

### Graphs

- [`#include <atcoder/dsu>`](./dsu.html)
- [`#include <atcoder/maxflow>`](./maxflow.html)
- [`#include <atcoder/mincostflow>`](./mincostflow.html)
- [`#include <atcoder/scc>`](./scc.html)
- [`#include <atcoder/twosat>`](./twosat.html)

## Appendix

- [Appendix / FAQ](./appendix.html)

## Test

- You can test this Library [here](https://atcoder.jp/contests/practice2?lang=en).


## License

The header files in `atcoder` folder are licensed under a CC0 license. See `atcoder/LICENSE` for further details.

## Extra / Math

- FPS facade [`import atcoder/extra/math/fps`](./extra/math/fps.html)
- [`import atcoder/extra/graph/boruvka`](./extra/graph/boruvka.html)

## extra/dp

- [`import atcoder/extra/dp/cumulative_sum`](./extra/dp/cumulative_sum.html)
- [`import atcoder/extra/dp/cumulative_sum_2d`](./extra/dp/cumulative_sum_2d.html)
- [`import atcoder/extra/dp/dual_cumulative_sum_2d`](./extra/dp/dual_cumulative_sum_2d.html)
- [`import atcoder/extra/dp/edit_distance`](./extra/dp/edit_distance.html)
- [`import atcoder/extra/dp/largest_rectangle`](./extra/dp/largest_rectangle.html)
- [`import atcoder/extra/dp/dual_cumulative_sum`](./extra/dp/dual_cumulative_sum.html)
- [`import atcoder/extra/dp/longest_increasing_subsequence`](./extra/dp/longest_increasing_subsequence.html)
- [`import atcoder/extra/dp/slide_min`](./extra/dp/slide_min.html)
