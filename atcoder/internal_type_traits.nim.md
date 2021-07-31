---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: atcoder/extra/structure/dual_fenwicktree.nim
    title: atcoder/extra/structure/dual_fenwicktree.nim
  - icon: ':warning:'
    path: atcoder/extra/structure/dual_fenwicktree.nim
    title: atcoder/extra/structure/dual_fenwicktree.nim
  - icon: ':x:'
    path: atcoder/fenwicktree.nim
    title: atcoder/fenwicktree.nim
  - icon: ':x:'
    path: atcoder/fenwicktree.nim
    title: atcoder/fenwicktree.nim
  - icon: ':warning:'
    path: test/example/fenwick_practice.nim
    title: test/example/fenwick_practice.nim
  - icon: ':warning:'
    path: test/example/fenwick_practice.nim
    title: test/example/fenwick_practice.nim
  - icon: ':warning:'
    path: tests/test_fenwicktree.nim
    title: tests/test_fenwicktree.nim
  - icon: ':warning:'
    path: tests/test_fenwicktree.nim
    title: tests/test_fenwicktree.nim
  _extendedVerifiedWith:
  - icon: ':x:'
    path: verify/fenwick_tree_test.nim
    title: verify/fenwick_tree_test.nim
  - icon: ':x:'
    path: verify/fenwick_tree_test.nim
    title: verify/fenwick_tree_test.nim
  _isVerificationFailed: true
  _pathExtension: nim
  _verificationStatusIcon: ':x:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_INTERNAL_TYPE_TRAITS_HPP:\n  const ATCODER_INTERNAL_TYPE_TRAITS_HPP*\
    \ = 1\n\n  ##ifndef _MSC_VER\n  #template <class T>\n  #using is_signed_int128\
    \ =\n  #    typename std::conditional<std::is_same<T, __int128_t>::value ||\n\
    \  #                                  std::is_same<T, __int128>::value,\n  # \
    \                             std::true_type,\n  #                           \
    \   std::false_type>::type;\n  #\n  #template <class T>\n  #using is_unsigned_int128\
    \ =\n  #    typename std::conditional<std::is_same<T, __uint128_t>::value ||\n\
    \  #                                  std::is_same<T, unsigned __int128>::value,\n\
    \  #                              std::true_type,\n  #                       \
    \       std::false_type>::type;\n  #\n  #template <class T>\n  #using make_unsigned_int128\
    \ =\n  #    typename std::conditional<std::is_same<T, __int128_t>::value,\n  #\
    \                              __uint128_t,\n  #                             \
    \ unsigned __int128>;\n  #\n  #template <class T>\n  #using is_integral = typename\
    \ std::conditional<std::is_integral<T>::value ||\n  #                        \
    \                          is_signed_int128<T>::value ||\n  #                \
    \                                  is_unsigned_int128<T>::value,\n  #        \
    \                                      std::true_type,\n  #                  \
    \                            std::false_type>::type;\n  #\n  #template <class\
    \ T>\n  #using is_signed_int = typename std::conditional<(is_integral<T>::value\
    \ &&\n  #                                                 std::is_signed<T>::value)\
    \ ||\n  #                                                    is_signed_int128<T>::value,\n\
    \  #                                                std::true_type,\n  #     \
    \                                           std::false_type>::type;\n  #\n  #template\
    \ <class T>\n  #using is_unsigned_int =\n  #    typename std::conditional<(is_integral<T>::value\
    \ &&\n  #                               std::is_unsigned<T>::value) ||\n  #  \
    \                                is_unsigned_int128<T>::value,\n  #          \
    \                    std::true_type,\n  #                              std::false_type>::type;\n\
    \  #\n  #template <class T>\n  #using to_unsigned = typename std::conditional<\n\
    \  #    is_signed_int128<T>::value,\n  #    make_unsigned_int128<T>,\n  #    typename\
    \ std::conditional<std::is_signed<T>::value,\n  #                            \
    \  std::make_unsigned<T>,\n  #                              std::common_type<T>>::type>::type;\n\
    \  #\n  ##else\n  \n  #  template <class T> using is_integral = typename std::is_integral<T>;\n\
    \    \n  #  template <class T>\n  #  using is_signed_int =\n  #      typename\
    \ std::conditional<is_integral<T>::value && std::is_signed<T>::value,\n  #   \
    \                             std::true_type,\n  #                           \
    \     std::false_type>::type;\n  #  \n  #  template <class T>\n  #  using is_unsigned_int\
    \ =\n  #      typename std::conditional<is_integral<T>::value &&\n  #        \
    \                            std::is_unsigned<T>::value,\n  #                \
    \                std::true_type,\n  #                                std::false_type>::type;\n\
    \  #  \n  #  template <class T>\n  #  using to_unsigned = typename std::conditional<is_signed_int<T>::value,\n\
    \  #                                                std::make_unsigned<T>,\n \
    \ #                                                std::common_type<T>>::type;\n\
    \  \n  template to_unsigned*(T:typedesc):typedesc =\n    when T is int: uint\n\
    \    elif T is int8: uint8\n    elif T is int16: uint16\n    elif T is int32:\
    \ uint32\n    elif T is int64: uint64\n    else: T\n    \n#endif\n\n#template\
    \ <class T>\n#using is_signed_int_t = std::enable_if_t<is_signed_int<T>::value>;\n\
    #\n#template <class T>\n#using is_unsigned_int_t = std::enable_if_t<is_unsigned_int<T>::value>;\n\
    #\n#template <class T> using to_unsigned_t = typename to_unsigned<T>::type;\n\n\
    \  template to_unsigned_t*(T):typed = to_unsigned(T)\n\n#\n#}  // namespace internal\n\
    #\n#}  // namespace atcoder\n\n#endif  // ATCODER_INTERNAL_TYPE_TRAITS_HPP\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/internal_type_traits.nim
  requiredBy:
  - atcoder/extra/structure/dual_fenwicktree.nim
  - atcoder/extra/structure/dual_fenwicktree.nim
  - atcoder/fenwicktree.nim
  - atcoder/fenwicktree.nim
  - tests/test_fenwicktree.nim
  - tests/test_fenwicktree.nim
  - test/example/fenwick_practice.nim
  - test/example/fenwick_practice.nim
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_ALL_WA
  verifiedWith:
  - verify/fenwick_tree_test.nim
  - verify/fenwick_tree_test.nim
documentation_of: atcoder/internal_type_traits.nim
layout: document
redirect_from:
- /library/atcoder/internal_type_traits.nim
- /library/atcoder/internal_type_traits.nim.html
title: atcoder/internal_type_traits.nim
---
