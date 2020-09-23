---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _pathExtension: cpp
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "#line 1 \"test/unittest/lazysegtree_stress_test.cpp\"\n#include <gtest/gtest.h>\n\
    \n#include <algorithm>\n#include <atcoder/lazysegtree>\n#line 1 \"test/utils/random.hpp\"\
    \n\n#include <random>\n\nstd::mt19937 global_mt19937;\n\n// random choise from\
    \ [a, b]\ntemplate <class T>\nT randint(T a, T b) {\n    return std::uniform_int_distribution<T>(a,\
    \ b)(global_mt19937);\n}\n\nbool randbool() {\n    return randint(0, 1) == 0;\n\
    }\n\n// random choice 2 disjoint elements from [lower, upper]\ntemplate <class\
    \ T> std::pair<T, T> randpair(T lower, T upper) {\n    assert(upper - lower >=\
    \ 1);\n    T a, b;\n    do {\n        a = randint(lower, upper);\n        b =\
    \ randint(lower, upper);\n    } while (a == b);\n    if (a > b) std::swap(a, b);\n\
    \    return {a, b};\n}\n#line 6 \"test/unittest/lazysegtree_stress_test.cpp\"\n\
    #include <string>\n#include <vector>\n\nusing namespace atcoder;\n\n// time manager\n\
    struct time_manager {\n    std::vector<int> v;\n    time_manager(int n) : v(n,\
    \ -1) {}\n    void action(int l, int r, int time) {\n        for (int i = l; i\
    \ < r; i++) {\n            v[i] = time;\n        }\n    }\n    int prod(int l,\
    \ int r) {\n        int res = -1;\n        for (int i = l; i < r; i++) {\n   \
    \         res = std::max(res, v[i]);\n        }\n        return res;\n    }\n\
    };\n\nstruct S {\n    int l, r, time;\n};\n\nstruct T {\n    int new_time;\n};\n\
    \nS op_ss(S l, S r) {\n    if (l.l == -1) return r;\n    if (r.l == -1) return\
    \ l;\n    assert(l.r == r.l);\n    return S{l.l, r.r, std::max(l.time, r.time)};\n\
    }\n\nS op_ts(T l, S r) {\n    if (l.new_time == -1) return r;\n    assert(r.time\
    \ < l.new_time);\n    return S{r.l, r.r, l.new_time};\n}\n\nT op_tt(T l, T r)\
    \ {\n    if (l.new_time == -1) return r;\n    if (r.new_time == -1) return l;\n\
    \    assert(l.new_time > r.new_time);\n    return l;\n}\n\nS e_s() { return S{-1,\
    \ -1, -1}; }\n\nT e_t() { return T{-1}; }\n\nusing seg = lazy_segtree<S, op_ss,\
    \ e_s, T, op_ts, op_tt, e_t>;\n\nTEST(LazySegtreeStressTest, NaiveTest) {\n  \
    \  for (int n = 1; n <= 30; n++) {\n        for (int ph = 0; ph < 10; ph++) {\n\
    \            seg seg0(n);\n            time_manager tm(n);\n            for (int\
    \ i = 0; i < n; i++) {\n                seg0.set(i, S{i, i + 1, -1});\n      \
    \      }\n            int now = 0;\n            for (int q = 0; q < 3000; q++)\
    \ {\n                int ty = randint(0, 3);\n                int l, r;\n    \
    \            std::tie(l, r) = randpair(0, n);\n                if (ty == 0) {\n\
    \                    auto res = seg0.prod(l, r);\n                    ASSERT_EQ(l,\
    \ res.l);\n                    ASSERT_EQ(r, res.r);\n                    ASSERT_EQ(tm.prod(l,\
    \ r), res.time);\n                } else if (ty == 1) {\n                    auto\
    \ res = seg0.get(l);\n                    ASSERT_EQ(l, res.l);\n             \
    \       ASSERT_EQ(l + 1, res.r);\n                    ASSERT_EQ(tm.prod(l, l +\
    \ 1), res.time);\n                } else if (ty == 2) {\n                    now++;\n\
    \                    seg0.apply(l, r, T{now});\n                    tm.action(l,\
    \ r, now);\n                } else if (ty == 3) {\n                    now++;\n\
    \                    seg0.apply(l, T{now});\n                    tm.action(l,\
    \ l + 1, now);\n                } else {\n                    assert(false);\n\
    \                }\n            }\n        }\n    }\n}\n\nTEST(LazySegtreeStressTest,\
    \ MaxRightTest) {\n    for (int n = 1; n <= 30; n++) {\n        for (int ph =\
    \ 0; ph < 10; ph++) {\n            seg seg0(n);\n            time_manager tm(n);\n\
    \            for (int i = 0; i < n; i++) {\n                seg0.set(i, S{i, i\
    \ + 1, -1});\n            }\n            int now = 0;\n            for (int q\
    \ = 0; q < 1000; q++) {\n                int ty = randint(0, 2);\n           \
    \     int l, r;\n                std::tie(l, r) = randpair(0, n);\n          \
    \      if (ty == 0) {\n                    ASSERT_EQ(r, seg0.max_right(l, [&](S\
    \ s) {\n                        if (s.l == -1) return true;\n                \
    \        assert(s.l == l);\n                        assert(s.time == tm.prod(l,\
    \ s.r));\n                        return s.r <= r;\n                    }));\n\
    \                } else {\n                    now++;\n                    seg0.apply(l,\
    \ r, T{now});\n                    tm.action(l, r, now);\n                }\n\
    \            }\n        }\n    }\n}\n\nTEST(LazySegtreeStressTest, MinLeftTest)\
    \ {\n    for (int n = 1; n <= 30; n++) {\n        for (int ph = 0; ph < 10; ph++)\
    \ {\n            seg seg0(n);\n            time_manager tm(n);\n            for\
    \ (int i = 0; i < n; i++) {\n                seg0.set(i, S{i, i + 1, -1});\n \
    \           }\n            int now = 0;\n            for (int q = 0; q < 1000;\
    \ q++) {\n                int ty = randint(0, 2);\n                int l, r;\n\
    \                std::tie(l, r) = randpair(0, n);\n                if (ty == 0)\
    \ {\n                    ASSERT_EQ(l, seg0.min_left(r, [&](S s) {\n          \
    \              if (s.l == -1) return true;\n                        assert(s.r\
    \ == r);\n                        assert(s.time == tm.prod(s.l, r));\n       \
    \                 return l <= s.l;\n                    }));\n               \
    \ } else {\n                    now++;\n                    seg0.apply(l, r, T{now});\n\
    \                    tm.action(l, r, now);\n                }\n            }\n\
    \        }\n    }\n}\n"
  code: "#include <gtest/gtest.h>\n\n#include <algorithm>\n#include <atcoder/lazysegtree>\n\
    #include \"../utils/random.hpp\"\n#include <string>\n#include <vector>\n\nusing\
    \ namespace atcoder;\n\n// time manager\nstruct time_manager {\n    std::vector<int>\
    \ v;\n    time_manager(int n) : v(n, -1) {}\n    void action(int l, int r, int\
    \ time) {\n        for (int i = l; i < r; i++) {\n            v[i] = time;\n \
    \       }\n    }\n    int prod(int l, int r) {\n        int res = -1;\n      \
    \  for (int i = l; i < r; i++) {\n            res = std::max(res, v[i]);\n   \
    \     }\n        return res;\n    }\n};\n\nstruct S {\n    int l, r, time;\n};\n\
    \nstruct T {\n    int new_time;\n};\n\nS op_ss(S l, S r) {\n    if (l.l == -1)\
    \ return r;\n    if (r.l == -1) return l;\n    assert(l.r == r.l);\n    return\
    \ S{l.l, r.r, std::max(l.time, r.time)};\n}\n\nS op_ts(T l, S r) {\n    if (l.new_time\
    \ == -1) return r;\n    assert(r.time < l.new_time);\n    return S{r.l, r.r, l.new_time};\n\
    }\n\nT op_tt(T l, T r) {\n    if (l.new_time == -1) return r;\n    if (r.new_time\
    \ == -1) return l;\n    assert(l.new_time > r.new_time);\n    return l;\n}\n\n\
    S e_s() { return S{-1, -1, -1}; }\n\nT e_t() { return T{-1}; }\n\nusing seg =\
    \ lazy_segtree<S, op_ss, e_s, T, op_ts, op_tt, e_t>;\n\nTEST(LazySegtreeStressTest,\
    \ NaiveTest) {\n    for (int n = 1; n <= 30; n++) {\n        for (int ph = 0;\
    \ ph < 10; ph++) {\n            seg seg0(n);\n            time_manager tm(n);\n\
    \            for (int i = 0; i < n; i++) {\n                seg0.set(i, S{i, i\
    \ + 1, -1});\n            }\n            int now = 0;\n            for (int q\
    \ = 0; q < 3000; q++) {\n                int ty = randint(0, 3);\n           \
    \     int l, r;\n                std::tie(l, r) = randpair(0, n);\n          \
    \      if (ty == 0) {\n                    auto res = seg0.prod(l, r);\n     \
    \               ASSERT_EQ(l, res.l);\n                    ASSERT_EQ(r, res.r);\n\
    \                    ASSERT_EQ(tm.prod(l, r), res.time);\n                } else\
    \ if (ty == 1) {\n                    auto res = seg0.get(l);\n              \
    \      ASSERT_EQ(l, res.l);\n                    ASSERT_EQ(l + 1, res.r);\n  \
    \                  ASSERT_EQ(tm.prod(l, l + 1), res.time);\n                }\
    \ else if (ty == 2) {\n                    now++;\n                    seg0.apply(l,\
    \ r, T{now});\n                    tm.action(l, r, now);\n                } else\
    \ if (ty == 3) {\n                    now++;\n                    seg0.apply(l,\
    \ T{now});\n                    tm.action(l, l + 1, now);\n                } else\
    \ {\n                    assert(false);\n                }\n            }\n  \
    \      }\n    }\n}\n\nTEST(LazySegtreeStressTest, MaxRightTest) {\n    for (int\
    \ n = 1; n <= 30; n++) {\n        for (int ph = 0; ph < 10; ph++) {\n        \
    \    seg seg0(n);\n            time_manager tm(n);\n            for (int i = 0;\
    \ i < n; i++) {\n                seg0.set(i, S{i, i + 1, -1});\n            }\n\
    \            int now = 0;\n            for (int q = 0; q < 1000; q++) {\n    \
    \            int ty = randint(0, 2);\n                int l, r;\n            \
    \    std::tie(l, r) = randpair(0, n);\n                if (ty == 0) {\n      \
    \              ASSERT_EQ(r, seg0.max_right(l, [&](S s) {\n                   \
    \     if (s.l == -1) return true;\n                        assert(s.l == l);\n\
    \                        assert(s.time == tm.prod(l, s.r));\n                \
    \        return s.r <= r;\n                    }));\n                } else {\n\
    \                    now++;\n                    seg0.apply(l, r, T{now});\n \
    \                   tm.action(l, r, now);\n                }\n            }\n\
    \        }\n    }\n}\n\nTEST(LazySegtreeStressTest, MinLeftTest) {\n    for (int\
    \ n = 1; n <= 30; n++) {\n        for (int ph = 0; ph < 10; ph++) {\n        \
    \    seg seg0(n);\n            time_manager tm(n);\n            for (int i = 0;\
    \ i < n; i++) {\n                seg0.set(i, S{i, i + 1, -1});\n            }\n\
    \            int now = 0;\n            for (int q = 0; q < 1000; q++) {\n    \
    \            int ty = randint(0, 2);\n                int l, r;\n            \
    \    std::tie(l, r) = randpair(0, n);\n                if (ty == 0) {\n      \
    \              ASSERT_EQ(l, seg0.min_left(r, [&](S s) {\n                    \
    \    if (s.l == -1) return true;\n                        assert(s.r == r);\n\
    \                        assert(s.time == tm.prod(s.l, r));\n                \
    \        return l <= s.l;\n                    }));\n                } else {\n\
    \                    now++;\n                    seg0.apply(l, r, T{now});\n \
    \                   tm.action(l, r, now);\n                }\n            }\n\
    \        }\n    }\n}\n"
  dependsOn: []
  isVerificationFile: false
  path: test/unittest/lazysegtree_stress_test.cpp
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: test/unittest/lazysegtree_stress_test.cpp
layout: document
redirect_from:
- /library/test/unittest/lazysegtree_stress_test.cpp
- /library/test/unittest/lazysegtree_stress_test.cpp.html
title: test/unittest/lazysegtree_stress_test.cpp
---
