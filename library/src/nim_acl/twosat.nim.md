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


# :heavy_check_mark: src/nim_acl/twosat.nim

<a href="../../../index.html">Back to top page</a>

* category: <a href="../../../index.html#9445bba494c2e7790206eaaedbe1a4db">src/nim_acl</a>
* <a href="{{ site.github.repository_url }}/blob/master/src/nim_acl/twosat.nim">View this file on GitHub</a>
    - Last commit date: 2020-09-10 22:39:22+09:00




## Verified with

* :heavy_check_mark: <a href="../../../verify/verify/twosat_test.nim.html">verify/twosat_test.nim</a>


## Code

<a id="unbundled"></a>
{% raw %}
```cpp
when not defined ATCODER_TWOSAT_HPP:
  const ATCODER_TWOSAT_HPP = 1

  import internal_scc
  
  # Reference:
  # B. Aspvall, M. Plass, and R. Tarjan,
  # A Linear-Time Algorithm for Testing the Truth of Certain Quantified Boolean
  # Formulas
  type two_sat* = object
    n:int
    answer:seq[bool]
    scc:internal_scc_graph

  proc init_two_sat*(n:int):auto =
    two_sat(n:n, answer:newSeq[bool](n), scc:init_internal_scc_graph(2 * n))
  
  proc add_clause*(self:var two_sat, i:int, f:bool, j:int, g:bool) =
    assert i in 0..<self.n
    assert j in 0..<self.n
    self.scc.add_edge(2 * i + (if f: 0 else: 1), 2 * j + (if g: 1 else: 0))
    self.scc.add_edge(2 * j + (if g: 0 else: 1), 2 * i + (if f: 1 else: 0))
  proc satisfiable*(self:var two_sat):bool =
    let id = self.scc.scc_ids()[1]
    for i in 0..<self.n:
      if id[2 * i] == id[2 * i + 1]: return false
      self.answer[i] = id[2 * i] < id[2 * i + 1]
    return true
#  proc answer*(self: two_sat):auto = self.answer

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

