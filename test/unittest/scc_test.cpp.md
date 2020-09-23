---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _pathExtension: cpp
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "#line 1 \"test/unittest/scc_test.cpp\"\n#include <gtest/gtest.h>\n\
    \n#include <atcoder/scc>\n#include <atcoder/modint>\n#include <numeric>\n\nusing\
    \ namespace atcoder;\nusing ll = long long;\nusing ull = unsigned long long;\n\
    \nTEST(SCCTest, Empty) {\n    scc_graph graph0;\n    ASSERT_EQ(std::vector<std::vector<int>>(),\
    \ graph0.scc());\n    scc_graph graph1(0);\n    ASSERT_EQ(std::vector<std::vector<int>>(),\
    \ graph1.scc());\n}\n\nTEST(SCCTest, Assign) {\n    scc_graph graph;\n    graph\
    \ = scc_graph(10);\n}\n\nTEST(SCCTest, Simple) {\n    scc_graph graph(2);\n  \
    \  graph.add_edge(0, 1);\n    graph.add_edge(1, 0);\n    auto scc = graph.scc();\n\
    \    ASSERT_EQ(1, scc.size());\n}\n\nTEST(SCCTest, SelfLoop) {\n    scc_graph\
    \ graph(2);\n    graph.add_edge(0, 0);\n    graph.add_edge(0, 0);\n    graph.add_edge(1,\
    \ 1);\n    auto scc = graph.scc();\n    ASSERT_EQ(2, scc.size());\n}\n\nTEST(SCCTest,\
    \ Invalid) {\n    scc_graph graph(2);\n    EXPECT_DEATH(graph.add_edge(0, 10),\
    \ \".*\");\n}\n"
  code: "#include <gtest/gtest.h>\n\n#include <atcoder/scc>\n#include <atcoder/modint>\n\
    #include <numeric>\n\nusing namespace atcoder;\nusing ll = long long;\nusing ull\
    \ = unsigned long long;\n\nTEST(SCCTest, Empty) {\n    scc_graph graph0;\n   \
    \ ASSERT_EQ(std::vector<std::vector<int>>(), graph0.scc());\n    scc_graph graph1(0);\n\
    \    ASSERT_EQ(std::vector<std::vector<int>>(), graph1.scc());\n}\n\nTEST(SCCTest,\
    \ Assign) {\n    scc_graph graph;\n    graph = scc_graph(10);\n}\n\nTEST(SCCTest,\
    \ Simple) {\n    scc_graph graph(2);\n    graph.add_edge(0, 1);\n    graph.add_edge(1,\
    \ 0);\n    auto scc = graph.scc();\n    ASSERT_EQ(1, scc.size());\n}\n\nTEST(SCCTest,\
    \ SelfLoop) {\n    scc_graph graph(2);\n    graph.add_edge(0, 0);\n    graph.add_edge(0,\
    \ 0);\n    graph.add_edge(1, 1);\n    auto scc = graph.scc();\n    ASSERT_EQ(2,\
    \ scc.size());\n}\n\nTEST(SCCTest, Invalid) {\n    scc_graph graph(2);\n    EXPECT_DEATH(graph.add_edge(0,\
    \ 10), \".*\");\n}\n"
  dependsOn: []
  isVerificationFile: false
  path: test/unittest/scc_test.cpp
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: test/unittest/scc_test.cpp
layout: document
redirect_from:
- /library/test/unittest/scc_test.cpp
- /library/test/unittest/scc_test.cpp.html
title: test/unittest/scc_test.cpp
---
