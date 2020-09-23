---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _pathExtension: cpp
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "#line 1 \"test/expander/include_all.cpp\"\n#include <atcoder/all>\n\
    #include <cstdio>\n\nusing namespace std;\nusing namespace atcoder;\n\nint main()\
    \ {\n    int n, q;\n    scanf(\"%d %d\", &n, &q);\n\n    dsu uf(n);\n    for (int\
    \ i = 0; i < q; i++) {\n        int t, u, v;\n        scanf(\"%d %d %d\", &t,\
    \ &u, &v);\n        if (t == 0) {\n            // merge\n            uf.merge(u,\
    \ v);\n        } else {\n            // find\n            if (uf.same(u, v)) {\n\
    \                printf(\"1\\n\");\n            } else {\n                printf(\"\
    0\\n\");\n            }\n        }\n    }\n}\n"
  code: "#include <atcoder/all>\n#include <cstdio>\n\nusing namespace std;\nusing\
    \ namespace atcoder;\n\nint main() {\n    int n, q;\n    scanf(\"%d %d\", &n,\
    \ &q);\n\n    dsu uf(n);\n    for (int i = 0; i < q; i++) {\n        int t, u,\
    \ v;\n        scanf(\"%d %d %d\", &t, &u, &v);\n        if (t == 0) {\n      \
    \      // merge\n            uf.merge(u, v);\n        } else {\n            //\
    \ find\n            if (uf.same(u, v)) {\n                printf(\"1\\n\");\n\
    \            } else {\n                printf(\"0\\n\");\n            }\n    \
    \    }\n    }\n}\n"
  dependsOn: []
  isVerificationFile: false
  path: test/expander/include_all.cpp
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: test/expander/include_all.cpp
layout: document
redirect_from:
- /library/test/expander/include_all.cpp
- /library/test/expander/include_all.cpp.html
title: test/expander/include_all.cpp
---
