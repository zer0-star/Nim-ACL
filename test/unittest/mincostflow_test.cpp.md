---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _pathExtension: cpp
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "#line 1 \"test/unittest/mincostflow_test.cpp\"\n#include <gtest/gtest.h>\n\
    \n#include <atcoder/mincostflow>\n#include <numeric>\n#include <tuple>\n#include\
    \ <vector>\n\nusing namespace atcoder;\nusing ll = long long;\nusing ull = unsigned\
    \ long long;\n\nTEST(MincostflowTest, Zero) {\n    mcf_graph<int, int> g1;\n \
    \   mcf_graph<int, int> g2(0);\n}\n\ntemplate <class edge> void edge_eq(edge expect,\
    \ edge actual) {\n    ASSERT_EQ(expect.from, actual.from);\n    ASSERT_EQ(expect.to,\
    \ actual.to);\n    ASSERT_EQ(expect.cap, actual.cap);\n    ASSERT_EQ(expect.flow,\
    \ actual.flow);\n    ASSERT_EQ(expect.cost, actual.cost);\n}\n\nTEST(MincostflowTest,\
    \ Simple) {\n    mcf_graph<int, int> g(4);\n    g.add_edge(0, 1, 1, 1);\n    g.add_edge(0,\
    \ 2, 1, 1);\n    g.add_edge(1, 3, 1, 1);\n    g.add_edge(2, 3, 1, 1);\n    g.add_edge(1,\
    \ 2, 1, 1);\n    auto expect = std::vector<std::pair<int, int>>({{0, 0}, {2, 4}});\n\
    \    ASSERT_EQ(expect, g.slope(0, 3, 10));\n    mcf_graph<int, int>::edge e;\n\
    \n    e = {0, 1, 1, 1, 1};\n    edge_eq(e, g.get_edge(0));\n    e = {0, 2, 1,\
    \ 1, 1};\n    edge_eq(e, g.get_edge(1));\n    e = {1, 3, 1, 1, 1};\n    edge_eq(e,\
    \ g.get_edge(2));\n    e = {2, 3, 1, 1, 1};\n    edge_eq(e, g.get_edge(3));\n\
    \    e = {1, 2, 1, 0, 1};\n    edge_eq(e, g.get_edge(4));\n}\n\nTEST(MincostflowTest,\
    \ Usage) {\n    {\n        mcf_graph<int, int> g(2);\n        g.add_edge(0, 1,\
    \ 1, 2);\n        ASSERT_EQ(std::make_pair(1, 2), g.flow(0, 1));\n    }\n    {\n\
    \        mcf_graph<int, int> g(2);\n        g.add_edge(0, 1, 1, 2);\n        auto\
    \ expect = std::vector<std::pair<int, int>>({{0, 0}, {1, 2}});\n        ASSERT_EQ(expect,\
    \ g.slope(0, 1));\n    }\n}\n\nTEST(MincostflowTest, Assign) {\n    mcf_graph<int,\
    \ int> g;\n    g = mcf_graph<int, int>(10);\n}\n\nTEST(MincostflowTest, OutOfRange)\
    \ {\n    mcf_graph<int, int> g(10);\n    \n    EXPECT_DEATH(g.slope(-1, 3), \"\
    .*\");\n    EXPECT_DEATH(g.slope(3, 3), \".*\");\n}\n\n// https://github.com/atcoder/ac-library/issues/1\n\
    TEST(MincostflowTest, SelfLoop) {\n    mcf_graph<int, int> g(3);\n    ASSERT_EQ(0,\
    \ g.add_edge(0, 0, 100, 123));\n\n    mcf_graph<int, int>::edge e = {0, 0, 100,\
    \ 0, 123};\n    edge_eq(e, g.get_edge(0));\n}\n\nTEST(MincostflowTest, SameCostPaths)\
    \ {\n    mcf_graph<int, int> g(3);\n    ASSERT_EQ(0, g.add_edge(0, 1, 1, 1));\n\
    \    ASSERT_EQ(1, g.add_edge(1, 2, 1, 0));\n    ASSERT_EQ(2, g.add_edge(0, 2,\
    \ 2, 1));\n    auto expected = std::vector<std::pair<int, int>>{{0, 0}, {3, 3}};\n\
    \    ASSERT_EQ(expected, g.slope(0, 2));\n}\n\nTEST(MincostflowTest, Invalid)\
    \ {\n    mcf_graph<int, int> g(2);\n    // https://github.com/atcoder/ac-library/issues/51\n\
    \    EXPECT_DEATH(g.add_edge(0, 0, -1, 0), \".*\");\n    EXPECT_DEATH(g.add_edge(0,\
    \ 0, 0, -1), \".*\");\n}\n"
  code: "#include <gtest/gtest.h>\n\n#include <atcoder/mincostflow>\n#include <numeric>\n\
    #include <tuple>\n#include <vector>\n\nusing namespace atcoder;\nusing ll = long\
    \ long;\nusing ull = unsigned long long;\n\nTEST(MincostflowTest, Zero) {\n  \
    \  mcf_graph<int, int> g1;\n    mcf_graph<int, int> g2(0);\n}\n\ntemplate <class\
    \ edge> void edge_eq(edge expect, edge actual) {\n    ASSERT_EQ(expect.from, actual.from);\n\
    \    ASSERT_EQ(expect.to, actual.to);\n    ASSERT_EQ(expect.cap, actual.cap);\n\
    \    ASSERT_EQ(expect.flow, actual.flow);\n    ASSERT_EQ(expect.cost, actual.cost);\n\
    }\n\nTEST(MincostflowTest, Simple) {\n    mcf_graph<int, int> g(4);\n    g.add_edge(0,\
    \ 1, 1, 1);\n    g.add_edge(0, 2, 1, 1);\n    g.add_edge(1, 3, 1, 1);\n    g.add_edge(2,\
    \ 3, 1, 1);\n    g.add_edge(1, 2, 1, 1);\n    auto expect = std::vector<std::pair<int,\
    \ int>>({{0, 0}, {2, 4}});\n    ASSERT_EQ(expect, g.slope(0, 3, 10));\n    mcf_graph<int,\
    \ int>::edge e;\n\n    e = {0, 1, 1, 1, 1};\n    edge_eq(e, g.get_edge(0));\n\
    \    e = {0, 2, 1, 1, 1};\n    edge_eq(e, g.get_edge(1));\n    e = {1, 3, 1, 1,\
    \ 1};\n    edge_eq(e, g.get_edge(2));\n    e = {2, 3, 1, 1, 1};\n    edge_eq(e,\
    \ g.get_edge(3));\n    e = {1, 2, 1, 0, 1};\n    edge_eq(e, g.get_edge(4));\n\
    }\n\nTEST(MincostflowTest, Usage) {\n    {\n        mcf_graph<int, int> g(2);\n\
    \        g.add_edge(0, 1, 1, 2);\n        ASSERT_EQ(std::make_pair(1, 2), g.flow(0,\
    \ 1));\n    }\n    {\n        mcf_graph<int, int> g(2);\n        g.add_edge(0,\
    \ 1, 1, 2);\n        auto expect = std::vector<std::pair<int, int>>({{0, 0}, {1,\
    \ 2}});\n        ASSERT_EQ(expect, g.slope(0, 1));\n    }\n}\n\nTEST(MincostflowTest,\
    \ Assign) {\n    mcf_graph<int, int> g;\n    g = mcf_graph<int, int>(10);\n}\n\
    \nTEST(MincostflowTest, OutOfRange) {\n    mcf_graph<int, int> g(10);\n    \n\
    \    EXPECT_DEATH(g.slope(-1, 3), \".*\");\n    EXPECT_DEATH(g.slope(3, 3), \"\
    .*\");\n}\n\n// https://github.com/atcoder/ac-library/issues/1\nTEST(MincostflowTest,\
    \ SelfLoop) {\n    mcf_graph<int, int> g(3);\n    ASSERT_EQ(0, g.add_edge(0, 0,\
    \ 100, 123));\n\n    mcf_graph<int, int>::edge e = {0, 0, 100, 0, 123};\n    edge_eq(e,\
    \ g.get_edge(0));\n}\n\nTEST(MincostflowTest, SameCostPaths) {\n    mcf_graph<int,\
    \ int> g(3);\n    ASSERT_EQ(0, g.add_edge(0, 1, 1, 1));\n    ASSERT_EQ(1, g.add_edge(1,\
    \ 2, 1, 0));\n    ASSERT_EQ(2, g.add_edge(0, 2, 2, 1));\n    auto expected = std::vector<std::pair<int,\
    \ int>>{{0, 0}, {3, 3}};\n    ASSERT_EQ(expected, g.slope(0, 2));\n}\n\nTEST(MincostflowTest,\
    \ Invalid) {\n    mcf_graph<int, int> g(2);\n    // https://github.com/atcoder/ac-library/issues/51\n\
    \    EXPECT_DEATH(g.add_edge(0, 0, -1, 0), \".*\");\n    EXPECT_DEATH(g.add_edge(0,\
    \ 0, 0, -1), \".*\");\n}\n"
  dependsOn: []
  isVerificationFile: false
  path: test/unittest/mincostflow_test.cpp
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: test/unittest/mincostflow_test.cpp
layout: document
redirect_from:
- /library/test/unittest/mincostflow_test.cpp
- /library/test/unittest/mincostflow_test.cpp.html
title: test/unittest/mincostflow_test.cpp
---
