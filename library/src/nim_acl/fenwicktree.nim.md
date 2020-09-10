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
<script type="text/javascript" src="../../../assets/js/copy-button.js"></script>
<link rel="stylesheet" href="../../../assets/css/copy-button.css" />


# :warning: src/nim_acl/fenwicktree.nim

<a href="../../../index.html">Back to top page</a>

* category: <a href="../../../index.html#9445bba494c2e7790206eaaedbe1a4db">src/nim_acl</a>
* <a href="{{ site.github.repository_url }}/blob/master/src/nim_acl/fenwicktree.nim">View this file on GitHub</a>
    - Last commit date: 2020-09-10 22:39:22+09:00




## Code

<a id="unbundled"></a>
{% raw %}
```cpp
when not defined ATCODER_FENWICKTREE_HPP:
  const ATCODER_FENWICKTREE_HPP = 1

# TODO
#include <atcoder/internal_type_traits>

# Reference: https://en.wikipedia.org/wiki/Fenwick_tree
  type fenwick_tree[T] = object
    n:int
    data:seq[T]
  
  
  # TODO
  #  using U = internal::to_unsigned_t<T>;
  
  proc init_fenwick_tree[T](n:int) = fenwick_tree[T](n:n, data:newSeq[T](n))
  
  proc add[T](self: var fenwick_tree[T], p:int, x:T) =
    assert p in 0..<self.n
    var p = p + 1
    while p <= self.n:
# TODO
#      self.data[p - 1] += U(x)
      self.data[p - 1] += x
      p += p and -p
  
  proc sum[T](self: fenwick_tree[T], p:Slice[int]):T =
    let (l, r) = (p.a, p.b + 1)
    assert 0 <= l and l <= r and r <= self.n
    return self.sum(r) - self.sum(l)
  
#  U sum(int r) =
#    U s = 0;
#    while (r > 0) {
#      s += data[r - 1];
#      r -= r & -r;
#    }
#    return s;
#  }
  proc sum[T](self: fenwick_tree[T], r:int):T =
    var
      s = T(0)
      r = r
    while r > 0:
      s += data[r - 1]
      r -= r and -r
    return s

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

<a href="../../../index.html">Back to top page</a>

