---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _pathExtension: cpp
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "#line 1 \"test/unittest/maxflow_test.cpp\"\n#include <gtest/gtest.h>\n\
    \n#include <atcoder/maxflow>\n#include <numeric>\n#include <tuple>\n#include <vector>\n\
    #line 1 \"test/utils/random.hpp\"\n\n#include <random>\n\nstd::mt19937 global_mt19937;\n\
    \n// random choise from [a, b]\ntemplate <class T>\nT randint(T a, T b) {\n  \
    \  return std::uniform_int_distribution<T>(a, b)(global_mt19937);\n}\n\nbool randbool()\
    \ {\n    return randint(0, 1) == 0;\n}\n\n// random choice 2 disjoint elements\
    \ from [lower, upper]\ntemplate <class T> std::pair<T, T> randpair(T lower, T\
    \ upper) {\n    assert(upper - lower >= 1);\n    T a, b;\n    do {\n        a\
    \ = randint(lower, upper);\n        b = randint(lower, upper);\n    } while (a\
    \ == b);\n    if (a > b) std::swap(a, b);\n    return {a, b};\n}\n#line 8 \"test/unittest/maxflow_test.cpp\"\
    \n\nusing namespace atcoder;\nusing ll = long long;\nusing ull = unsigned long\
    \ long;\n\nTEST(MaxflowTest, Zero) {\n    mf_graph<int> g1;\n    mf_graph<int>\
    \ g2(0);\n}\n\nTEST(MaxflowTest, Assign) {\n    mf_graph<int> g;\n    g = mf_graph<int>(10);\n\
    }\n\ntemplate <class edge> void edge_eq(edge expect, edge actual) {\n    ASSERT_EQ(expect.from,\
    \ actual.from);\n    ASSERT_EQ(expect.to, actual.to);\n    ASSERT_EQ(expect.cap,\
    \ actual.cap);\n    ASSERT_EQ(expect.flow, actual.flow);\n}\n\nTEST(MaxflowTest,\
    \ Simple) {\n    mf_graph<int> g(4);\n    ASSERT_EQ(0, g.add_edge(0, 1, 1));\n\
    \    ASSERT_EQ(1, g.add_edge(0, 2, 1));\n    ASSERT_EQ(2, g.add_edge(1, 3, 1));\n\
    \    ASSERT_EQ(3, g.add_edge(2, 3, 1));\n    ASSERT_EQ(4, g.add_edge(1, 2, 1));\n\
    \    ASSERT_EQ(2, g.flow(0, 3));\n\n    mf_graph<int>::edge e;\n    e = {0, 1,\
    \ 1, 1};\n    edge_eq(e, g.get_edge(0));\n    e = {0, 2, 1, 1};\n    edge_eq(e,\
    \ g.get_edge(1));\n    e = {1, 3, 1, 1};\n    edge_eq(e, g.get_edge(2));\n   \
    \ e = {2, 3, 1, 1};\n    edge_eq(e, g.get_edge(3));\n    e = {1, 2, 1, 0};\n \
    \   edge_eq(e, g.get_edge(4));\n\n    ASSERT_EQ((std::vector<bool>{true, false,\
    \ false, false}), g.min_cut(0));\n}\n\nTEST(MaxflowTest, NotSimple) {\n    mf_graph<int>\
    \ g(2);\n    ASSERT_EQ(0, g.add_edge(0, 1, 1));\n    ASSERT_EQ(1, g.add_edge(0,\
    \ 1, 2));\n    ASSERT_EQ(2, g.add_edge(0, 1, 3));\n    ASSERT_EQ(3, g.add_edge(0,\
    \ 1, 4));\n    ASSERT_EQ(4, g.add_edge(0, 1, 5));\n    ASSERT_EQ(5, g.add_edge(0,\
    \ 0, 6));\n    ASSERT_EQ(6, g.add_edge(1, 1, 7));\n    ASSERT_EQ(15, g.flow(0,\
    \ 1));\n\n    mf_graph<int>::edge e;\n    e = {0, 1, 1, 1};\n    edge_eq(e, g.get_edge(0));\n\
    \    e = {0, 1, 2, 2};\n    edge_eq(e, g.get_edge(1));\n    e = {0, 1, 3, 3};\n\
    \    edge_eq(e, g.get_edge(2));\n    e = {0, 1, 4, 4};\n    edge_eq(e, g.get_edge(3));\n\
    \    e = {0, 1, 5, 5};\n    edge_eq(e, g.get_edge(4));\n\n    ASSERT_EQ((std::vector<bool>{true,\
    \ false}), g.min_cut(0));\n}\n\nTEST(MaxflowTest, Cut) {\n    mf_graph<int> g(3);\n\
    \    ASSERT_EQ(0, g.add_edge(0, 1, 2));\n    ASSERT_EQ(1, g.add_edge(1, 2, 1));\n\
    \    ASSERT_EQ(1, g.flow(0, 2));\n\n    mf_graph<int>::edge e;\n    e = {0, 1,\
    \ 2, 1};\n    edge_eq(e, g.get_edge(0));\n    e = {1, 2, 1, 1};\n    edge_eq(e,\
    \ g.get_edge(1));\n\n    ASSERT_EQ((std::vector<bool>{true, true, false}), g.min_cut(0));\n\
    }\n\nTEST(MaxflowTest, Twice) {\n    mf_graph<int>::edge e;\n\n    mf_graph<int>\
    \ g(3);\n    ASSERT_EQ(0, g.add_edge(0, 1, 1));\n    ASSERT_EQ(1, g.add_edge(0,\
    \ 2, 1));\n    ASSERT_EQ(2, g.add_edge(1, 2, 1));\n    \n    ASSERT_EQ(2, g.flow(0,\
    \ 2));\n\n    e = {0, 1, 1, 1};\n    edge_eq(e, g.get_edge(0));\n    e = {0, 2,\
    \ 1, 1};\n    edge_eq(e, g.get_edge(1));\n    e = {1, 2, 1, 1};\n    edge_eq(e,\
    \ g.get_edge(2));\n\n    g.change_edge(0, 100, 10);\n    e = {0, 1, 100, 10};\n\
    \    edge_eq(e, g.get_edge(0));\n\n    ASSERT_EQ(0, g.flow(0, 2));\n    ASSERT_EQ(90,\
    \ g.flow(0, 1));\n\n    e = {0, 1, 100, 100};\n    edge_eq(e, g.get_edge(0));\n\
    \    e = {0, 2, 1, 1};\n    edge_eq(e, g.get_edge(1));\n    e = {1, 2, 1, 1};\n\
    \    edge_eq(e, g.get_edge(2));\n\n    ASSERT_EQ(2, g.flow(2, 0));\n\n    e =\
    \ {0, 1, 100, 99};\n    edge_eq(e, g.get_edge(0));\n    e = {0, 2, 1, 0};\n  \
    \  edge_eq(e, g.get_edge(1));\n    e = {1, 2, 1, 0};\n    edge_eq(e, g.get_edge(2));\n\
    }\n\nTEST(MaxflowTest, Bound) {\n    mf_graph<int>::edge e;\n\n    const int INF\
    \ = std::numeric_limits<int>::max();\n    mf_graph<int> g(3);\n    ASSERT_EQ(0,\
    \ g.add_edge(0, 1, INF));\n    ASSERT_EQ(1, g.add_edge(1, 0, INF));\n    ASSERT_EQ(2,\
    \ g.add_edge(0, 2, INF));\n\n    ASSERT_EQ(INF, g.flow(0, 2));\n\n    e = {0,\
    \ 1, INF, 0};\n    edge_eq(e, g.get_edge(0));\n    e = {1, 0, INF, 0};\n    edge_eq(e,\
    \ g.get_edge(1));\n    e = {0, 2, INF, INF};\n    edge_eq(e, g.get_edge(2));\n\
    }\n\nTEST(MaxflowTest, BoundUint) {\n    mf_graph<unsigned int>::edge e;\n\n \
    \   const unsigned int INF = std::numeric_limits<unsigned int>::max();\n    mf_graph<unsigned\
    \ int> g(3);\n    ASSERT_EQ(0, g.add_edge(0, 1, INF));\n    ASSERT_EQ(1, g.add_edge(1,\
    \ 0, INF));\n    ASSERT_EQ(2, g.add_edge(0, 2, INF));\n\n    ASSERT_EQ(INF, g.flow(0,\
    \ 2));\n\n    e = {0, 1, INF, 0};\n    edge_eq(e, g.get_edge(0));\n    e = {1,\
    \ 0, INF, 0};\n    edge_eq(e, g.get_edge(1));\n    e = {0, 2, INF, INF};\n   \
    \ edge_eq(e, g.get_edge(2));\n}\n\n// https://github.com/atcoder/ac-library/issues/1\n\
    TEST(MaxflowTest, SelfLoop) {\n    mf_graph<int> g(3);\n    ASSERT_EQ(0, g.add_edge(0,\
    \ 0, 100));\n\n    mf_graph<int>::edge e = {0, 0, 100, 0};\n    edge_eq(e, g.get_edge(0));\n\
    }\n\nTEST(MaxflowTest, Invalid) {\n    mf_graph<int> g(2);\n    // https://github.com/atcoder/ac-library/issues/5\n\
    \    EXPECT_DEATH(g.flow(0, 0), \".*\");\n    EXPECT_DEATH(g.flow(0, 0, 0), \"\
    .*\");\n}\n\nTEST(MaxflowTest, Stress) {\n    for (int phase = 0; phase < 10000;\
    \ phase++) {\n        int n = randint(2, 20);\n        int m = randint(1, 100);\n\
    \        int s, t;\n        std::tie(s, t) = randpair(0, n - 1);\n        if (randbool())\
    \ std::swap(s, t);\n\n        mf_graph<int> g(n);\n        for (int i = 0; i <\
    \ m; i++) {\n            int u = randint(0, n - 1);\n            int v = randint(0,\
    \ n - 1);\n            int c = randint(0, 10000);\n            g.add_edge(u, v,\
    \ c);\n        }\n        int flow = g.flow(s, t);\n        int dual = 0;\n  \
    \      auto cut = g.min_cut(s);\n        std::vector<int> v_flow(n);\n       \
    \ for (auto e: g.edges()) {\n            v_flow[e.from] -= e.flow;\n         \
    \   v_flow[e.to] += e.flow;\n            if (cut[e.from] && !cut[e.to]) dual +=\
    \ e.cap;\n        }\n        ASSERT_EQ(flow, dual);\n        ASSERT_EQ(-flow,\
    \ v_flow[s]);\n        ASSERT_EQ(flow, v_flow[t]);\n        for (int i = 0; i\
    \ < n; i++) {\n            if (i == s || i == t) continue;\n            ASSERT_EQ(0,\
    \ v_flow[i]);\n        }\n    }\n}\n"
  code: "#include <gtest/gtest.h>\n\n#include <atcoder/maxflow>\n#include <numeric>\n\
    #include <tuple>\n#include <vector>\n#include \"../utils/random.hpp\"\n\nusing\
    \ namespace atcoder;\nusing ll = long long;\nusing ull = unsigned long long;\n\
    \nTEST(MaxflowTest, Zero) {\n    mf_graph<int> g1;\n    mf_graph<int> g2(0);\n\
    }\n\nTEST(MaxflowTest, Assign) {\n    mf_graph<int> g;\n    g = mf_graph<int>(10);\n\
    }\n\ntemplate <class edge> void edge_eq(edge expect, edge actual) {\n    ASSERT_EQ(expect.from,\
    \ actual.from);\n    ASSERT_EQ(expect.to, actual.to);\n    ASSERT_EQ(expect.cap,\
    \ actual.cap);\n    ASSERT_EQ(expect.flow, actual.flow);\n}\n\nTEST(MaxflowTest,\
    \ Simple) {\n    mf_graph<int> g(4);\n    ASSERT_EQ(0, g.add_edge(0, 1, 1));\n\
    \    ASSERT_EQ(1, g.add_edge(0, 2, 1));\n    ASSERT_EQ(2, g.add_edge(1, 3, 1));\n\
    \    ASSERT_EQ(3, g.add_edge(2, 3, 1));\n    ASSERT_EQ(4, g.add_edge(1, 2, 1));\n\
    \    ASSERT_EQ(2, g.flow(0, 3));\n\n    mf_graph<int>::edge e;\n    e = {0, 1,\
    \ 1, 1};\n    edge_eq(e, g.get_edge(0));\n    e = {0, 2, 1, 1};\n    edge_eq(e,\
    \ g.get_edge(1));\n    e = {1, 3, 1, 1};\n    edge_eq(e, g.get_edge(2));\n   \
    \ e = {2, 3, 1, 1};\n    edge_eq(e, g.get_edge(3));\n    e = {1, 2, 1, 0};\n \
    \   edge_eq(e, g.get_edge(4));\n\n    ASSERT_EQ((std::vector<bool>{true, false,\
    \ false, false}), g.min_cut(0));\n}\n\nTEST(MaxflowTest, NotSimple) {\n    mf_graph<int>\
    \ g(2);\n    ASSERT_EQ(0, g.add_edge(0, 1, 1));\n    ASSERT_EQ(1, g.add_edge(0,\
    \ 1, 2));\n    ASSERT_EQ(2, g.add_edge(0, 1, 3));\n    ASSERT_EQ(3, g.add_edge(0,\
    \ 1, 4));\n    ASSERT_EQ(4, g.add_edge(0, 1, 5));\n    ASSERT_EQ(5, g.add_edge(0,\
    \ 0, 6));\n    ASSERT_EQ(6, g.add_edge(1, 1, 7));\n    ASSERT_EQ(15, g.flow(0,\
    \ 1));\n\n    mf_graph<int>::edge e;\n    e = {0, 1, 1, 1};\n    edge_eq(e, g.get_edge(0));\n\
    \    e = {0, 1, 2, 2};\n    edge_eq(e, g.get_edge(1));\n    e = {0, 1, 3, 3};\n\
    \    edge_eq(e, g.get_edge(2));\n    e = {0, 1, 4, 4};\n    edge_eq(e, g.get_edge(3));\n\
    \    e = {0, 1, 5, 5};\n    edge_eq(e, g.get_edge(4));\n\n    ASSERT_EQ((std::vector<bool>{true,\
    \ false}), g.min_cut(0));\n}\n\nTEST(MaxflowTest, Cut) {\n    mf_graph<int> g(3);\n\
    \    ASSERT_EQ(0, g.add_edge(0, 1, 2));\n    ASSERT_EQ(1, g.add_edge(1, 2, 1));\n\
    \    ASSERT_EQ(1, g.flow(0, 2));\n\n    mf_graph<int>::edge e;\n    e = {0, 1,\
    \ 2, 1};\n    edge_eq(e, g.get_edge(0));\n    e = {1, 2, 1, 1};\n    edge_eq(e,\
    \ g.get_edge(1));\n\n    ASSERT_EQ((std::vector<bool>{true, true, false}), g.min_cut(0));\n\
    }\n\nTEST(MaxflowTest, Twice) {\n    mf_graph<int>::edge e;\n\n    mf_graph<int>\
    \ g(3);\n    ASSERT_EQ(0, g.add_edge(0, 1, 1));\n    ASSERT_EQ(1, g.add_edge(0,\
    \ 2, 1));\n    ASSERT_EQ(2, g.add_edge(1, 2, 1));\n    \n    ASSERT_EQ(2, g.flow(0,\
    \ 2));\n\n    e = {0, 1, 1, 1};\n    edge_eq(e, g.get_edge(0));\n    e = {0, 2,\
    \ 1, 1};\n    edge_eq(e, g.get_edge(1));\n    e = {1, 2, 1, 1};\n    edge_eq(e,\
    \ g.get_edge(2));\n\n    g.change_edge(0, 100, 10);\n    e = {0, 1, 100, 10};\n\
    \    edge_eq(e, g.get_edge(0));\n\n    ASSERT_EQ(0, g.flow(0, 2));\n    ASSERT_EQ(90,\
    \ g.flow(0, 1));\n\n    e = {0, 1, 100, 100};\n    edge_eq(e, g.get_edge(0));\n\
    \    e = {0, 2, 1, 1};\n    edge_eq(e, g.get_edge(1));\n    e = {1, 2, 1, 1};\n\
    \    edge_eq(e, g.get_edge(2));\n\n    ASSERT_EQ(2, g.flow(2, 0));\n\n    e =\
    \ {0, 1, 100, 99};\n    edge_eq(e, g.get_edge(0));\n    e = {0, 2, 1, 0};\n  \
    \  edge_eq(e, g.get_edge(1));\n    e = {1, 2, 1, 0};\n    edge_eq(e, g.get_edge(2));\n\
    }\n\nTEST(MaxflowTest, Bound) {\n    mf_graph<int>::edge e;\n\n    const int INF\
    \ = std::numeric_limits<int>::max();\n    mf_graph<int> g(3);\n    ASSERT_EQ(0,\
    \ g.add_edge(0, 1, INF));\n    ASSERT_EQ(1, g.add_edge(1, 0, INF));\n    ASSERT_EQ(2,\
    \ g.add_edge(0, 2, INF));\n\n    ASSERT_EQ(INF, g.flow(0, 2));\n\n    e = {0,\
    \ 1, INF, 0};\n    edge_eq(e, g.get_edge(0));\n    e = {1, 0, INF, 0};\n    edge_eq(e,\
    \ g.get_edge(1));\n    e = {0, 2, INF, INF};\n    edge_eq(e, g.get_edge(2));\n\
    }\n\nTEST(MaxflowTest, BoundUint) {\n    mf_graph<unsigned int>::edge e;\n\n \
    \   const unsigned int INF = std::numeric_limits<unsigned int>::max();\n    mf_graph<unsigned\
    \ int> g(3);\n    ASSERT_EQ(0, g.add_edge(0, 1, INF));\n    ASSERT_EQ(1, g.add_edge(1,\
    \ 0, INF));\n    ASSERT_EQ(2, g.add_edge(0, 2, INF));\n\n    ASSERT_EQ(INF, g.flow(0,\
    \ 2));\n\n    e = {0, 1, INF, 0};\n    edge_eq(e, g.get_edge(0));\n    e = {1,\
    \ 0, INF, 0};\n    edge_eq(e, g.get_edge(1));\n    e = {0, 2, INF, INF};\n   \
    \ edge_eq(e, g.get_edge(2));\n}\n\n// https://github.com/atcoder/ac-library/issues/1\n\
    TEST(MaxflowTest, SelfLoop) {\n    mf_graph<int> g(3);\n    ASSERT_EQ(0, g.add_edge(0,\
    \ 0, 100));\n\n    mf_graph<int>::edge e = {0, 0, 100, 0};\n    edge_eq(e, g.get_edge(0));\n\
    }\n\nTEST(MaxflowTest, Invalid) {\n    mf_graph<int> g(2);\n    // https://github.com/atcoder/ac-library/issues/5\n\
    \    EXPECT_DEATH(g.flow(0, 0), \".*\");\n    EXPECT_DEATH(g.flow(0, 0, 0), \"\
    .*\");\n}\n\nTEST(MaxflowTest, Stress) {\n    for (int phase = 0; phase < 10000;\
    \ phase++) {\n        int n = randint(2, 20);\n        int m = randint(1, 100);\n\
    \        int s, t;\n        std::tie(s, t) = randpair(0, n - 1);\n        if (randbool())\
    \ std::swap(s, t);\n\n        mf_graph<int> g(n);\n        for (int i = 0; i <\
    \ m; i++) {\n            int u = randint(0, n - 1);\n            int v = randint(0,\
    \ n - 1);\n            int c = randint(0, 10000);\n            g.add_edge(u, v,\
    \ c);\n        }\n        int flow = g.flow(s, t);\n        int dual = 0;\n  \
    \      auto cut = g.min_cut(s);\n        std::vector<int> v_flow(n);\n       \
    \ for (auto e: g.edges()) {\n            v_flow[e.from] -= e.flow;\n         \
    \   v_flow[e.to] += e.flow;\n            if (cut[e.from] && !cut[e.to]) dual +=\
    \ e.cap;\n        }\n        ASSERT_EQ(flow, dual);\n        ASSERT_EQ(-flow,\
    \ v_flow[s]);\n        ASSERT_EQ(flow, v_flow[t]);\n        for (int i = 0; i\
    \ < n; i++) {\n            if (i == s || i == t) continue;\n            ASSERT_EQ(0,\
    \ v_flow[i]);\n        }\n    }\n}\n"
  dependsOn: []
  isVerificationFile: false
  path: test/unittest/maxflow_test.cpp
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: test/unittest/maxflow_test.cpp
layout: document
redirect_from:
- /library/test/unittest/maxflow_test.cpp
- /library/test/unittest/maxflow_test.cpp.html
title: test/unittest/maxflow_test.cpp
---
