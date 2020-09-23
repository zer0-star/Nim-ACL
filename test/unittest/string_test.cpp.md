---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _pathExtension: cpp
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "#line 1 \"test/unittest/string_test.cpp\"\n#include <gtest/gtest.h>\n\
    \n#include <algorithm>\n#include <atcoder/string>\n#include <numeric>\n#include\
    \ <vector>\n\nusing namespace atcoder;\nusing ll = long long;\nusing ull = unsigned\
    \ long long;\n\nstd::vector<int> sa_naive(std::vector<int> s) {\n    int n = int(s.size());\n\
    \    std::vector<int> sa(n);\n    std::iota(sa.begin(), sa.end(), 0);\n    std::sort(sa.begin(),\
    \ sa.end(), [&](int l, int r) {\n        return std::vector<int>{s.begin() + l,\
    \ s.end()} <\n               std::vector<int>{s.begin() + r, s.end()};\n    });\n\
    \    return sa;\n}\n\nstd::vector<int> lcp_naive(std::vector<int> s, std::vector<int>\
    \ sa) {\n    int n = int(s.size());\n    assert(n);\n    std::vector<int> lcp(n\
    \ - 1);\n    for (int i = 0; i < n - 1; i++) {\n        int l = sa[i], r = sa[i\
    \ + 1];\n        while (l + lcp[i] < n && r + lcp[i] < n && s[l + lcp[i]] == s[r\
    \ + lcp[i]]) lcp[i]++;\n    }\n    return lcp;\n}\n\nstd::vector<int> z_naive(std::vector<int>\
    \ s) {\n    int n = int(s.size());    \n    std::vector<int> z(n);\n    for (int\
    \ i = 0; i < n; i++) {\n        while (i + z[i] < n && s[z[i]] == s[i + z[i]])\
    \ z[i]++;\n    }\n    return z;\n}\n\nTEST(StringTest, Empty) {\n    ASSERT_EQ(std::vector<int>{},\
    \ suffix_array(\"\"));\n    ASSERT_EQ(std::vector<int>{}, suffix_array(std::vector<int>{}));\n\
    \n    ASSERT_EQ(std::vector<int>{}, z_algorithm(\"\"));\n    ASSERT_EQ(std::vector<int>{},\
    \ z_algorithm(std::vector<int>{}));\n}\n\nTEST(StringTest, SALCPNaive) {\n   \
    \ for (int n = 1; n <= 5; n++) {\n        int m = 1;\n        for (int i = 0;\
    \ i < n; i++) m *= 4;\n        for (int f = 0; f < m; f++) {\n            std::vector<int>\
    \ s(n);\n            int g = f;\n            int max_c = 0;\n            for (int\
    \ i = 0; i < n; i++) {\n                s[i] = g % 4;\n                max_c =\
    \ std::max(max_c, s[i]);\n                g /= 4;\n            }\n           \
    \ auto sa = sa_naive(s);\n            ASSERT_EQ(sa, suffix_array(s));\n      \
    \      ASSERT_EQ(sa, suffix_array(s, max_c));\n            ASSERT_EQ(lcp_naive(s,\
    \ sa), lcp_array(s, sa));\n        }\n    }\n    for (int n = 1; n <= 10; n++)\
    \ {\n        int m = 1;\n        for (int i = 0; i < n; i++) m *= 2;\n       \
    \ for (int f = 0; f < m; f++) {\n            std::vector<int> s(n);\n        \
    \    int g = f;\n            int max_c = 0;\n            for (int i = 0; i < n;\
    \ i++) {\n                s[i] = g % 2;\n                max_c = std::max(max_c,\
    \ s[i]);\n                g /= 2;\n            }\n            auto sa = sa_naive(s);\n\
    \            ASSERT_EQ(sa, suffix_array(s));\n            ASSERT_EQ(sa, suffix_array(s,\
    \ max_c));\n            ASSERT_EQ(lcp_naive(s, sa), lcp_array(s, sa));\n     \
    \   }\n    }\n}\n\nTEST(StringTest, InternalSANaiveNaive) {\n    for (int n =\
    \ 1; n <= 5; n++) {\n        int m = 1;\n        for (int i = 0; i < n; i++) m\
    \ *= 4;\n        for (int f = 0; f < m; f++) {\n            std::vector<int> s(n);\n\
    \            int g = f;\n            int max_c = 0;\n            for (int i =\
    \ 0; i < n; i++) {\n                s[i] = g % 4;\n                max_c = std::max(max_c,\
    \ s[i]);\n                g /= 4;\n            }\n\n            auto sa = internal::sa_naive(s);\n\
    \            ASSERT_EQ(sa_naive(s), sa);\n        }\n    }\n    for (int n = 1;\
    \ n <= 10; n++) {\n        int m = 1;\n        for (int i = 0; i < n; i++) m *=\
    \ 2;\n        for (int f = 0; f < m; f++) {\n            std::vector<int> s(n);\n\
    \            int g = f;\n            for (int i = 0; i < n; i++) {\n         \
    \       s[i] = g % 2;\n                g /= 2;\n            }\n\n            auto\
    \ sa = internal::sa_naive(s);\n            ASSERT_EQ(sa_naive(s), sa);\n     \
    \   }\n    }\n}\n\nTEST(StringTest, InternalSADoublingNaive) {\n    for (int n\
    \ = 1; n <= 5; n++) {\n        int m = 1;\n        for (int i = 0; i < n; i++)\
    \ m *= 4;\n        for (int f = 0; f < m; f++) {\n            std::vector<int>\
    \ s(n);\n            int g = f;\n            for (int i = 0; i < n; i++) {\n \
    \               s[i] = g % 4;\n                g /= 4;\n            }\n\n    \
    \        auto sa = internal::sa_doubling(s);\n            ASSERT_EQ(sa_naive(s),\
    \ sa);\n        }\n    }\n    for (int n = 1; n <= 10; n++) {\n        int m =\
    \ 1;\n        for (int i = 0; i < n; i++) m *= 2;\n        for (int f = 0; f <\
    \ m; f++) {\n            std::vector<int> s(n);\n            int g = f;\n    \
    \        for (int i = 0; i < n; i++) {\n                s[i] = g % 2;\n      \
    \          g /= 2;\n            }\n\n            auto sa = internal::sa_doubling(s);\n\
    \            ASSERT_EQ(sa_naive(s), sa);\n        }\n    }\n}\n\nTEST(StringTest,\
    \ InternalSAISNaive) {\n    for (int n = 1; n <= 5; n++) {\n        int m = 1;\n\
    \        for (int i = 0; i < n; i++) m *= 4;\n        for (int f = 0; f < m; f++)\
    \ {\n            std::vector<int> s(n);\n            int g = f;\n            int\
    \ max_c = 0;\n            for (int i = 0; i < n; i++) {\n                s[i]\
    \ = g % 4;\n                max_c = std::max(max_c, s[i]);\n                g\
    \ /= 4;\n            }\n            \n            auto sa = internal::sa_is<-1,\
    \ -1>(s, max_c);\n            ASSERT_EQ(sa_naive(s), sa);\n        }\n    }\n\
    \    for (int n = 1; n <= 10; n++) {\n        int m = 1;\n        for (int i =\
    \ 0; i < n; i++) m *= 2;\n        for (int f = 0; f < m; f++) {\n            std::vector<int>\
    \ s(n);\n            int g = f;\n            int max_c = 0;\n            for (int\
    \ i = 0; i < n; i++) {\n                s[i] = g % 2;\n                max_c =\
    \ std::max(max_c, s[i]);\n                g /= 2;\n            }\n\n         \
    \   auto sa = internal::sa_is<-1, -1>(s, max_c);\n            ASSERT_EQ(sa_naive(s),\
    \ sa);\n        }\n    }\n}\n\nTEST(StringTest, SAAllATest) {\n    for (int n\
    \ = 1; n <= 100; n++) {\n        std::vector<int> s(n, 10);\n        ASSERT_EQ(sa_naive(s),\
    \ suffix_array(s));\n        ASSERT_EQ(sa_naive(s), suffix_array(s, 10));\n  \
    \      ASSERT_EQ(sa_naive(s), suffix_array(s, 12));\n    }\n}\n\nTEST(StringTest,\
    \ SAAllABTest) {\n    for (int n = 1; n <= 100; n++) {\n        std::vector<int>\
    \ s(n);\n        for (int i = 0; i < n; i++) s[i] = (i % 2);\n        ASSERT_EQ(sa_naive(s),\
    \ suffix_array(s));\n        ASSERT_EQ(sa_naive(s), suffix_array(s, 3));\n   \
    \ }\n    for (int n = 1; n <= 100; n++) {\n        std::vector<int> s(n);\n  \
    \      for (int i = 0; i < n; i++) s[i] = 1 - (i % 2);\n        ASSERT_EQ(sa_naive(s),\
    \ suffix_array(s));\n        ASSERT_EQ(sa_naive(s), suffix_array(s, 3));\n   \
    \ }\n}\n\nTEST(StringTest, SA) {\n    std::string s = \"missisippi\";\n\n    std::vector<int>\
    \ sa = suffix_array(s);\n\n    std::vector<std::string> answer = {\n        \"\
    i\",           // 9\n        \"ippi\",        // 6\n        \"isippi\",      //\
    \ 4\n        \"issisippi\",   // 1\n        \"missisippi\",  // 0\n        \"\
    pi\",          // 8\n        \"ppi\",         // 7\n        \"sippi\",       //\
    \ 5\n        \"sisippi\",     // 3\n        \"ssisippi\",    // 2\n    };\n\n\
    \    ASSERT_EQ(answer.size(), sa.size());\n\n    for (int i = 0; i < int(sa.size());\
    \ i++) {\n        ASSERT_EQ(answer[i], s.substr(sa[i]));\n    }\n}\n\nTEST(StringTest,\
    \ SASingle) {\n    ASSERT_EQ(std::vector<int>({0}), suffix_array(std::vector<int>{0}));\n\
    \    ASSERT_EQ(std::vector<int>({0}), suffix_array(std::vector<int>{-1}));\n \
    \   ASSERT_EQ(std::vector<int>({0}), suffix_array(std::vector<int>{1}));\n   \
    \ ASSERT_EQ(std::vector<int>({0}),\n              suffix_array(std::vector<int>{std::numeric_limits<int>::min()}));\n\
    \    ASSERT_EQ(std::vector<int>({0}),\n              suffix_array(std::vector<int>{std::numeric_limits<int>::max()}));\n\
    }\n\nTEST(StringTest, LCP) {\n    std::string s = \"aab\";\n    auto sa = suffix_array(s);\n\
    \    ASSERT_EQ(std::vector<int>({0, 1, 2}), sa);\n    auto lcp = lcp_array(s,\
    \ sa);\n    ASSERT_EQ(std::vector<int>({1, 0}), lcp);\n\n    ASSERT_EQ(lcp, lcp_array(std::vector<int>({0,\
    \ 0, 1}), sa));\n    ASSERT_EQ(lcp, lcp_array(std::vector<int>({-100, -100, 100}),\
    \ sa));\n    ASSERT_EQ(lcp,\n              lcp_array(std::vector<int>({std::numeric_limits<int>::min(),\n\
    \                                          std::numeric_limits<int>::min(),\n\
    \                                          std::numeric_limits<int>::max()}),\n\
    \                        sa));\n\n    ASSERT_EQ(lcp, lcp_array(std::vector<long\
    \ long>(\n                                 {std::numeric_limits<long long>::min(),\n\
    \                                  std::numeric_limits<long long>::min(),\n  \
    \                                std::numeric_limits<long long>::max()}),\n  \
    \                           sa));\n    ASSERT_EQ(lcp, lcp_array(std::vector<unsigned\
    \ int>(\n                                 {std::numeric_limits<unsigned int>::min(),\n\
    \                                  std::numeric_limits<unsigned int>::min(),\n\
    \                                  std::numeric_limits<unsigned int>::max()}),\n\
    \                             sa));\n    ASSERT_EQ(lcp,\n              lcp_array(std::vector<unsigned\
    \ long long>(\n                            {std::numeric_limits<unsigned long\
    \ long>::min(),\n                             std::numeric_limits<unsigned long\
    \ long>::min(),\n                             std::numeric_limits<unsigned long\
    \ long>::max()}),\n                        sa));\n}\n\nTEST(StringTest, ZAlgo)\
    \ {\n    std::string s = \"abab\";\n    auto z = z_algorithm(s);\n    ASSERT_EQ(std::vector<int>({4,\
    \ 0, 2, 0}), z);\n    ASSERT_EQ(std::vector<int>({4, 0, 2, 0}),\n            \
    \  z_algorithm(std::vector<int>{1, 10, 1, 10}));\n    ASSERT_EQ(z_naive({0, 0,\
    \ 0, 0, 0, 0, 0}), z_algorithm({0, 0, 0, 0, 0, 0, 0}));\n}\n\nTEST(StringTest,\
    \ ZNaive) {\n    for (int n = 1; n <= 6; n++) {\n        int m = 1;\n        for\
    \ (int i = 0; i < n; i++) m *= 4;\n        for (int f = 0; f < m; f++) {\n   \
    \         std::vector<int> s(n);\n            int g = f;\n            for (int\
    \ i = 0; i < n; i++) {\n                s[i] = g % 4;\n                g /= 4;\n\
    \            }\n            ASSERT_EQ(z_naive(s), z_algorithm(s));\n        }\n\
    \    }\n    for (int n = 1; n <= 10; n++) {\n        int m = 1;\n        for (int\
    \ i = 0; i < n; i++) m *= 2;\n        for (int f = 0; f < m; f++) {\n        \
    \    std::vector<int> s(n);\n            int g = f;\n            for (int i =\
    \ 0; i < n; i++) {\n                s[i] = g % 2;\n                g /= 2;\n \
    \           }\n            ASSERT_EQ(z_naive(s), z_algorithm(s));\n        }\n\
    \    }\n}\n"
  code: "#include <gtest/gtest.h>\n\n#include <algorithm>\n#include <atcoder/string>\n\
    #include <numeric>\n#include <vector>\n\nusing namespace atcoder;\nusing ll =\
    \ long long;\nusing ull = unsigned long long;\n\nstd::vector<int> sa_naive(std::vector<int>\
    \ s) {\n    int n = int(s.size());\n    std::vector<int> sa(n);\n    std::iota(sa.begin(),\
    \ sa.end(), 0);\n    std::sort(sa.begin(), sa.end(), [&](int l, int r) {\n   \
    \     return std::vector<int>{s.begin() + l, s.end()} <\n               std::vector<int>{s.begin()\
    \ + r, s.end()};\n    });\n    return sa;\n}\n\nstd::vector<int> lcp_naive(std::vector<int>\
    \ s, std::vector<int> sa) {\n    int n = int(s.size());\n    assert(n);\n    std::vector<int>\
    \ lcp(n - 1);\n    for (int i = 0; i < n - 1; i++) {\n        int l = sa[i], r\
    \ = sa[i + 1];\n        while (l + lcp[i] < n && r + lcp[i] < n && s[l + lcp[i]]\
    \ == s[r + lcp[i]]) lcp[i]++;\n    }\n    return lcp;\n}\n\nstd::vector<int> z_naive(std::vector<int>\
    \ s) {\n    int n = int(s.size());    \n    std::vector<int> z(n);\n    for (int\
    \ i = 0; i < n; i++) {\n        while (i + z[i] < n && s[z[i]] == s[i + z[i]])\
    \ z[i]++;\n    }\n    return z;\n}\n\nTEST(StringTest, Empty) {\n    ASSERT_EQ(std::vector<int>{},\
    \ suffix_array(\"\"));\n    ASSERT_EQ(std::vector<int>{}, suffix_array(std::vector<int>{}));\n\
    \n    ASSERT_EQ(std::vector<int>{}, z_algorithm(\"\"));\n    ASSERT_EQ(std::vector<int>{},\
    \ z_algorithm(std::vector<int>{}));\n}\n\nTEST(StringTest, SALCPNaive) {\n   \
    \ for (int n = 1; n <= 5; n++) {\n        int m = 1;\n        for (int i = 0;\
    \ i < n; i++) m *= 4;\n        for (int f = 0; f < m; f++) {\n            std::vector<int>\
    \ s(n);\n            int g = f;\n            int max_c = 0;\n            for (int\
    \ i = 0; i < n; i++) {\n                s[i] = g % 4;\n                max_c =\
    \ std::max(max_c, s[i]);\n                g /= 4;\n            }\n           \
    \ auto sa = sa_naive(s);\n            ASSERT_EQ(sa, suffix_array(s));\n      \
    \      ASSERT_EQ(sa, suffix_array(s, max_c));\n            ASSERT_EQ(lcp_naive(s,\
    \ sa), lcp_array(s, sa));\n        }\n    }\n    for (int n = 1; n <= 10; n++)\
    \ {\n        int m = 1;\n        for (int i = 0; i < n; i++) m *= 2;\n       \
    \ for (int f = 0; f < m; f++) {\n            std::vector<int> s(n);\n        \
    \    int g = f;\n            int max_c = 0;\n            for (int i = 0; i < n;\
    \ i++) {\n                s[i] = g % 2;\n                max_c = std::max(max_c,\
    \ s[i]);\n                g /= 2;\n            }\n            auto sa = sa_naive(s);\n\
    \            ASSERT_EQ(sa, suffix_array(s));\n            ASSERT_EQ(sa, suffix_array(s,\
    \ max_c));\n            ASSERT_EQ(lcp_naive(s, sa), lcp_array(s, sa));\n     \
    \   }\n    }\n}\n\nTEST(StringTest, InternalSANaiveNaive) {\n    for (int n =\
    \ 1; n <= 5; n++) {\n        int m = 1;\n        for (int i = 0; i < n; i++) m\
    \ *= 4;\n        for (int f = 0; f < m; f++) {\n            std::vector<int> s(n);\n\
    \            int g = f;\n            int max_c = 0;\n            for (int i =\
    \ 0; i < n; i++) {\n                s[i] = g % 4;\n                max_c = std::max(max_c,\
    \ s[i]);\n                g /= 4;\n            }\n\n            auto sa = internal::sa_naive(s);\n\
    \            ASSERT_EQ(sa_naive(s), sa);\n        }\n    }\n    for (int n = 1;\
    \ n <= 10; n++) {\n        int m = 1;\n        for (int i = 0; i < n; i++) m *=\
    \ 2;\n        for (int f = 0; f < m; f++) {\n            std::vector<int> s(n);\n\
    \            int g = f;\n            for (int i = 0; i < n; i++) {\n         \
    \       s[i] = g % 2;\n                g /= 2;\n            }\n\n            auto\
    \ sa = internal::sa_naive(s);\n            ASSERT_EQ(sa_naive(s), sa);\n     \
    \   }\n    }\n}\n\nTEST(StringTest, InternalSADoublingNaive) {\n    for (int n\
    \ = 1; n <= 5; n++) {\n        int m = 1;\n        for (int i = 0; i < n; i++)\
    \ m *= 4;\n        for (int f = 0; f < m; f++) {\n            std::vector<int>\
    \ s(n);\n            int g = f;\n            for (int i = 0; i < n; i++) {\n \
    \               s[i] = g % 4;\n                g /= 4;\n            }\n\n    \
    \        auto sa = internal::sa_doubling(s);\n            ASSERT_EQ(sa_naive(s),\
    \ sa);\n        }\n    }\n    for (int n = 1; n <= 10; n++) {\n        int m =\
    \ 1;\n        for (int i = 0; i < n; i++) m *= 2;\n        for (int f = 0; f <\
    \ m; f++) {\n            std::vector<int> s(n);\n            int g = f;\n    \
    \        for (int i = 0; i < n; i++) {\n                s[i] = g % 2;\n      \
    \          g /= 2;\n            }\n\n            auto sa = internal::sa_doubling(s);\n\
    \            ASSERT_EQ(sa_naive(s), sa);\n        }\n    }\n}\n\nTEST(StringTest,\
    \ InternalSAISNaive) {\n    for (int n = 1; n <= 5; n++) {\n        int m = 1;\n\
    \        for (int i = 0; i < n; i++) m *= 4;\n        for (int f = 0; f < m; f++)\
    \ {\n            std::vector<int> s(n);\n            int g = f;\n            int\
    \ max_c = 0;\n            for (int i = 0; i < n; i++) {\n                s[i]\
    \ = g % 4;\n                max_c = std::max(max_c, s[i]);\n                g\
    \ /= 4;\n            }\n            \n            auto sa = internal::sa_is<-1,\
    \ -1>(s, max_c);\n            ASSERT_EQ(sa_naive(s), sa);\n        }\n    }\n\
    \    for (int n = 1; n <= 10; n++) {\n        int m = 1;\n        for (int i =\
    \ 0; i < n; i++) m *= 2;\n        for (int f = 0; f < m; f++) {\n            std::vector<int>\
    \ s(n);\n            int g = f;\n            int max_c = 0;\n            for (int\
    \ i = 0; i < n; i++) {\n                s[i] = g % 2;\n                max_c =\
    \ std::max(max_c, s[i]);\n                g /= 2;\n            }\n\n         \
    \   auto sa = internal::sa_is<-1, -1>(s, max_c);\n            ASSERT_EQ(sa_naive(s),\
    \ sa);\n        }\n    }\n}\n\nTEST(StringTest, SAAllATest) {\n    for (int n\
    \ = 1; n <= 100; n++) {\n        std::vector<int> s(n, 10);\n        ASSERT_EQ(sa_naive(s),\
    \ suffix_array(s));\n        ASSERT_EQ(sa_naive(s), suffix_array(s, 10));\n  \
    \      ASSERT_EQ(sa_naive(s), suffix_array(s, 12));\n    }\n}\n\nTEST(StringTest,\
    \ SAAllABTest) {\n    for (int n = 1; n <= 100; n++) {\n        std::vector<int>\
    \ s(n);\n        for (int i = 0; i < n; i++) s[i] = (i % 2);\n        ASSERT_EQ(sa_naive(s),\
    \ suffix_array(s));\n        ASSERT_EQ(sa_naive(s), suffix_array(s, 3));\n   \
    \ }\n    for (int n = 1; n <= 100; n++) {\n        std::vector<int> s(n);\n  \
    \      for (int i = 0; i < n; i++) s[i] = 1 - (i % 2);\n        ASSERT_EQ(sa_naive(s),\
    \ suffix_array(s));\n        ASSERT_EQ(sa_naive(s), suffix_array(s, 3));\n   \
    \ }\n}\n\nTEST(StringTest, SA) {\n    std::string s = \"missisippi\";\n\n    std::vector<int>\
    \ sa = suffix_array(s);\n\n    std::vector<std::string> answer = {\n        \"\
    i\",           // 9\n        \"ippi\",        // 6\n        \"isippi\",      //\
    \ 4\n        \"issisippi\",   // 1\n        \"missisippi\",  // 0\n        \"\
    pi\",          // 8\n        \"ppi\",         // 7\n        \"sippi\",       //\
    \ 5\n        \"sisippi\",     // 3\n        \"ssisippi\",    // 2\n    };\n\n\
    \    ASSERT_EQ(answer.size(), sa.size());\n\n    for (int i = 0; i < int(sa.size());\
    \ i++) {\n        ASSERT_EQ(answer[i], s.substr(sa[i]));\n    }\n}\n\nTEST(StringTest,\
    \ SASingle) {\n    ASSERT_EQ(std::vector<int>({0}), suffix_array(std::vector<int>{0}));\n\
    \    ASSERT_EQ(std::vector<int>({0}), suffix_array(std::vector<int>{-1}));\n \
    \   ASSERT_EQ(std::vector<int>({0}), suffix_array(std::vector<int>{1}));\n   \
    \ ASSERT_EQ(std::vector<int>({0}),\n              suffix_array(std::vector<int>{std::numeric_limits<int>::min()}));\n\
    \    ASSERT_EQ(std::vector<int>({0}),\n              suffix_array(std::vector<int>{std::numeric_limits<int>::max()}));\n\
    }\n\nTEST(StringTest, LCP) {\n    std::string s = \"aab\";\n    auto sa = suffix_array(s);\n\
    \    ASSERT_EQ(std::vector<int>({0, 1, 2}), sa);\n    auto lcp = lcp_array(s,\
    \ sa);\n    ASSERT_EQ(std::vector<int>({1, 0}), lcp);\n\n    ASSERT_EQ(lcp, lcp_array(std::vector<int>({0,\
    \ 0, 1}), sa));\n    ASSERT_EQ(lcp, lcp_array(std::vector<int>({-100, -100, 100}),\
    \ sa));\n    ASSERT_EQ(lcp,\n              lcp_array(std::vector<int>({std::numeric_limits<int>::min(),\n\
    \                                          std::numeric_limits<int>::min(),\n\
    \                                          std::numeric_limits<int>::max()}),\n\
    \                        sa));\n\n    ASSERT_EQ(lcp, lcp_array(std::vector<long\
    \ long>(\n                                 {std::numeric_limits<long long>::min(),\n\
    \                                  std::numeric_limits<long long>::min(),\n  \
    \                                std::numeric_limits<long long>::max()}),\n  \
    \                           sa));\n    ASSERT_EQ(lcp, lcp_array(std::vector<unsigned\
    \ int>(\n                                 {std::numeric_limits<unsigned int>::min(),\n\
    \                                  std::numeric_limits<unsigned int>::min(),\n\
    \                                  std::numeric_limits<unsigned int>::max()}),\n\
    \                             sa));\n    ASSERT_EQ(lcp,\n              lcp_array(std::vector<unsigned\
    \ long long>(\n                            {std::numeric_limits<unsigned long\
    \ long>::min(),\n                             std::numeric_limits<unsigned long\
    \ long>::min(),\n                             std::numeric_limits<unsigned long\
    \ long>::max()}),\n                        sa));\n}\n\nTEST(StringTest, ZAlgo)\
    \ {\n    std::string s = \"abab\";\n    auto z = z_algorithm(s);\n    ASSERT_EQ(std::vector<int>({4,\
    \ 0, 2, 0}), z);\n    ASSERT_EQ(std::vector<int>({4, 0, 2, 0}),\n            \
    \  z_algorithm(std::vector<int>{1, 10, 1, 10}));\n    ASSERT_EQ(z_naive({0, 0,\
    \ 0, 0, 0, 0, 0}), z_algorithm({0, 0, 0, 0, 0, 0, 0}));\n}\n\nTEST(StringTest,\
    \ ZNaive) {\n    for (int n = 1; n <= 6; n++) {\n        int m = 1;\n        for\
    \ (int i = 0; i < n; i++) m *= 4;\n        for (int f = 0; f < m; f++) {\n   \
    \         std::vector<int> s(n);\n            int g = f;\n            for (int\
    \ i = 0; i < n; i++) {\n                s[i] = g % 4;\n                g /= 4;\n\
    \            }\n            ASSERT_EQ(z_naive(s), z_algorithm(s));\n        }\n\
    \    }\n    for (int n = 1; n <= 10; n++) {\n        int m = 1;\n        for (int\
    \ i = 0; i < n; i++) m *= 2;\n        for (int f = 0; f < m; f++) {\n        \
    \    std::vector<int> s(n);\n            int g = f;\n            for (int i =\
    \ 0; i < n; i++) {\n                s[i] = g % 2;\n                g /= 2;\n \
    \           }\n            ASSERT_EQ(z_naive(s), z_algorithm(s));\n        }\n\
    \    }\n}\n"
  dependsOn: []
  isVerificationFile: false
  path: test/unittest/string_test.cpp
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: test/unittest/string_test.cpp
layout: document
redirect_from:
- /library/test/unittest/string_test.cpp
- /library/test/unittest/string_test.cpp.html
title: test/unittest/string_test.cpp
---
