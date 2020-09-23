---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _pathExtension: hpp
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "#line 1 \"test/utils/math.hpp\"\n#include <atcoder/internal_math>\n\
    #include <atcoder/math>\n#include <vector>\n\nstd::vector<int> factors(int m)\
    \ {\n    std::vector<int> result;\n    for (int i = 2; (long long)(i)*i <= m;\
    \ i++) {\n        if (m % i == 0) {\n            result.push_back(i);\n      \
    \      while (m % i == 0) {\n                m /= i;\n            }\n        }\n\
    \    }\n    if (m > 1) result.push_back(m);\n    return result;\n}\n\nbool is_primitive_root(int\
    \ m, int g) {\n    assert(1 <= g && g < m);\n    auto prs = factors(m - 1);\n\
    \    for (int x : factors(m - 1)) {\n        if (atcoder::internal::pow_mod_constexpr(g,\
    \ (m - 1) / x, m) == 1) return false;\n    }\n    return true;\n}\n"
  code: "#include <atcoder/internal_math>\n#include <atcoder/math>\n#include <vector>\n\
    \nstd::vector<int> factors(int m) {\n    std::vector<int> result;\n    for (int\
    \ i = 2; (long long)(i)*i <= m; i++) {\n        if (m % i == 0) {\n          \
    \  result.push_back(i);\n            while (m % i == 0) {\n                m /=\
    \ i;\n            }\n        }\n    }\n    if (m > 1) result.push_back(m);\n \
    \   return result;\n}\n\nbool is_primitive_root(int m, int g) {\n    assert(1\
    \ <= g && g < m);\n    auto prs = factors(m - 1);\n    for (int x : factors(m\
    \ - 1)) {\n        if (atcoder::internal::pow_mod_constexpr(g, (m - 1) / x, m)\
    \ == 1) return false;\n    }\n    return true;\n}\n"
  dependsOn: []
  isVerificationFile: false
  path: test/utils/math.hpp
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: test/utils/math.hpp
layout: document
redirect_from:
- /library/test/utils/math.hpp
- /library/test/utils/math.hpp.html
title: test/utils/math.hpp
---
