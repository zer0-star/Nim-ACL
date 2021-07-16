---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: cpp
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "#line 1 \"test/expander/include_dsu.cpp\"\n#include <atcoder/dsu>\n\
    #include <cstdio>\n\nusing namespace std;\nusing namespace atcoder;\n\nint main()\
    \ {\n    int n, q;\n    scanf(\"%d %d\", &n, &q);\n\n    dsu uf(n);\n    for (int\
    \ i = 0; i < q; i++) {\n        int t, u, v;\n        scanf(\"%d %d %d\", &t,\
    \ &u, &v);\n        if (t == 0) {\n            // merge\n            uf.merge(u,\
    \ v);\n        } else {\n            // find\n            if (uf.same(u, v)) {\n\
    \                printf(\"1\\n\");\n            } else {\n                printf(\"\
    0\\n\");\n            }\n        }\n    }\n}\n"
  code: "#include <atcoder/dsu>\n#include <cstdio>\n\nusing namespace std;\nusing\
    \ namespace atcoder;\n\nint main() {\n    int n, q;\n    scanf(\"%d %d\", &n,\
    \ &q);\n\n    dsu uf(n);\n    for (int i = 0; i < q; i++) {\n        int t, u,\
    \ v;\n        scanf(\"%d %d %d\", &t, &u, &v);\n        if (t == 0) {\n      \
    \      // merge\n            uf.merge(u, v);\n        } else {\n            //\
    \ find\n            if (uf.same(u, v)) {\n                printf(\"1\\n\");\n\
    \            } else {\n                printf(\"0\\n\");\n            }\n    \
    \    }\n    }\n}\n"
  dependsOn: []
  isVerificationFile: false
  path: test/expander/include_dsu.cpp
  requiredBy: []
  timestamp: '2020-09-22 23:58:45+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: test/expander/include_dsu.cpp
layout: document
redirect_from:
- /library/test/expander/include_dsu.cpp
- /library/test/expander/include_dsu.cpp.html
title: test/expander/include_dsu.cpp
---
