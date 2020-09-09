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


# :heavy_check_mark: src/nim_acl/dsu.nim

<a href="../../../index.html">Back to top page</a>

* category: <a href="../../../index.html#9445bba494c2e7790206eaaedbe1a4db">src/nim_acl</a>
* <a href="{{ site.github.repository_url }}/blob/master/src/nim_acl/dsu.nim">View this file on GitHub</a>
    - Last commit date: 2020-09-09 21:00:15+09:00




## Verified with

* :heavy_check_mark: <a href="../../../verify/verify/dsu_test.nim.html">verify/dsu_test.nim</a>


## Code

<a id="unbundled"></a>
{% raw %}
```cpp
when not defined ATCODER_DSU_HPP:
  const ATCODER_DSU_HPP* = 1

  import sequtils

  type
    DSU* = ref object
      n: int
      par_or_siz: seq[int]

  proc initDSU*(n: int): DSU {.inline.} =
    return DSU(n: n, par_or_siz: newSeqWith(n, -1))

  proc leader*(self: DSU; a: int): int {.inline.} =
    ## Path compression
    if self.par_or_siz[a] < 0: return a
    self.par_or_siz[a] = self.leader(self.par_or_siz[a])
    return self.par_or_siz[a]

  proc same*(self: DSU; a, b: int): bool {.inline.} =
    self.leader(a) == self.leader(b)

  proc size*(self: DSU; a: int): int {.inline.} =
    - self.par_or_siz[self.leader(a)]

  proc merge*(self: DSU; a, b: int): int {.inline, discardable.} =

    var
      x = self.leader(a)
      y = self.leader(b)

    if x == y: return x
    if self.par_or_siz[x] > self.par_or_siz[y]: swap(x, y)
    self.par_or_siz[x] += self.par_or_siz[y]
    self.par_or_siz[y] = x
    return x

  proc groups*(self: DSU): seq[seq[int]] {.inline.} =
    var
      leaderBuf = newSeq[int](self.n)
      groupsize = newSeq[int](self.n)
    for i in 0 ..< self.n:
      leaderBuf[i] = self.leader(i)
      groupsize[leaderBuf[i]].inc
    result = (0 ..< self.n).mapIt(newSeqOfCap[int](groupsize[it]))
    for i, ldr in leaderBuf:
      result[ldr].add i
    result.keepItIf(it.len > 0)

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

