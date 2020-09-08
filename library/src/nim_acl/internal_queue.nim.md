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


# :warning: src/nim_acl/internal_queue.nim

<a href="../../../index.html">Back to top page</a>

* category: <a href="../../../index.html#9445bba494c2e7790206eaaedbe1a4db">src/nim_acl</a>
* <a href="{{ site.github.repository_url }}/blob/master/src/nim_acl/internal_queue.nim">View this file on GitHub</a>
    - Last commit date: 2020-09-09 01:13:51+09:00




## Code

<a id="unbundled"></a>
{% raw %}
```cpp
when not defined ATCODER_INTERNAL_QUEUE_HPP:
  const ATCODER_INTERNAL_QUEUE_HPP = 1

  import sequtils
  
  type simple_queue[T] = object
    payload:seq[T]
    pos:int
  proc init_simple_queue[T]():auto = simple_queue[T](payload:newSeq[T](), pos:0)
# TODO
#      void reserve(int n) { payload.reserve(n); }
  proc len[T](self:simple_queue[T]):int = self.payload.len - pos
  proc empty[T](self:simple_queue[T]):bool = pos == payload.len
  proc push[T](self:var simple_queue[T], t:T) = payload.add(t)
  proc front[T](self:simple_queue[T]):T = self.payload[pos]
  proc clear[T](self:simple_queue[T]) =
    self.payload.setLen(0)
    self.pos = 0;
  proc pop[T](self:var simple_queue[T]) = self.pos.inc

#endif  // ATCODER_INTERNAL_QUEUE_HPP

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

