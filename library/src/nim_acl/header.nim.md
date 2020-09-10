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


# :heavy_check_mark: src/nim_acl/header.nim

<a href="../../../index.html">Back to top page</a>

* category: <a href="../../../index.html#9445bba494c2e7790206eaaedbe1a4db">src/nim_acl</a>
* <a href="{{ site.github.repository_url }}/blob/master/src/nim_acl/header.nim">View this file on GitHub</a>
    - Last commit date: 2020-09-09 23:03:48+09:00




## Verified with

* :heavy_check_mark: <a href="../../../verify/verify/lcp_array_test.nim.html">verify/lcp_array_test.nim</a>
* :heavy_check_mark: <a href="../../../verify/verify/segtree_test.nim.html">verify/segtree_test.nim</a>
* :heavy_check_mark: <a href="../../../verify/verify/suffix_array_test.nim.html">verify/suffix_array_test.nim</a>
* :heavy_check_mark: <a href="../../../verify/verify/twosat_test.nim.html">verify/twosat_test.nim</a>
* :heavy_check_mark: <a href="../../../verify/verify/z_algorithm_test.nim.html">verify/z_algorithm_test.nim</a>


## Code

<a id="unbundled"></a>
{% raw %}
```cpp
when not defined ATCODER_HEADER_HPP:
  {.hints:off checks:off assertions:on checks:off}
  const ATCODER_HEADER_HPP = 1
  import algorithm, sequtils, tables, macros, math, sets, strutils, streams, strformat, sugar
  
  proc scanf(formatstr: cstring){.header: "<stdio.h>", varargs.}
  proc getchar(): char {.header: "<stdio.h>", varargs.}
  proc nextInt(base:int = 0): int =
    scanf("%lld",addr result)
    result -= base
  proc nextFloat(): float = scanf("%lf",addr result)
  proc nextString(): string =
    var get = false;result = ""
    while true:
      var c = getchar()
      if int(c) > int(' '): get = true;result.add(c)
      elif get: break
  template `max=`*(x,y:typed):void = x = max(x,y)
  template `min=`*(x,y:typed):void = x = min(x,y)
  template inf(T): untyped = 
    when T is SomeFloat: T(Inf)
    elif T is SomeInteger: ((T(1) shl T(sizeof(T)*8-2)) - (T(1) shl T(sizeof(T)*4-1)))
    else: assert(false)

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

