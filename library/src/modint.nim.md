---
layout: default
---

<!-- mathjax config similar to math.stackexchange -->
<script type="text/javascript" async
  src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.5/MathJax.js?config=TeX-MML-AM_CHTML">
</script>
<script type="text/x-mathjax-config">
  MathJax.Hub.Config({
    TeX: { equationNumbers: { autoNumber: "AMS" }},
    tex2jax: {
      inlineMath: [ ['$','$'] ],
      processEscapes: true
    },
    "HTML-CSS": { matchFontHeight: false },
    displayAlign: "left",
    displayIndent: "2em"
  });
</script>

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery-balloon-js@1.1.2/jquery.balloon.min.js" integrity="sha256-ZEYs9VrgAeNuPvs15E39OsyOJaIkXEEt10fzxJ20+2I=" crossorigin="anonymous"></script>
<script type="text/javascript" src="../../assets/js/copy-button.js"></script>
<link rel="stylesheet" href="../../assets/css/copy-button.css" />


# :warning: src/modint.nim

<a href="../../index.html">Back to top page</a>

* category: <a href="../../index.html#25d902c24283ab8cfbac54dfa101ad31">src</a>
* <a href="{{ site.github.repository_url }}/blob/master/src/modint.nim">View this file on GitHub</a>
    - Last commit date: 2020-09-11 22:48:07+09:00




## Code

<a id="unbundled"></a>
{% raw %}
```cpp
when not defined ATCODER_MODINT_HPP:
  const ATCODER_MODINT_HPP* = 1

  type
    ModInt*[M: static[int]] = distinct int

  proc `$`*[M: static[int]](m: ModInt[M]): string {.inline.} =
    $m.int

  proc modulo*(x, y: int): int {.inline.} =
    ## requires: y > 0
    assert y > 0
    if x < 0:
      let tmp = (-x) mod y
      if tmp == 0:
        0
      else:
        y - tmp
    else:
      x mod y

  proc extgcd*(x, y: int): (int, int) {.inline.} =
    var
      a = x
      p = y
      b, r = 1
      c, q = 0
    while a.modulo(p) != 0:
      let t = a div p
      a -= p * t
      b -= q * t
      c -= r * t
      swap(a, p)
      swap(b, q)
      swap(c, r)
    (q, r)

  proc initModInt*(v: int = 0; M: static[int] = 1_000_000_007): ModInt[M] {.inline.} =
    ModInt[M](v.modulo(M))

  proc initModIntRaw*(v: int = 0; M: static[int] = 1_000_000_007): ModInt[M] {.inline.} =
    ModInt[M](v)

  proc retake*[M: static[int]](m: var ModInt[M]) {.inline.} =
    int(m) = int(m).modulo(M)

  proc val*[M: static[int]](m: ModInt[M]): int {.inline.} =
    int(m)

  proc modulo*[M: static[int]](m: ModInt[M]): int {.inline.} =
    M

  proc `-`*[M: static[int]](m: ModInt[M]): ModInt[M] {.inline.} =
    ModInt[M](M - int(m))

  template generateDefinitions(name, l, r, retType, body: untyped): untyped =
    proc name*[M: static[int]](l: ModInt[M]; r: ModInt[M]): retType {.inline.} =
      body
    proc name*[M: static[int]](l: int; r: ModInt[M]): retType {.inline.} =
      body
    proc name*[M: static[int]](l: ModInt[M]; r: int): retType {.inline.} =
      body

  proc inv*[M: static[int]](m: ModInt[M]): ModInt[M] {.inline.} =
    result = initModInt(extgcd(M, int(m))[1], M)

  proc `+=`*[M: static[int]](m: var ModInt[M]; n: int | ModInt[M]) {.inline.} =
    int(m) += int(n)
    m.retake()

  proc `-=`*[M: static[int]](m: var ModInt[M]; n: int | ModInt[M]) {.inline.} =
    int(m) -= int(n)
    m.retake()

  proc `*=`*[M: static[int]](m: var ModInt[M]; n: int | ModInt[M]) {.inline.} =
    int(m) *= int(n)
    m.retake()

  proc `/=`*[M: static[int]](m: var ModInt[M]; n: int | ModInt[M]) {.inline.} =
    int(m) *= extgcd(M, n.modulo(M))[1].modulo(M)
    m.retake()

  generateDefinitions(`+`, m, n, ModInt[M]):
    result += m
    result += n

  generateDefinitions(`-`, m, n, ModInt[M]):
    result += m
    result -= n

  generateDefinitions(`*`, m, n, ModInt[M]):
    result += m
    result *= n

  generateDefinitions(`/`, m, n, ModInt[M]):
    result += m
    result /= n

  proc `==`*[M: static[int]](m: ModInt[M]; n: int | ModInt[M]): bool {.inline.} =
    int(m) == int(n)

  proc inc*[M: static[int]](m: var ModInt[M]) {.inline.} =
    int(m).inc
    if m == M:
      int(m) = 0

  proc dec*[M: static[int]](m: var ModInt[M]) {.inline.} =
    if m == 0:
      int(m) = M - 1
    else:
      int(m).dec

  proc pow*[M: static[int]](m: ModInt[M]; p: int): ModInt[M] {.inline.} =
    var
      p = p
      m = m
    int(result) = 1
    while p > 0:
      if (p and 1) == 1:
        result *= m
      m *= m
      p = p shr 1

```
{% endraw %}

<a id="bundled"></a>
{% raw %}
```cpp
Traceback (most recent call last):
  File "/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/docs.py", line 349, in write_contents
    bundled_code = language.bundle(self.file_class.file_path, basedir=pathlib.Path.cwd())
  File "/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/nim.py", line 86, in bundle
    raise NotImplementedError
NotImplementedError

```
{% endraw %}

<a href="../../index.html">Back to top page</a>

