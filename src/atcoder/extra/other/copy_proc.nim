when not declared ATCODER_EXTRA_COPY_PROC_HPP:
  const ATCODER_EXTRA_COPY_PROC_HPP* = 1
  template copyProc0*[T](f0:proc():T):proc =
    proc f1():T {.gensym inline.} = f0()
    f1
  template copyProc1*[A,T](f0:proc(a:A):T):proc =
    proc f1(a:A):T {.gensym inline.} = f0(a)
    f1
  template copyProc2*[A,B,T](f0:proc(a:A,b:B):T):proc =
    proc f1(a:A,b:B):T {.gensym inline.} = f0(a,b)
    f1
  template copyProc3*[A,B,C,T](f0:proc(a:A,b:B,c:C):T):proc =
    proc f1(a:A,b:B,c:C):T {.gensym inline.} = f0(a,b,c)
    f1
