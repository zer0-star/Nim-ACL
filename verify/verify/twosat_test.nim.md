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


# :heavy_check_mark: verify/twosat_test.nim

<a href="../../index.html">Back to top page</a>

* category: <a href="../../index.html#e8418d1d706cd73548f9f16f1d55ad6e">verify</a>
* <a href="{{ site.github.repository_url }}/blob/master/verify/twosat_test.nim">View this file on GitHub</a>
    - Last commit date: 2020-09-10 22:39:22+09:00


* see: <a href="https://judge.yosupo.jp/problem/two_sat">https://judge.yosupo.jp/problem/two_sat</a>


## Depends on

* :heavy_check_mark: <a href="../../library/src/nim_acl/header.nim.html">src/nim_acl/header.nim</a>
* :heavy_check_mark: <a href="../../library/src/nim_acl/twosat.nim.html">src/nim_acl/twosat.nim</a>


## Code

<a id="unbundled"></a>
{% raw %}
```cpp
# verify-helper: PROBLEM https://judge.yosupo.jp/problem/two_sat

include src/nim_acl/header
include src/nim_acl/twosat

import sequtils, strutils, sugar

block:
  let
    p, cnf = nextString() # dummy
    N, M = nextInt()
  var ts = initTwoSat(N)
  for _ in 0..<M:
    var a, b = nextInt()
    let zero = nextString() # summy
    var f, g:bool
    if a > 0:
      f = true
    else:
      f = false
      a *= -1
    a.dec
    if b > 0:
      g = true
    else:
      g = false
      b *= -1
    b.dec
    ts.add_clause(a, f, b, g)
  if ts.satisfiable:
    echo "s SATISFIABLE"
    stdout.write "v "
    for i,a in ts.answer:
      if a:
        stdout.write i + 1, " "
      else:
        stdout.write -(i + 1), " "
    echo 0
  else:
    echo "s UNSATISFIABLE"

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

