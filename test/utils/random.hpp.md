---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _pathExtension: hpp
  _verificationStatusIcon: ':warning:'
  attributes:
    '*NOT_SPECIAL_COMMENTS*': ''
    links: []
  bundledCode: "#line 1 \"test/utils/random.hpp\"\n\n#include <random>\n\nstd::mt19937\
    \ global_mt19937;\n\n// random choise from [a, b]\ntemplate <class T>\nT randint(T\
    \ a, T b) {\n    return std::uniform_int_distribution<T>(a, b)(global_mt19937);\n\
    }\n\nbool randbool() {\n    return randint(0, 1) == 0;\n}\n\n// random choice\
    \ 2 disjoint elements from [lower, upper]\ntemplate <class T> std::pair<T, T>\
    \ randpair(T lower, T upper) {\n    assert(upper - lower >= 1);\n    T a, b;\n\
    \    do {\n        a = randint(lower, upper);\n        b = randint(lower, upper);\n\
    \    } while (a == b);\n    if (a > b) std::swap(a, b);\n    return {a, b};\n\
    }\n"
  code: "\n#include <random>\n\nstd::mt19937 global_mt19937;\n\n// random choise from\
    \ [a, b]\ntemplate <class T>\nT randint(T a, T b) {\n    return std::uniform_int_distribution<T>(a,\
    \ b)(global_mt19937);\n}\n\nbool randbool() {\n    return randint(0, 1) == 0;\n\
    }\n\n// random choice 2 disjoint elements from [lower, upper]\ntemplate <class\
    \ T> std::pair<T, T> randpair(T lower, T upper) {\n    assert(upper - lower >=\
    \ 1);\n    T a, b;\n    do {\n        a = randint(lower, upper);\n        b =\
    \ randint(lower, upper);\n    } while (a == b);\n    if (a > b) std::swap(a, b);\n\
    \    return {a, b};\n}\n"
  dependsOn: []
  isVerificationFile: false
  path: test/utils/random.hpp
  requiredBy: []
  timestamp: '2020-09-22 23:58:45+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: test/utils/random.hpp
layout: document
redirect_from:
- /library/test/utils/random.hpp
- /library/test/utils/random.hpp.html
title: test/utils/random.hpp
---
