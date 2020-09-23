---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _pathExtension: cpp
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "#line 1 \"test/unittest/twosat_test.cpp\"\n#include <gtest/gtest.h>\n\
    \n#include <atcoder/twosat>\n#include <numeric>\n\n#line 1 \"test/utils/random.hpp\"\
    \n\n#include <random>\n\nstd::mt19937 global_mt19937;\n\n// random choise from\
    \ [a, b]\ntemplate <class T>\nT randint(T a, T b) {\n    return std::uniform_int_distribution<T>(a,\
    \ b)(global_mt19937);\n}\n\nbool randbool() {\n    return randint(0, 1) == 0;\n\
    }\n\n// random choice 2 disjoint elements from [lower, upper]\ntemplate <class\
    \ T> std::pair<T, T> randpair(T lower, T upper) {\n    assert(upper - lower >=\
    \ 1);\n    T a, b;\n    do {\n        a = randint(lower, upper);\n        b =\
    \ randint(lower, upper);\n    } while (a == b);\n    if (a > b) std::swap(a, b);\n\
    \    return {a, b};\n}\n#line 7 \"test/unittest/twosat_test.cpp\"\n\nusing namespace\
    \ atcoder;\nusing ll = long long;\nusing ull = unsigned long long;\n\nTEST(TwosatTest,\
    \ Empty) {\n    two_sat ts0;\n    ASSERT_TRUE(ts0.satisfiable());\n    ASSERT_EQ(std::vector<bool>({}),\
    \ ts0.answer());\n    two_sat ts1(0);\n    ASSERT_TRUE(ts1.satisfiable());\n \
    \   ASSERT_EQ(std::vector<bool>({}), ts1.answer());\n}\n\nTEST(TwosatTest, One)\
    \ {\n    {\n        two_sat ts(1);\n        ts.add_clause(0, true, 0, true);\n\
    \        ts.add_clause(0, false, 0, false);\n        ASSERT_FALSE(ts.satisfiable());\n\
    \    }\n    {\n        two_sat ts(1);\n        ts.add_clause(0, true, 0, true);\n\
    \        ASSERT_TRUE(ts.satisfiable());\n        ASSERT_EQ(std::vector<bool>{true},\
    \ ts.answer());\n    }\n    {\n        two_sat ts(1);\n        ts.add_clause(0,\
    \ false, 0, false);\n        ASSERT_TRUE(ts.satisfiable());\n        ASSERT_EQ(std::vector<bool>{false},\
    \ ts.answer());\n    }\n}\n\nTEST(TwosatTest, Assign) {\n    two_sat ts;\n   \
    \ ts = two_sat(10);\n}\n\nTEST(TwosatTest, StressOK) {\n    for (int phase = 0;\
    \ phase < 10000; phase++) {\n        int n = randint(1, 20);\n        int m =\
    \ randint(1, 100);\n        std::vector<bool> expect(n);\n        for (int i =\
    \ 0; i < n; i++) {\n            expect[i] = randbool();\n        }\n        two_sat\
    \ ts(n);\n        std::vector<int> xs(m), ys(m), types(m);\n        for (int i\
    \ = 0; i < m; i++) {\n            int x = randint(0, n - 1);\n            int\
    \ y = randint(0, n - 1);\n            int type = randint(0, 2);\n            xs[i]\
    \ = x;\n            ys[i] = y;\n            types[i] = type;\n            if (type\
    \ == 0) {\n                ts.add_clause(x, expect[x], y, expect[y]);\n      \
    \      } else if (type == 1) {\n                ts.add_clause(x, !expect[x], y,\
    \ expect[y]);\n            } else {\n                ts.add_clause(x, expect[x],\
    \ y, !expect[y]);\n            }\n        }\n        ASSERT_TRUE(ts.satisfiable());\n\
    \        auto actual = ts.answer();\n        for (int i = 0; i < m; i++) {\n \
    \           int x = xs[i], y = ys[i], type = types[i];\n            if (type ==\
    \ 0) {\n                ASSERT_TRUE(actual[x] == expect[x] || actual[y] == expect[y]);\n\
    \            } else if (type == 1) {\n                ASSERT_TRUE(actual[x] !=\
    \ expect[x] || actual[y] == expect[y]);\n            } else {\n              \
    \  ASSERT_TRUE(actual[x] == expect[x] || actual[y] != expect[y]);\n          \
    \  }\n        }\n    }\n}\n"
  code: "#include <gtest/gtest.h>\n\n#include <atcoder/twosat>\n#include <numeric>\n\
    \n#include \"../utils/random.hpp\"\n\nusing namespace atcoder;\nusing ll = long\
    \ long;\nusing ull = unsigned long long;\n\nTEST(TwosatTest, Empty) {\n    two_sat\
    \ ts0;\n    ASSERT_TRUE(ts0.satisfiable());\n    ASSERT_EQ(std::vector<bool>({}),\
    \ ts0.answer());\n    two_sat ts1(0);\n    ASSERT_TRUE(ts1.satisfiable());\n \
    \   ASSERT_EQ(std::vector<bool>({}), ts1.answer());\n}\n\nTEST(TwosatTest, One)\
    \ {\n    {\n        two_sat ts(1);\n        ts.add_clause(0, true, 0, true);\n\
    \        ts.add_clause(0, false, 0, false);\n        ASSERT_FALSE(ts.satisfiable());\n\
    \    }\n    {\n        two_sat ts(1);\n        ts.add_clause(0, true, 0, true);\n\
    \        ASSERT_TRUE(ts.satisfiable());\n        ASSERT_EQ(std::vector<bool>{true},\
    \ ts.answer());\n    }\n    {\n        two_sat ts(1);\n        ts.add_clause(0,\
    \ false, 0, false);\n        ASSERT_TRUE(ts.satisfiable());\n        ASSERT_EQ(std::vector<bool>{false},\
    \ ts.answer());\n    }\n}\n\nTEST(TwosatTest, Assign) {\n    two_sat ts;\n   \
    \ ts = two_sat(10);\n}\n\nTEST(TwosatTest, StressOK) {\n    for (int phase = 0;\
    \ phase < 10000; phase++) {\n        int n = randint(1, 20);\n        int m =\
    \ randint(1, 100);\n        std::vector<bool> expect(n);\n        for (int i =\
    \ 0; i < n; i++) {\n            expect[i] = randbool();\n        }\n        two_sat\
    \ ts(n);\n        std::vector<int> xs(m), ys(m), types(m);\n        for (int i\
    \ = 0; i < m; i++) {\n            int x = randint(0, n - 1);\n            int\
    \ y = randint(0, n - 1);\n            int type = randint(0, 2);\n            xs[i]\
    \ = x;\n            ys[i] = y;\n            types[i] = type;\n            if (type\
    \ == 0) {\n                ts.add_clause(x, expect[x], y, expect[y]);\n      \
    \      } else if (type == 1) {\n                ts.add_clause(x, !expect[x], y,\
    \ expect[y]);\n            } else {\n                ts.add_clause(x, expect[x],\
    \ y, !expect[y]);\n            }\n        }\n        ASSERT_TRUE(ts.satisfiable());\n\
    \        auto actual = ts.answer();\n        for (int i = 0; i < m; i++) {\n \
    \           int x = xs[i], y = ys[i], type = types[i];\n            if (type ==\
    \ 0) {\n                ASSERT_TRUE(actual[x] == expect[x] || actual[y] == expect[y]);\n\
    \            } else if (type == 1) {\n                ASSERT_TRUE(actual[x] !=\
    \ expect[x] || actual[y] == expect[y]);\n            } else {\n              \
    \  ASSERT_TRUE(actual[x] == expect[x] || actual[y] != expect[y]);\n          \
    \  }\n        }\n    }\n}\n"
  dependsOn: []
  isVerificationFile: false
  path: test/unittest/twosat_test.cpp
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: test/unittest/twosat_test.cpp
layout: document
redirect_from:
- /library/test/unittest/twosat_test.cpp
- /library/test/unittest/twosat_test.cpp.html
title: test/unittest/twosat_test.cpp
---
