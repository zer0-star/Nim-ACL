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


# :heavy_check_mark: src/nim_acl/segtree.nim

<a href="../../../index.html">Back to top page</a>

* category: <a href="../../../index.html#9445bba494c2e7790206eaaedbe1a4db">src/nim_acl</a>
* <a href="{{ site.github.repository_url }}/blob/master/src/nim_acl/segtree.nim">View this file on GitHub</a>
    - Last commit date: 2020-09-10 00:04:43+09:00




## Verified with

* :heavy_check_mark: <a href="../../../verify/verify/segtree_test.nim.html">verify/segtree_test.nim</a>


## Code

<a id="unbundled"></a>
{% raw %}
```cpp
when not defined ATCODER_SEGTREE_HPP:
  const ATCODER_SEGTREE_HPP = 1
  import internal_bit
  import sugar, sequtils

  type segtree[S] = object
    n, size, log:int
    d:seq[int]
    op:(S, S)->S
    e:()->S

  proc update[ST:segtree](self: var ST, k:int) =
    self.d[k] = self.op(self.d[2 * k], self.d[2 * k + 1])

  proc initSegTree*[S](v:seq[S], op:(S,S)->S, e:()->S):auto =
    let
      n = v.len
      log = ceil_pow2(n)
      size = 1 shl log
    result = segtree[S](n:n, size:size, log:log, d:newSeqWith(2 * size, e()), op:op, e:e)
    for i in 0..<n: result.d[size + i] = v[i]
    for i in countdown(size - 1, 1): result.update(i)

  proc initSegTree*[S](n:int, op:(S,S)->S, e:()->S):auto =
    initSegTree(newSeqWith(n, e()), op, e)

  proc set*[ST:segtree](self:var ST, p:int, x:ST.S) =
    assert p in 0..<self.n
    var p = p + self.size
    self.d[p] = x
    for i in 1..self.log: self.update(p shr i)

  proc get*[ST:segtree](self:ST, p:int):ST.S =
    assert p in 0..<self.n
    return self.d[p + self.size]

  proc prod*[ST:segtree](self:ST, p:Slice[int]):ST.S =
    var (l, r) = (p.a, p.b + 1)
    assert 0 <= l and l <= r and r <= self.n
    var sml, smr = self.e()
    l += self.size; r += self.size
    while l < r:
      if (l and 1) != 0: sml = self.op(sml, self.d[l]);l.inc
      if (r and 1) != 0: r.dec;smr = self.op(self.d[r], smr)
      l = l shr 1
      r = r shr 1
    return self.op(sml, smr)

  proc all_prod*[ST:segtree](self:ST):auto = self.d[1]

#  proc max_right*[ST:segtree, f:static[proc(s:ST.S):bool]](self:ST, l:int):auto = self.max_right(l, f)
  proc max_right*[ST:segtree](self:ST, l:int, f:proc(s:ST.S):bool):int =
    assert l in 0..self.n
    assert f(self.e())
    if l == self.n: return self.n
    var
      l = l + self.size
      sm = self.e()
    while true:
      while l mod 2 == 0: l = l shr 1
      if not f(self.op(sm, self.d[l])):
        while l < self.size:
          l = (2 * l)
          if f(self.op(sm, self.d[l])):
            sm = self.op(sm, self.d[l])
            l.inc
        return l - self.size
      sm = self.op(sm, self.d[l])
      l.inc
      if not ((l and -l) != l): break
    return self.n

#  proc min_left*[ST:segtree, f:static[proc(s:ST.S):bool]](self:ST, r:int):auto = self.min_left(r, f)
  proc min_left*[ST:segtree](self:ST, r:int, f:proc(s:ST.S):bool):int =
    assert r in 0..self.n
    assert f(self.e())
    if r == 0: return 0
    var
      r = r + self.size
      sm = self.e()
    while true:
      r.dec
      while r > 1 and (r mod 2 != 0): r = r shr 1
      if not f(self.op(self.d[r], sm)):
        while r < self.size:
          r = (2 * r + 1)
          if f(self.op(self.d[r], sm)):
            sm = self.op(self.d[r], sm)
            r.dec
        return r + 1 - self.size
      sm = self.op(self.d[r], sm)
      if not ((r and -r) != r): break
    return 0

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

