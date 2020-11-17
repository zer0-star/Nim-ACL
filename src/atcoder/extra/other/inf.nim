when not declared ATCODER_INF_HPP:
  const ATCODER_INF_HPP* = 1
  template inf*(T): untyped = 
    when T is SomeFloat: T(Inf)
    elif T is SomeInteger: ((T(1) shl T(sizeof(T)*8-2)) - (T(1) shl T(sizeof(T)*4-1)))
    else:
      static: assert(false)
