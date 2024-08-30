when not declared ATCODER_BIGNUMBER_HPP:
  const ATCODER_BIGNUMBER_HPP* = 1
  
  ## Arbitrary precision integers and floating point numbers for Nim.
  
  import strutils, algorithm, sequtils, math
  
  type
      BigInt* = ref object of RootObj
          sign*: bool  # true for 0 or positive values, false for negative values.
          limbs*: seq[int64]
          
      BigFloat* = ref object of RootObj
          intPart*: BigInt
          exp*: int
          
      BigFloatContext = ref object of RootObj
          prec: int
   
  const 
      BASE: int64 = 10000000000000000
      BASE2: int64 = 100000000
      LOG_BASE: int = 16
      KARATSUBA_THRESHOLD: int = 90  # The optimal value drastically changes with CPUs (from 30 to 200). 
      TOOM3_THRESHOLD: int = 550  # The optimal value <= 700. 
      TOOM4_THRESHOLD: int = 850 # The optimal value <= 1500. 
      TOOM6H_THRESHOLD: int = 1000  # The optimal value <= 2000. 
      validCharsForBigInt: string = "01234567890"
      validCharsForBigFloat: string = ".0123456789"
      
  let    
      zero*: BigInt = BigInt(sign: true, limbs: @[0'i64])
  
  var
      bfContext: BigFloatContext = new BigFloatContext
  
  proc compatibleDelete[T: seq|string](x: var T, a, b: int) = 
      when NimMajor < 1:
          x.delete(a, b)
      else:
          when NimMinor < 6:
              x.delete(a, b)
          else:
              x.delete(a..b) 
  
  proc newBigIntNoCheck(s: string): BigInt =
      var
          s2: string
          inputLength: int
          limbsLength: int
          remainderLength: int
      result = new BigInt
      s2 = s[0..^1]   
      if $s2[0] == "-":
          result.sign = false
          s2.compatibleDelete(0,0)
      elif $s2[0] == "+":
          result.sign = true
          s2.compatibleDelete(0,0)  
      else:
          result.sign = true
      result.limbs = @[]
      inputLength = len(s2)
      limbsLength = inputLength div LOG_BASE
      remainderLength = inputLength mod LOG_BASE
      if remainderLength != 0:
          result.limbs.add(parseBiggestInt(s2[0..remainderLength - 1]))
          s2.compatibleDelete(0,remainderLength - 1)
      for i in 0..(limbsLength - 1):
          result.limbs.add(parseBiggestInt(s2[LOG_BASE*i..(LOG_BASE*i + LOG_BASE-1)]))
      result.limbs.reverse
      # The sign of zero is always positive.
      if result.limbs == @[0'i64]:
          result.sign = true
  
  proc newBigInt*(s: string, checkInput: bool = true): BigInt =
      ## Constructs a new BigInt object from a string.
      if checkInput:
          var s3: string = s[0..^1]
          if ($s3[0] == "+") or ($s3[0] == "-"):
              s3.compatibleDelete(0,0)
          for i in (0..<len(s3)):
              if $s3[i] == "+":
                  raise newException(ValueError, "Invalid character(s) in input string: '" & $s3[i]  & "'.")
              elif $s3[i] == "-":
                  raise newException(ValueError, "Invalid character(s) in input string: '" & $s3[i]  & "'.")
              elif not ($s3[i] in validCharsForBigInt):
                  raise newException(ValueError, "Invalid character(s) in input string: '" & $s3[i]  & "'.")
      result = newBigIntNoCheck(s)
  
  proc newBigInt*(a: int64): BigInt =
      ## Constructs a new BigInt object from int64.
      var
          n: int64
      result = new BigInt
      if a < 0:
          result.sign = false
          result.limbs.add(a.abs())
          n = a.abs()
      else:
          result.sign = true
          result.limbs.add(a)
          n = a
      if n >= BASE:
          result.limbs[0] = n mod BASE
          result.limbs.add(n div BASE)
      
  proc newBigInt*[T: int8|uint8|int16|uint16|int32|uint32|int](a: T): BigInt =
      ## Constructs a new BigInt object from int8|uint8|int16|uint16|int32|uint32|int.
      result = newBigInt(int64(a))
  
  proc newBigInt*(a: uint64): BigInt =
      ## Constructs a new BigInt object from uint64.
      result = newBigIntNoCheck($a)
  
  proc toStr(x: BigInt): string = 
      var
          x2: seq[int64]
          s: string
          t: string
          t2: string
          n: int
      x2 = x.limbs[0..^1]
      x2.reverse
      s = $(x2[0])
      for i in 1..(len(x2) - 1):
          t = $(x2[i])
          n = len(t)
          t2 = "0".repeat(LOG_BASE - n)
          t2.add(t)
          s.add(t2)
      if not x.sign:
          result = "-"
          result.add(s)
      else:
          result = s
  
  proc `$` *(x: BigInt): string =
      ## Converts a BigInt object to a string.
      result = x.toStr()
  
  proc clone(x: BigInt): BigInt =
      result = new BigInt
      result.sign = x.sign
      result.limbs = x.limbs[0..^1]
  
  proc ucmp(x, y: BigInt): int =
      let
          m: int = len(x.limbs)
          n: int = len(y.limbs)
      var
          a: int = 0
      if m > n:
          return 1
      elif m < n:
          return -1
      else:
          for i in countdown((m - 1),0):
              if x.limbs[i] > y.limbs[i]:
                  a = 1
                  break
              elif x.limbs[i] < y.limbs[i]:
                  a = -1
                  break
          return a
  
  proc cmp(x, y: BigInt): int =
      if x.sign and (not y.sign):
          return 1
      elif (not x.sign) and y.sign:
          return -1
      elif x.sign and y.sign:
          return x.ucmp(y)
      else:
          return -(x.ucmp(y))
  
  proc `>` *(x, y: BigInt): bool =
      return x.cmp(y) > 0
  
  proc `>=` *(x, y: BigInt): bool =
      return x.cmp(y) >= 0
  
  proc `==` *(x, y: BigInt): bool =
      return x.cmp(y) == 0
  
  proc `<=` *(x, y: BigInt): bool =
      return x.cmp(y) <= 0
  
  proc `<` *(x, y: BigInt): bool =
      return x.cmp(y) < 0
  
  proc `!=` *(x, y: BigInt): bool =
      return x.cmp(y) != 0
  
  proc `-` *(x: BigInt): BigInt =
      ## Negates x.
      if x == zero:
          result = zero.clone()
      else:
          result = x.clone()
          result.sign = not x.sign
              
  proc abs*(x: BigInt): BigInt =
      ## Absolute value of x.
      result = x.clone()
      result.sign = true
      
  
  proc max*(x, y: BigInt): BigInt =
      if x >= y:
          result = x.clone()
      else:
          result = y.clone()
  
  proc min*(x, y: BigInt): BigInt =
      if x <= y:
          result = x.clone()
      else:
          result = y.clone()
  
  proc removeLeadingZeros(x: var BigInt) =
      var count = 0
      let m = len(x.limbs)
      for i in countdown(m-1, 1):
          if x.limbs[i] == 0:
              count += 1
          else:
              break
      if count > 0:
          x.limbs.setLen(m - count)
  
  # Unsigned addition. Only works when x >= y >= 0.
  proc uadd(x, y: BigInt): BigInt =
      var 
          m: int = len(x.limbs)
          n: int = len(y.limbs)
          carry: int64 = 0'i64
          t: int64
      result = new BigInt
      result.limbs = newSeqUninitialized[int64](m + 1)
      result.limbs[m] = 0
      result.sign = true
      for i in 0..(n - 1):
          t = x.limbs[i] + y.limbs[i] + carry
          if t >= BASE:
              t -= BASE 
              carry = 1 
          else:
              carry = 0
          result.limbs[i] = t
      for i in n..(m - 1):
          t = x.limbs[i] + carry
          if t >= BASE:
              t -= BASE 
              carry = 1
          else:
              carry = 0
          result.limbs[i] = t
      if carry == 1:
          result.limbs[m] = 1
      result.removeLeadingZeros()
  
  # Unsigned subtraction. Only works when x >= y >= 0.
  proc usub(x, y: BigInt): BigInt =
      var 
          m: int = len(x.limbs)
          n: int = len(y.limbs)
          carry: int64 = 0'i64
          t: int64
      result = new BigInt    
      result.sign = true
      result.limbs = newSeqUninitialized[int64](m)
      for i in 0..(n - 1):
          t = x.limbs[i] - y.limbs[i] + carry
          if t < 0'i64:
              t += BASE
              carry = -1    
          else:
              carry = 0
          result.limbs[i] = t
      for i in n..(m - 1):
          t = x.limbs[i] + carry
          if t < 0'i64:
              t += BASE
              carry = -1    
          else:
              carry = 0
          result.limbs[i] = t
      result.removeLeadingZeros()
  
  proc `+` *(x, y: BigInt): BigInt =
      ## Returns the sum of two BigInts.
      if x.ucmp(y) < 0:
          result = y + x
      else:
          if (x >= zero) and (y >= zero):
              result = x.uadd(y)
          elif (x < zero) and (y < zero):
              result = x.uadd(y)
              result.sign = false
          elif (x >= zero) and (y < zero):
              result = x.usub(y)
          else:
              result = x.usub(y)
              result.sign = false
              # The sign of zero is always positive.
              if result.limbs == @[0'i64]:
                  result.sign = true
  
  proc `+` *(x: BigInt, y: SomeInteger): BigInt =
      ## Returns the sum of a BigInt and an integer.
      result = x + newBigInt(y)
  
  proc `+` *(x: SomeInteger, y: BigInt): BigInt =
      ## Returns the sum of an integer and a BigInt.
      result = newBigInt(x) + y
  
  proc `-` *(x, y: BigInt): BigInt =
      ## Returns the difference of two BigInts.
      if x.ucmp(y) >= 0:
          if (x >= zero) and (y >= zero):
              result = x.usub(y)
          elif (x < zero) and (y < zero):
              result = x.usub(y)
              result.sign = false
          elif (x >= zero) and (y < zero):
              result = x.uadd(y)
          else:
              result = x.uadd(y)
              result.sign = false
              # The sign of zero is always positive.
              if result.limbs == @[0'i64]:
                  result.sign = true
      else:
          if (y < zero) and (x < zero):
              result = y.usub(x)
          elif (y >= zero) and (x >= zero):
              result = y.usub(x)
              result.sign = false
          elif (y < zero) and (x >= zero):
              result = y.uadd(x)
          else:
              result = y.uadd(x)
              result.sign = false
              # The sign of zero is always positive.
              if result.limbs == @[0'i64]:
                  result.sign = true
  
  proc `-` *(x: BigInt, y: SomeInteger): BigInt =
      ## Returns the difference of a BigInt and an integer.
      result = x - newBigInt(y)
  
  proc `-` *(x: SomeInteger, y: BigInt): BigInt =
      ## Returns the difference of an integer and a BigInt.
      result = newBigInt(x) - y
  
  # Schoolbook multiplication. Time complexity is O(n^2).
  proc schoolbookMul(x, y: BigInt): BigInt =
      var
          m: int = len(x.limbs)
          n: int = len(y.limbs)
          t: int64
          t2: int64
          xi: int64
          xLimbsSplitted: seq[int64] = newSeqUninitialized[int64](2 * m)
          yLimbsSplitted: seq[int64] = newSeqUninitialized[int64](2 * n)
          resultLimbsSplitted: seq[int64]
      if (x == zero) or (y == zero):
          result = new BigInt
          result.sign = true
          result.limbs = @[0'i64]
      else:
          for i in 0..(m-1):
              t = x.limbs[i] div BASE2
              xLimbsSplitted[2*i] = x.limbs[i] - t*BASE2
              xLimbsSplitted[2*i + 1] = t
          for i in 0..(n-1):
              t = y.limbs[i] div BASE2
              yLimbsSplitted[2*i] = y.limbs[i] - t*BASE2
              yLimbsSplitted[2*i + 1] = t
          resultLimbsSplitted = newSeq[int64](2*m + 2*n + 2)
          for i in 0..(2*m - 1):
              xi = xLimbsSplitted[i]
              for k in 0..(2*n - 1):
                  resultLimbsSplitted[i+k] += xi * yLimbsSplitted[k]
          result = new BigInt
          result.sign = (x.sign == y.sign)
          for i in 0..(2*m + 2*n + 1):
              t = resultLimbsSplitted[i]
              if t >= BASE2:
                  t2 = t div BASE2
                  resultLimbsSplitted[i] -= t2 * BASE2
                  resultLimbsSplitted[i+1] += t2
          result.limbs = newSeq[int64](len(resultLimbsSplitted) div 2)
          for i in 0..((len(resultLimbsSplitted) div 2) - 1):
              result.limbs[i] = resultLimbsSplitted[2 * i] + (resultLimbsSplitted[2 * i + 1] * BASE2)
          result.removeLeadingZeros()
  
  # Schoolbook multiplication with static array.
  proc schoolbookMulStatic1(x, y: BigInt): BigInt =
      var
          m: int = len(x.limbs)
          n: int = len(y.limbs)
          t: int64
          t2: int64
          xi: int64
          xLimbsSplitted: array[(KARATSUBA_THRESHOLD*5 div 8)*2, int64]
          yLimbsSplitted: array[(KARATSUBA_THRESHOLD*5 div 8)*2, int64]
          resultLimbsSplitted: array[(KARATSUBA_THRESHOLD*5 div 8)*4 + 2, int64]
      if (x == zero) or (y == zero):
          result = new BigInt
          result.sign = true
          result.limbs = @[0'i64]
      else:
          for i in 0..(m-1):
              t = x.limbs[i] div BASE2
              xLimbsSplitted[2*i] = x.limbs[i] - t*BASE2
              xLimbsSplitted[2*i + 1] = t
          for i in 0..(n-1):
              t = y.limbs[i] div BASE2
              yLimbsSplitted[2*i] = y.limbs[i] - t*BASE2
              yLimbsSplitted[2*i + 1] = t
          for i in 0..(2*m - 1):
              xi = xLimbsSplitted[i]
              for k in 0..(2*n - 1):
                  resultLimbsSplitted[i+k] += xi * yLimbsSplitted[k]
          result = new BigInt
          result.sign = (x.sign == y.sign)
          for i in 0..(2*m + 2*n + 1):
              t = resultLimbsSplitted[i]
              if t >= BASE2:
                  t2 = t div BASE2
                  resultLimbsSplitted[i] -= t2 * BASE2
                  resultLimbsSplitted[i+1] += t2
          result.limbs = newSeq[int64](len(resultLimbsSplitted) div 2)
          for i in 0..((len(resultLimbsSplitted) div 2) - 1):
              result.limbs[i] = resultLimbsSplitted[2 * i] + (resultLimbsSplitted[2 * i + 1] * BASE2)
          result.removeLeadingZeros()
  
  proc schoolbookMulStatic2(x, y: BigInt): BigInt =
      var
          m: int = len(x.limbs)
          n: int = len(y.limbs)
          t: int64
          t2: int64
          xi: int64
          xLimbsSplitted: array[(KARATSUBA_THRESHOLD*3 div 4)*2, int64]
          yLimbsSplitted: array[(KARATSUBA_THRESHOLD*3 div 4)*2, int64]
          resultLimbsSplitted: array[(KARATSUBA_THRESHOLD*3 div 4)*4 + 2, int64]
      if (x == zero) or (y == zero):
          result = new BigInt
          result.sign = true
          result.limbs = @[0'i64]
      else:
          for i in 0..(m-1):
              t = x.limbs[i] div BASE2
              xLimbsSplitted[2*i] = x.limbs[i] - t*BASE2
              xLimbsSplitted[2*i + 1] = t
          for i in 0..(n-1):
              t = y.limbs[i] div BASE2
              yLimbsSplitted[2*i] = y.limbs[i] - t*BASE2
              yLimbsSplitted[2*i + 1] = t
          for i in 0..(2*m - 1):
              xi = xLimbsSplitted[i]
              for k in 0..(2*n - 1):
                  resultLimbsSplitted[i+k] += xi * yLimbsSplitted[k]
          result = new BigInt
          result.sign = (x.sign == y.sign)
          for i in 0..(2*m + 2*n + 1):
              t = resultLimbsSplitted[i]
              if t >= BASE2:
                  t2 = t div BASE2
                  resultLimbsSplitted[i] -= t2 * BASE2
                  resultLimbsSplitted[i+1] += t2
          result.limbs = newSeq[int64](len(resultLimbsSplitted) div 2)
          for i in 0..((len(resultLimbsSplitted) div 2) - 1):
              result.limbs[i] = resultLimbsSplitted[2 * i] + (resultLimbsSplitted[2 * i + 1] * BASE2)
          result.removeLeadingZeros()
  
  proc schoolbookMulStatic3(x, y: BigInt): BigInt =
      var
          m: int = len(x.limbs)
          n: int = len(y.limbs)
          t: int64
          t2: int64
          xi: int64
          xLimbsSplitted: array[(KARATSUBA_THRESHOLD*7 div 8)*2, int64]
          yLimbsSplitted: array[(KARATSUBA_THRESHOLD*7 div 8)*2, int64]
          resultLimbsSplitted: array[(KARATSUBA_THRESHOLD*7 div 8)*4 + 2, int64]
      if (x == zero) or (y == zero):
          result = new BigInt
          result.sign = true
          result.limbs = @[0'i64]
      else:
          for i in 0..(m-1):
              t = x.limbs[i] div BASE2
              xLimbsSplitted[2*i] = x.limbs[i] - t*BASE2
              xLimbsSplitted[2*i + 1] = t
          for i in 0..(n-1):
              t = y.limbs[i] div BASE2
              yLimbsSplitted[2*i] = y.limbs[i] - t*BASE2
              yLimbsSplitted[2*i + 1] = t
          for i in 0..(2*m - 1):
              xi = xLimbsSplitted[i]
              for k in 0..(2*n - 1):
                  resultLimbsSplitted[i+k] += xi * yLimbsSplitted[k]
          result = new BigInt
          result.sign = (x.sign == y.sign)
          for i in 0..(2*m + 2*n + 1):
              t = resultLimbsSplitted[i]
              if t >= BASE2:
                  t2 = t div BASE2
                  resultLimbsSplitted[i] -= t2 * BASE2
                  resultLimbsSplitted[i+1] += t2
          result.limbs = newSeq[int64](len(resultLimbsSplitted) div 2)
          for i in 0..((len(resultLimbsSplitted) div 2) - 1):
              result.limbs[i] = resultLimbsSplitted[2 * i] + (resultLimbsSplitted[2 * i + 1] * BASE2)
          result.removeLeadingZeros()
  
  proc schoolbookMulStatic4(x, y: BigInt): BigInt =
      var
          m: int = len(x.limbs)
          n: int = len(y.limbs)
          t: int64
          t2: int64
          xi: int64
          xLimbsSplitted: array[KARATSUBA_THRESHOLD*2, int64]
          yLimbsSplitted: array[KARATSUBA_THRESHOLD*2, int64]
          resultLimbsSplitted: array[KARATSUBA_THRESHOLD*4 + 2, int64]
      if (x == zero) or (y == zero):
          result = new BigInt
          result.sign = true
          result.limbs = @[0'i64]
      else:
          for i in 0..(m-1):
              t = x.limbs[i] div BASE2
              xLimbsSplitted[2*i] = x.limbs[i] - t*BASE2
              xLimbsSplitted[2*i + 1] = t
          for i in 0..(n-1):
              t = y.limbs[i] div BASE2
              yLimbsSplitted[2*i] = y.limbs[i] - t*BASE2
              yLimbsSplitted[2*i + 1] = t
          for i in 0..(2*m - 1):
              xi = xLimbsSplitted[i]
              for k in 0..(2*n - 1):
                  resultLimbsSplitted[i+k] += xi * yLimbsSplitted[k]
          result = new BigInt
          result.sign = (x.sign == y.sign)
          for i in 0..(2*m + 2*n + 1):
              t = resultLimbsSplitted[i]
              if t >= BASE2:
                  t2 = t div BASE2
                  resultLimbsSplitted[i] -= t2 * BASE2
                  resultLimbsSplitted[i+1] += t2
          result.limbs = newSeq[int64](len(resultLimbsSplitted) div 2)
          for i in 0..((len(resultLimbsSplitted) div 2) - 1):
              result.limbs[i] = resultLimbsSplitted[2 * i] + (resultLimbsSplitted[2 * i + 1] * BASE2)
          result.removeLeadingZeros()
  
  # Squaring is implemented separately from multiplication for better performance.
  proc schoolbookSqr(x: BigInt): BigInt =
      var
          m: int = len(x.limbs)
          t: int64
          t2: int64
          xi: int64
          xLimbsSplitted: seq[int64] = newSeqUninitialized[int64](2 * m)
          resultLimbsSplitted: seq[int64]
      if x == zero:
          result = new BigInt
          result.sign = true
          result.limbs = @[0'i64]
      else:
          for i in 0..(m-1):
              t = x.limbs[i] div BASE2
              xLimbsSplitted[2*i] = x.limbs[i] - t*BASE2
              xLimbsSplitted[2*i + 1] = t
          resultLimbsSplitted = newSeq[int64](4*m + 2)
          for i in 0..(2*m - 1):
              xi = xLimbsSplitted[i]
              for k in (i + 1)..(2*m - 1):
                  resultLimbsSplitted[i+k] += xi * xLimbsSplitted[k] * 2
          for i in 0..(2*m - 1):
              resultLimbsSplitted[2*i] += xLimbsSplitted[i]^2
          result = new BigInt
          result.sign = true
          for i in 0..(4*m + 1):
              t = resultLimbsSplitted[i]
              if t >= BASE2:
                  t2 = t div BASE2
                  resultLimbsSplitted[i] -= t2 * BASE2
                  resultLimbsSplitted[i+1] += t2
          result.limbs = newSeq[int64](len(resultLimbsSplitted) div 2)
          for i in 0..((len(resultLimbsSplitted) div 2) - 1):
              result.limbs[i] = resultLimbsSplitted[2*i] + (resultLimbsSplitted[2*i + 1] * BASE2)
          result.removeLeadingZeros()
  
  proc schoolbookSqrStatic1(x: BigInt): BigInt =
      var
          m: int = len(x.limbs)
          t: int64
          t2: int64
          xi: int64
          xLimbsSplitted: array[(KARATSUBA_THRESHOLD*5 div 8)*2, int64]
          resultLimbsSplitted: array[(KARATSUBA_THRESHOLD*5 div 8)*4 + 2, int64]
      if x == zero:
          result = new BigInt
          result.sign = true
          result.limbs = @[0'i64]
      else:
          for i in 0..(m-1):
              t = x.limbs[i] div BASE2
              xLimbsSplitted[2*i] = x.limbs[i] - t*BASE2
              xLimbsSplitted[2*i + 1] = t
          for i in 0..(2*m - 1):
              xi = xLimbsSplitted[i]
              for k in (i + 1)..(2*m - 1):
                  resultLimbsSplitted[i+k] += xi * xLimbsSplitted[k] * 2
          for i in 0..(2*m - 1):
              resultLimbsSplitted[2*i] += xLimbsSplitted[i]^2
          result = new BigInt
          result.sign = true
          for i in 0..(4*m + 1):
              t = resultLimbsSplitted[i]
              if t >= BASE2:
                  t2 = t div BASE2
                  resultLimbsSplitted[i] -= t2 * BASE2
                  resultLimbsSplitted[i+1] += t2
          result.limbs = newSeq[int64](len(resultLimbsSplitted) div 2)
          for i in 0..((len(resultLimbsSplitted) div 2) - 1):
              result.limbs[i] = resultLimbsSplitted[2*i] + (resultLimbsSplitted[2*i + 1] * BASE2)
          result.removeLeadingZeros()
  
  proc schoolbookSqrStatic2(x: BigInt): BigInt =
      var
          m: int = len(x.limbs)
          t: int64
          t2: int64
          xi: int64
          xLimbsSplitted: array[(KARATSUBA_THRESHOLD*3 div 4)*2, int64]
          resultLimbsSplitted: array[(KARATSUBA_THRESHOLD*3 div 4)*4 + 2, int64]
      if x == zero:
          result = new BigInt
          result.sign = true
          result.limbs = @[0'i64]
      else:
          for i in 0..(m-1):
              t = x.limbs[i] div BASE2
              xLimbsSplitted[2*i] = x.limbs[i] - t*BASE2
              xLimbsSplitted[2*i + 1] = t
          for i in 0..(2*m - 1):
              xi = xLimbsSplitted[i]
              for k in (i + 1)..(2*m - 1):
                  resultLimbsSplitted[i+k] += xi * xLimbsSplitted[k] * 2
          for i in 0..(2*m - 1):
              resultLimbsSplitted[2*i] += xLimbsSplitted[i]^2
          result = new BigInt
          result.sign = true
          for i in 0..(4*m + 1):
              t = resultLimbsSplitted[i]
              if t >= BASE2:
                  t2 = t div BASE2
                  resultLimbsSplitted[i] -= t2 * BASE2
                  resultLimbsSplitted[i+1] += t2
          result.limbs = newSeq[int64](len(resultLimbsSplitted) div 2)
          for i in 0..((len(resultLimbsSplitted) div 2) - 1):
              result.limbs[i] = resultLimbsSplitted[2*i] + (resultLimbsSplitted[2*i + 1] * BASE2)
          result.removeLeadingZeros()
  
  proc schoolbookSqrStatic3(x: BigInt): BigInt =
      var
          m: int = len(x.limbs)
          t: int64
          t2: int64
          xi: int64
          xLimbsSplitted: array[(KARATSUBA_THRESHOLD*7 div 8)*2, int64]
          resultLimbsSplitted: array[(KARATSUBA_THRESHOLD*7 div 8)*4 + 2, int64]
      if x == zero:
          result = new BigInt
          result.sign = true
          result.limbs = @[0'i64]
      else:
          for i in 0..(m-1):
              t = x.limbs[i] div BASE2
              xLimbsSplitted[2*i] = x.limbs[i] - t*BASE2
              xLimbsSplitted[2*i + 1] = t
          for i in 0..(2*m - 1):
              xi = xLimbsSplitted[i]
              for k in (i + 1)..(2*m - 1):
                  resultLimbsSplitted[i+k] += xi * xLimbsSplitted[k] * 2
          for i in 0..(2*m - 1):
              resultLimbsSplitted[2*i] += xLimbsSplitted[i]^2
          result = new BigInt
          result.sign = true
          for i in 0..(4*m + 1):
              t = resultLimbsSplitted[i]
              if t >= BASE2:
                  t2 = t div BASE2
                  resultLimbsSplitted[i] -= t2 * BASE2
                  resultLimbsSplitted[i+1] += t2
          result.limbs = newSeq[int64](len(resultLimbsSplitted) div 2)
          for i in 0..((len(resultLimbsSplitted) div 2) - 1):
              result.limbs[i] = resultLimbsSplitted[2*i] + (resultLimbsSplitted[2*i + 1] * BASE2)
          result.removeLeadingZeros()
  
  proc schoolbookSqrStatic4(x: BigInt): BigInt =
      var
          m: int = len(x.limbs)
          t: int64
          t2: int64
          xi: int64
          xLimbsSplitted: array[KARATSUBA_THRESHOLD*2, int64]
          resultLimbsSplitted: array[KARATSUBA_THRESHOLD*4 + 2, int64]
      if x == zero:
          result = new BigInt
          result.sign = true
          result.limbs = @[0'i64]
      else:
          for i in 0..(m-1):
              t = x.limbs[i] div BASE2
              xLimbsSplitted[2*i] = x.limbs[i] - t*BASE2
              xLimbsSplitted[2*i + 1] = t
          for i in 0..(2*m - 1):
              xi = xLimbsSplitted[i]
              for k in (i + 1)..(2*m - 1):
                  resultLimbsSplitted[i+k] += xi * xLimbsSplitted[k] * 2
          for i in 0..(2*m - 1):
              resultLimbsSplitted[2*i] += xLimbsSplitted[i]^2
          result = new BigInt
          result.sign = true
          for i in 0..(4*m + 1):
              t = resultLimbsSplitted[i]
              if t >= BASE2:
                  t2 = t div BASE2
                  resultLimbsSplitted[i] -= t2 * BASE2
                  resultLimbsSplitted[i+1] += t2
          result.limbs = newSeq[int64](len(resultLimbsSplitted) div 2)
          for i in 0..((len(resultLimbsSplitted) div 2) - 1):
              result.limbs[i] = resultLimbsSplitted[2*i] + (resultLimbsSplitted[2*i + 1] * BASE2)
          result.removeLeadingZeros()
  
  # Unsigned destructive addition. Only works when x >= y >= 0. Used for Karatsuba and Toom-Cook multiplication.
  proc udadd(x, y: var BigInt) =
      var
          m: int = len(x.limbs)
          n: int = len(y.limbs)
          carry: int64 = 0'i64
          t: int64
      x.limbs.setLen(m+1)
      for i in 0..(n - 1):
          t = x.limbs[i] + y.limbs[i] + carry
          if t >= BASE:
              t -= BASE 
              carry = 1
          else:
              carry = 0
          x.limbs[i] = t 
      for i in n..(m - 1):
          t = x.limbs[i] + carry
          if t >= BASE:
              t -= BASE 
              carry = 1
          else:
              carry = 0
          x.limbs[i] = t 
          if carry == 0:
              break
      if carry == 1:
          x.limbs[m] = 1
      x.removeLeadingZeros()
  
  # Unsigned destructive subtraction. Only works when x >= y >= 0. Used for Karatsuba and Toom-Cook multiplication.
  proc udsub(x, y: var BigInt) =
      var 
          m: int = len(x.limbs)
          n: int = len(y.limbs)
          carry: int64 = 0'i64
          t: int64
      for i in 0..(n - 1):
          t = x.limbs[i] - y.limbs[i] + carry
          if t < 0'i64:
              t += BASE
              carry = -1
          else:
              carry = 0
          x.limbs[i] = t    
      for i in n..(m - 1):
          t = x.limbs[i] + carry
          if t < 0'i64:
              t += BASE
              carry = -1
          else:
              carry = 0
          x.limbs[i] = t
          if carry == 0:
              break
      x.removeLeadingZeros()
  
  # Destructive negation.
  proc dneg(x: var BigInt) =
      if x == zero:
          discard
      else:
          x.sign = not x.sign
  
  # Destructive addition.
  proc dadd(x, y, z: var BigInt) =
      if x.ucmp(y) < 0:
          dadd(y, x, z)
      else:
          if (x >= zero) and (y >= zero):
              x.udadd(y)
              z = x
          elif (x < zero) and (y < zero):
              x.udadd(y)
              z = x
          elif (x >= zero) and (y < zero):
              x.udsub(y)
              z = x
          else:
              x.udsub(y)
              z = x
              # The sign of zero is always positive.
              if z.limbs == @[0'i64]:
                  z.sign = true
  
  # Destructive subtraction.
  proc dsub(x, y, z: var BigInt) =
      y.dneg()
      dadd(x, y, z)
  
  # Karatsuba multiplication. Time complexity is O(n^1.585).
  proc karatsubaMul(x, y: BigInt): BigInt =
      var
          m: int = len(x.limbs)
          n: int = len(y.limbs)
      if min(m, n) < KARATSUBA_THRESHOLD:
          if max(m, n) < KARATSUBA_THRESHOLD*5 div 8:
              result = x.schoolbookMulStatic1(y)
          elif max(m, n) < KARATSUBA_THRESHOLD*3 div 4:
              result = x.schoolbookMulStatic2(y)
          elif max(m, n) < KARATSUBA_THRESHOLD*7 div 8:
              result = x.schoolbookMulStatic3(y)
          elif max(m, n) < KARATSUBA_THRESHOLD:
              result = x.schoolbookMulStatic4(y)
          else:
              result = x.schoolbookMul(y)
      elif m < n:
          result = y.karatsubaMul(x)
      elif m - n > 10:
          var y2: BigInt = BigInt(sign: y.sign, limbs: concat(repeat(0'i64, (m - n)), y.limbs))
          result = x.karatsubaMul(y2)
          result.limbs.compatibleDelete(0,(m - n - 1))
      else:
          var
              a: int = n div 2
              x0: BigInt = BigInt(sign: true, limbs: x.limbs[0..(a - 1)])
              x1: BigInt = BigInt(sign: true, limbs: x.limbs[a..(m - 1)])
              y0: BigInt = BigInt(sign: true, limbs: y.limbs[0..(a - 1)])
              y1: BigInt = BigInt(sign: true, limbs: y.limbs[a..(n - 1)])
              z1, z0, tmp: BigInt
              zeros: seq[int64] = newSeq[int64](a)
          x0.removeLeadingZeros()
          y0.removeLeadingZeros()
          result = x1.karatsubaMul(y1)
          z0 = x0.karatsubaMul(y0)
          dsub(x1, x0, x1)
          dsub(y1, y0, y1)
          z1 = result + z0
          tmp = x1.karatsubaMul(y1)
          dsub(z1, tmp, z1)
          result.limbs.insert(zeros, 0)
          result.udadd(z1)
          result.limbs.insert(zeros, 0)
          result.udadd(z0)
          result.sign = (x.sign == y.sign)
  
  # Karatsuba squaring.
  proc karatsubaSqr(x: BigInt): BigInt =
      var
          m: int = len(x.limbs)
          a: int = m div 2
      if m < KARATSUBA_THRESHOLD:
          if m < KARATSUBA_THRESHOLD*5 div 8:
              result = x.schoolbookSqrStatic1()
          elif m < KARATSUBA_THRESHOLD*3 div 4:
              result = x.schoolbookSqrStatic2()
          elif m < KARATSUBA_THRESHOLD*7 div 8:
              result = x.schoolbookSqrStatic3()
          elif m < KARATSUBA_THRESHOLD:
              result = x.schoolbookSqrStatic4()
          else:
              result = x.schoolbookSqr()
      else:
          var
              x0: BigInt = BigInt(sign: true, limbs: x.limbs[0..(a - 1)])
              x1: BigInt = BigInt(sign: true, limbs: x.limbs[a..(m - 1)])
              z1, z0, tmp: BigInt
              zeros: seq[int64] = newSeq[int64](a)
          x0.removeLeadingZeros()
          result = x1.karatsubaSqr()
          z0 = x0.karatsubaSqr()
          dsub(x1, x0, x1)
          z1 = result + z0
          tmp = x1.karatsubaSqr()
          dsub(z1, tmp, z1)
          result.limbs.insert(zeros, 0)
          result.udadd(z1)
          result.limbs.insert(zeros, 0)
          result.udadd(z0)
          result.sign = true
  
  # Multiplication by small integers. Only used for Toom Cook multiplication.        
  proc mulInt(x: BigInt, y: int64): BigInt =
      var 
          m: int = len(x.limbs)
          t: int64
          carry: int64 = 0
      result = new BigInt
      result.sign = x.sign
      result.limbs = newSeqUninitialized[int64](m)
      for i in 0..(m-1):
          t = x.limbs[i] * y + carry
          if t >= BASE:
              carry = t div BASE
              t -= carry * BASE
          else:
              carry = 0
          result.limbs[i] = t
      if carry > 0:
          result.limbs.setLen(m+1)
          result.limbs[m] = carry
      result.removeLeadingZeros()
      if result.limbs == @[0'i64]:
          result.sign = true
          
  # Destructive mulInt.
  proc dmulInt(x: var BigInt, y: int64) =
      var 
          m: int = len(x.limbs)
          t: int64
          carry: int64 = 0
      for i in 0..(m-1):
          t = x.limbs[i] * y + carry
          if t >= BASE:
              carry = t div BASE
              t -= carry * BASE
          else:
              carry = 0
          x.limbs[i] = t
      if carry > 0:
          x.limbs.setLen(m+1)
          x.limbs[m] = carry
      x.removeLeadingZeros()
      if x.limbs == @[0'i64]:
          x.sign = true
  
  # Destructive division by small integers. Only used for Toom Cook multiplication.  
  proc ddivInt(x: var BigInt, y: int64) = 
      if x == zero:
          discard
      else:
          var 
              t: int64
              t2: int64
          for i in countdown((len(x.limbs) - 1), 1):
              t = x.limbs[i]
              t2 = t div y
              x.limbs[i] = t2
              x.limbs[i-1] += (t - (t2 * y)) * BASE
          x.limbs[0] = x.limbs[0] div y
          x.removeLeadingZeros()
  
  # Toom Cook 3 multiplication. Time complexity is O(n^1.465).
  # Evaluation points are infinity, 1, -1, -2 and 0.
  proc toom3Mul(x, y: BigInt): BigInt = 
      var
          m: int = len(x.limbs)
          n: int = len(y.limbs)
      if (m < TOOM3_THRESHOLD) or (n < TOOM3_THRESHOLD):
          result = x.karatsubaMul(y)
      elif m < n:
          result = y.toom3Mul(x)
      elif m - n > 10:
          var y2: BigInt = BigInt(sign: y.sign, limbs: concat(repeat(0'i64, (m - n)), y.limbs))
          result = x.toom3Mul(y2)
          result.limbs.compatibleDelete(0,(m - n - 1))
      else:
          var
              a: int = n div 3
              x0: BigInt = BigInt(sign: true, limbs: x.limbs[0..(a - 1)])
              x1: BigInt = BigInt(sign: true, limbs: x.limbs[a..(2 * a - 1)])
              x2: BigInt = BigInt(sign: true, limbs: x.limbs[(2 * a)..(m - 1)])
              y0: BigInt = BigInt(sign: true, limbs: y.limbs[0..(a - 1)])
              y1: BigInt = BigInt(sign: true, limbs: y.limbs[a..(2 * a - 1)])
              y2: BigInt = BigInt(sign: true, limbs: y.limbs[(2 * a)..(n - 1)])
              am1, a1, am2, tmp, tmp2, z3, z2, z1, z0: BigInt
              zeros: seq[int64] = newSeq[int64](a)
          
          x0.removeLeadingZeros()
          x1.removeLeadingZeros()
          y0.removeLeadingZeros()
          y1.removeLeadingZeros()
          
          z0 = x0.toom3Mul(y0)
          
          tmp = x0 + x2
          tmp2 = y0 + y2
          a1 = (tmp + x1).toom3Mul(tmp2 + y1)
          am1 = (tmp - x1).toom3Mul(tmp2 - y1)
          
          result = x2.toom3Mul(y2) 
          
          x2.dmulInt(2)
          dsub(x2, x1, tmp)
          tmp.dmulInt(2)
          y2.dmulInt(2)
          dsub(y2, y1, tmp2)
          tmp2.dmulInt(2)
          dadd(tmp, x0, tmp)
          dadd(tmp2, y0, tmp2)
          am2 = tmp.toom3Mul(tmp2)
          
          tmp = result.mulInt(2)
          z1 = am2 + z0.mulInt(3)
          tmp2 = a1.mulInt(2)
          dadd(z1, tmp2, z1)
          z1.ddivInt(6)
          tmp2 = tmp + am1
          dsub(z1, tmp2, z1)
          
          tmp2 = a1 + am1
          tmp2.ddivInt(2)
          z2 = z0 + result
          dsub(tmp2, z2, z2)
          
          tmp2 = am1 - z0
          tmp2.dmulInt(3)
          dsub(a1, am2, z3)
          dadd(z3, tmp2, z3)
          z3.ddivInt(6)
          dadd(z3, tmp, z3)
          
          result.limbs.insert(zeros, 0)
          result.udadd(z3)
          result.limbs.insert(zeros, 0)
          result.udadd(z2)
          result.limbs.insert(zeros, 0)
          result.udadd(z1)
          result.limbs.insert(zeros, 0)
          result.udadd(z0)
          result.sign = (x.sign == y.sign)
  
  # Toom Cook 3 squaring.
  # Evaluation points are infinity, 1, -1, -2 and 0.
  proc toom3Sqr(x: BigInt): BigInt = 
      var
          m: int = len(x.limbs)
          a: int = m div 3
      if m < TOOM3_THRESHOLD:
          result = x.karatsubaSqr()
      else:
          var
              x0: BigInt = BigInt(sign: true, limbs: x.limbs[0..(a - 1)])
              x1: BigInt = BigInt(sign: true, limbs: x.limbs[a..(2 * a - 1)])
              x2: BigInt = BigInt(sign: true, limbs: x.limbs[(2 * a)..(m - 1)])
              am1, a1, am2, tmp, tmp2, z3, z2, z1, z0: BigInt
              zeros: seq[int64] = newSeq[int64](a)
          
          x0.removeLeadingZeros()
          x1.removeLeadingZeros()
          
          z0 = x0.toom3Sqr()
          
          tmp = x0 + x2
          a1 = (tmp + x1).toom3Sqr()
          am1 = (tmp - x1).toom3Sqr()
          
          result = x2.toom3Sqr() 
          
          x2.dmulInt(2)
          dsub(x2, x1, tmp)
          tmp.dmulInt(2)
          dadd(tmp, x0, tmp)
          am2 = tmp.toom3Sqr()
          
          tmp = result.mulInt(2)
          z1 = am2 + z0.mulInt(3)
          tmp2 = a1.mulInt(2)
          dadd(z1, tmp2, z1)
          z1.ddivInt(6)
          tmp2 = tmp + am1
          dsub(z1, tmp2, z1)
          
          tmp2 = a1 + am1
          tmp2.ddivInt(2)
          z2 = z0 + result
          dsub(tmp2, z2, z2)
          
          tmp2 = am1 - z0
          tmp2.dmulInt(3)
          dsub(a1, am2, z3)
          dadd(z3, tmp2, z3)
          z3.ddivInt(6)
          dadd(z3, tmp, z3)
          
          result.limbs.insert(zeros, 0)
          result.udadd(z3)
          result.limbs.insert(zeros, 0)
          result.udadd(z2)
          result.limbs.insert(zeros, 0)
          result.udadd(z1)
          result.limbs.insert(zeros, 0)
          result.udadd(z0)
          result.sign = true
  
  # Toom Cook 4.5 multiplication. Time complexity is O(n^1.404).
  # Evaluation points are 1, -1, 2, -2, 1/2, -1/2 and 0.
  proc toom4hMul(x, y: BigInt): BigInt = 
      var
          m: int = len(x.limbs)
          n: int = len(y.limbs)
      if (m < TOOM4_THRESHOLD) or (n < TOOM4_THRESHOLD):
          result = x.toom3Mul(y)
      elif m < n:
          result = y.toom4hMul(x)
      elif m - n > 10:
          var y2: BigInt = BigInt(sign: y.sign, limbs: concat(repeat(0'i64, (m - n)), y.limbs))
          result = x.toom4hMul(y2)
          result.limbs.compatibleDelete(0,(m - n - 1))
      else:
          var
              a: int = n div 4
              x0: BigInt = BigInt(sign: true, limbs: x.limbs[0..(a - 1)])
              x1: BigInt = BigInt(sign: true, limbs: x.limbs[a..(2 * a - 1)])
              x2: BigInt = BigInt(sign: true, limbs: x.limbs[(2 * a)..(3 * a - 1)])
              x3: BigInt = BigInt(sign: true, limbs: x.limbs[(3 * a)..(m - 1)])
              y0: BigInt = BigInt(sign: true, limbs: y.limbs[0..(a - 1)])
              y1: BigInt = BigInt(sign: true, limbs: y.limbs[a..(2 * a - 1)])
              y2: BigInt = BigInt(sign: true, limbs: y.limbs[(2 * a)..(3 * a - 1)])
              y3: BigInt = BigInt(sign: true, limbs: y.limbs[(3 * a)..(n - 1)])
              am1_2, a1_2, am1, a1, am2, a2, tmp, tmp2, tmp3, tmp4, tmp5, z5, z4, z3, z2, z1, z0: BigInt
              zeros: seq[int64] = newSeq[int64](a)          
          
          x0.removeLeadingZeros()
          x1.removeLeadingZeros()
          x2.removeLeadingZeros()
          y0.removeLeadingZeros()
          y1.removeLeadingZeros()
          y2.removeLeadingZeros()        
          
          z0 = x0.toom4hMul(y0)        
          
          tmp = x3 + x1
          tmp2 = x2 + x0
          tmp3 = y3 + y1
          tmp4 = y2 + y0
          a1 = (tmp2 + tmp).toom4hMul(tmp4 + tmp3)
          dsub(tmp2, tmp, tmp2)
          dsub(tmp4, tmp3, tmp4)
          am1 = tmp2.toom4hMul(tmp4)        
          
          tmp = x3.mulInt(4) + x1 
          tmp.dmulInt(2)
          tmp2 = x2.mulInt(4) + x0
          tmp3 = y3.mulInt(4) + y1    
          tmp3.dmulInt(2)   
          tmp4 = y2.mulInt(4) + y0
          a2 = (tmp2 + tmp).toom4hMul(tmp4 + tmp3)
          dsub(tmp2, tmp, tmp2)
          dsub(tmp4, tmp3, tmp4)
          am2 = tmp2.toom4hMul(tmp4)  
          
          x1.dmulInt(4)
          dadd(x3, x1, tmp)
          tmp.dmulInt(2)
          x0.dmulInt(4) 
          dadd(x2, x0, tmp2)
          tmp2.dmulInt(4)
          y1.dmulInt(4)
          dadd(y3, y1, tmp3)
          y0.dmulInt(4)
          dadd(y2, y0, tmp4)
          tmp4.dmulInt(2)       
          a1_2 = (tmp2 + tmp).toom4hMul(tmp4 + tmp3)
          dsub(tmp2, tmp, tmp2)
          dsub(tmp4, tmp3, tmp4)
          am1_2 = tmp2.toom4hMul(tmp4)               
          
          tmp = a1_2 + am1_2
          tmp2 = a2 + am2
          tmp3 = a1 + am1        
          
          result = tmp2 - tmp3.mulInt(20)
          result.dmulInt(2)
          result = result + tmp
          result.ddivInt(180)
          result = result - z0        
          
          tmp4 = z0.mulInt(189)
          z4 = tmp4 - tmp
          z4.dmulInt(2)
          z4 = z4 - tmp2
          tmp5 = tmp3.mulInt(68)
          dadd(z4, tmp5, z4)
          z4.ddivInt(72)     
          
          tmp.dmulInt(8)   
          tmp3.dmulInt(80)
          tmp4.dmulInt(10)
          dadd(tmp, tmp2, z2)
          dsub(z2, tmp3, z2)
          dsub(z2, tmp4, z2)
          z2.ddivInt(360)        
          
          dsub(a1_2, am1_2, tmp)
          dsub(a2, am2, tmp2)
          dsub(a1, am1, tmp3)     
          
          z5 = tmp2 - tmp3.mulInt(10)
          z5.dmulInt(8)
          z5 = z5 + tmp
          z5.ddivInt(360)                
          
          z3 = tmp3.mulInt(34) - tmp2
          z3.dmulInt(2)
          z3 = z3 - tmp
          z3.ddivInt(72)        
          
          tmp3.dmulInt(20)
          dsub(tmp, tmp3, z1)
          z1.dmulInt(2)
          dadd(z1, tmp2, z1)
          z1.ddivInt(180)        
          
          result.limbs.insert(zeros, 0)
          result.udadd(z5)
          result.limbs.insert(zeros, 0)
          result.udadd(z4)
          result.limbs.insert(zeros, 0)
          result.udadd(z3)
          result.limbs.insert(zeros, 0)
          result.udadd(z2)
          result.limbs.insert(zeros, 0)
          result.udadd(z1)
          result.limbs.insert(zeros, 0)
          result.udadd(z0)
          result.sign = (x.sign == y.sign)
          
  # Toom Cook 4 squaring.
  # Evaluation points are infinity, 1, -1, 2, -2, -1/2 and 0.
  proc toom4Sqr(x: BigInt): BigInt = 
      var
          m: int = len(x.limbs)
          a: int = m div 4
      if m < TOOM4_THRESHOLD:
          result = x.toom3Sqr()
      else:
          var
              x0: BigInt = BigInt(sign: true, limbs: x.limbs[0..(a - 1)])
              x1: BigInt = BigInt(sign: true, limbs: x.limbs[a..(2 * a - 1)])
              x2: BigInt = BigInt(sign: true, limbs: x.limbs[(2 * a)..(3 * a - 1)])
              x3: BigInt = BigInt(sign: true, limbs: x.limbs[(3 * a)..(m - 1)])
              am1_2: BigInt # a(-1/2)
              am1: BigInt # a(-1)
              a1: BigInt # a(1)
              am2: BigInt # a(-2)
              a2: BigInt # a(2)
              tmp: BigInt
              tmp2: BigInt
              tmp3: BigInt
              tmp4: BigInt
              tmp5: BigInt
              z5: BigInt
              z4: BigInt
              z3: BigInt
              z2: BigInt
              z1: BigInt
              z0: BigInt         
              zeros: seq[int64] = newSeq[int64](a)  
          
          x0.removeLeadingZeros()
          x1.removeLeadingZeros()
          x2.removeLeadingZeros()
          
          z0 = x0.toom4Sqr()
          
          result = x3.toom4Sqr()
          
          tmp = x3.mulInt(4) + x1
          tmp.dmulInt(2)
          tmp2 = x2.mulInt(4) + x0
          a2 = (tmp + tmp2).toom4Sqr()
          dsub(tmp2, tmp, tmp2)
          am2 = tmp2.toom4Sqr()
          
          tmp = x3 + x1
          tmp2 = x2 + x0
          a1 = (tmp + tmp2).toom4Sqr()
          dsub(tmp2, tmp, tmp2)
          am1 = tmp2.toom4Sqr()
          
          x2.dmulInt(2)
          x0.dmulInt(8)
          x1.dmulInt(4)
          dadd(x2, x0, tmp)
          dsub(tmp, x3, tmp)
          dsub(tmp, x1, tmp)
          am1_2 = tmp.toom4Sqr()
          
          tmp = z0 + result
          tmp2 = a1 + am1
          tmp3 = am2.mulInt(5)
          tmp4 = a2.mulInt(3)
          
          z5 = tmp.mulInt(90) - am1_2.mulInt(2) + tmp4 - tmp3 - a1.mulInt(20) + am1.mulInt(60)
          z5.ddivInt(180)
          
          z1 = am1_2.mulInt(8)
          z1.dneg()
          tmp5 = tmp4 + tmp3
          dsub(z1, tmp5, z1)
          tmp5 = a1.mulInt(40)
          dadd(z1, tmp5, z1)
          tmp5 = am1.mulInt(120)
          dadd(z1, tmp5, z1)
          z1.ddivInt(180)
          tmp5 = tmp.mulInt(2)
          dadd(z1, tmp5, z1)
          
          tmp3 = a2 + am2
          tmp5 = tmp2.mulInt(4)
          z4 = tmp3 - tmp5
          tmp5 = z0.mulInt(6)
          dadd(z4, tmp5, z4)
          tmp5 = result.mulInt(5)
          z4.ddivInt(24)
          dsub(z4, tmp5, z4)
          
          z3 = new BigInt
          tmp.dmulInt(45)
          dsub(am1_2, tmp, z3)
          dadd(z3, am2, z3)
          a1.dmulInt(7)
          dadd(z3, a1, z3)
          am1.dmulInt(27)
          dsub(z3, am1, z3)
          z3.ddivInt(18)
          
          z2 = new BigInt
          tmp = z0.mulInt(30)
          tmp2.dmulInt(16)
          dsub(tmp2, tmp3, z2)
          dsub(z2, tmp, z2)
          tmp = result.mulInt(4)
          z2.ddivInt(24)
          dadd(z2, tmp, z2)
          
          result.limbs.insert(zeros, 0)
          result.udadd(z5)
          result.limbs.insert(zeros, 0)
          result.udadd(z4)
          result.limbs.insert(zeros, 0)
          result.udadd(z3)
          result.limbs.insert(zeros, 0)
          result.udadd(z2)
          result.limbs.insert(zeros, 0)
          result.udadd(z1)
          result.limbs.insert(zeros, 0)
          result.udadd(z0)
          result.sign = true
  
  # Toom Cook 6.5 multiplication. Time complexity is O(n^1.338).
  # Evaluation points are 1, -1, 2, -2, 1/2, -1/2, 3, -3, 1/3, -1/3 and 0.
  proc toom6hMul(x, y: BigInt): BigInt = 
      var
          m: int = len(x.limbs)
          n: int = len(y.limbs)
      if (m < TOOM6H_THRESHOLD) or (n < TOOM6H_THRESHOLD):
          result = x.toom4hMul(y)
      elif m < n:
          result = y.toom6hMul(x)
      elif m - n > 10:
          var y2: BigInt = BigInt(sign: y.sign, limbs: concat(repeat(0'i64, (m - n)), y.limbs))
          result = x.toom6hMul(y2)
          result.limbs.compatibleDelete(0,(m - n - 1))
      else:
          var
              a: int = n div 6
              x0: BigInt = BigInt(sign: true, limbs: x.limbs[0..(a - 1)])
              x1: BigInt = BigInt(sign: true, limbs: x.limbs[a..(2 * a - 1)])
              x2: BigInt = BigInt(sign: true, limbs: x.limbs[(2 * a)..(3 * a - 1)])
              x3: BigInt = BigInt(sign: true, limbs: x.limbs[(3 * a)..(4 * a - 1)])
              x4: BigInt = BigInt(sign: true, limbs: x.limbs[(4 * a)..(5 * a - 1)])
              x5: BigInt = BigInt(sign: true, limbs: x.limbs[(5 * a)..(m - 1)])
              y0: BigInt = BigInt(sign: true, limbs: y.limbs[0..(a - 1)])
              y1: BigInt = BigInt(sign: true, limbs: y.limbs[a..(2 * a - 1)])
              y2: BigInt = BigInt(sign: true, limbs: y.limbs[(2 * a)..(3 * a - 1)])
              y3: BigInt = BigInt(sign: true, limbs: y.limbs[(3 * a)..(4 * a - 1)])
              y4: BigInt = BigInt(sign: true, limbs: y.limbs[(4 * a)..(5 * a - 1)])
              y5: BigInt = BigInt(sign: true, limbs: y.limbs[(5 * a)..(n - 1)])
              a1_3, am1_3, a3, am3, a1_2, am1_2, a2, am2, a1, am1, tmp, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, z9, z8, z7, z6, z5, z4, z3, z2, z1, z0: BigInt
              zeros: seq[int64] = newSeq[int64](a)
          
          x0.removeLeadingZeros()
          x1.removeLeadingZeros()
          x2.removeLeadingZeros()
          x3.removeLeadingZeros()
          x4.removeLeadingZeros()
          y0.removeLeadingZeros()
          y1.removeLeadingZeros()
          y2.removeLeadingZeros()
          y3.removeLeadingZeros()
          y4.removeLeadingZeros()
          
          z0 = x0.toom6hMul(y0)
          
          tmp = x5.mulInt(3)
          tmp6 = x3.mulInt(27)
          dadd(tmp, tmp6, tmp)
          tmp6 = x1.mulInt(243)
          dadd(tmp, tmp6, tmp)
          
          tmp2 = x4.mulInt(9)
          tmp6 = x2.mulInt(81) 
          dadd(tmp2, tmp6, tmp2)
          tmp6 = x0.mulInt(729)
          dadd(tmp2, tmp6, tmp2)
          
          tmp3 = y3.mulInt(9)
          tmp6 = y1.mulInt(81)
          dadd(tmp3, tmp6, tmp3)
          tmp3 = tmp3 + y5
          
          tmp4 = y4.mulInt(3)
          tmp6 = y2.mulInt(27)
          dadd(tmp4, tmp6, tmp4)
          tmp6 = y0.mulInt(243)
          dadd(tmp4, tmp6, tmp4)
          
          a1_3 = (tmp + tmp2).toom6hMul(tmp3 + tmp4)
          dsub(tmp2, tmp, tmp2)
          dsub(tmp4, tmp3, tmp4)
          am1_3 = tmp2.toom6hMul(tmp4)
          
          tmp = x5.mulInt(243)
          tmp6 = x3.mulInt(27)
          dadd(tmp, tmp6, tmp)
          tmp6 = x1.mulInt(3)
          dadd(tmp, tmp6, tmp)
          
          tmp2 = x4.mulInt(81)
          tmp6 = x2.mulInt(9)
          dadd(tmp2, tmp6, tmp2)
          tmp2 = tmp2 + x0
          
          tmp3 = y5.mulInt(243)
          tmp6 = y3.mulInt(27)
          dadd(tmp3, tmp6, tmp3)
          tmp6 = y1.mulInt(3)
          dadd(tmp3, tmp6, tmp3)
          
          tmp4 = y4.mulInt(81)
          tmp6 = y2.mulInt(9)
          dadd(tmp4, tmp6, tmp4)
          tmp4 = tmp4 + y0
          
          a3 = (tmp + tmp2).toom6hMul(tmp3 + tmp4)
          dsub(tmp2, tmp, tmp2)
          dsub(tmp4, tmp3, tmp4)
          am3 = tmp2.toom6hMul(tmp4)
          
          tmp = x5.mulInt(2)
          tmp6 = x3.mulInt(8)
          dadd(tmp, tmp6, tmp)
          tmp6 = x1.mulInt(32)
          dadd(tmp, tmp6, tmp)
          
          tmp2 = x4.mulInt(4)
          tmp6 = x2.mulInt(16)
          dadd(tmp2, tmp6, tmp2)
          tmp6 = x0.mulInt(64)
          dadd(tmp2, tmp6, tmp2)
          
          tmp3 = y3.mulInt(4)
          tmp6 = y1.mulInt(16)
          dadd(tmp3, tmp6, tmp3)
          tmp3 = tmp3 + y5
          
          tmp4 = y4.mulInt(2)
          tmp6 = y2.mulInt(8)
          dadd(tmp4, tmp6, tmp4)
          tmp6 = y0.mulInt(32)
          dadd(tmp4, tmp6, tmp4)
          
          a1_2 = (tmp2 + tmp).toom6hMul(tmp4 + tmp3)
          dsub(tmp2, tmp, tmp2)
          dsub(tmp4, tmp3, tmp4)
          am1_2 = tmp2.toom6hMul(tmp4)
          
          tmp = x5.mulInt(32)
          tmp6 = x3.mulInt(8)
          dadd(tmp, tmp6, tmp)
          tmp6 = x1.mulInt(2)
          dadd(tmp, tmp6, tmp)
          
          tmp2 = x4.mulInt(16)
          tmp6 = x2.mulInt(4)
          dadd(tmp2, tmp6, tmp2)
          tmp2 = tmp2 + x0
          
          tmp3 = y5.mulInt(32)
          tmp6 = y3.mulInt(8)
          dadd(tmp3, tmp6, tmp3)
          tmp6 = y1.mulInt(2)
          dadd(tmp3, tmp6, tmp3)
          
          tmp4 = y4.mulInt(16)
          tmp6 = y2.mulInt(4)
          dadd(tmp4, tmp6, tmp4)
          tmp4 = tmp4 + y0
          
          a2 = (tmp2 + tmp).toom6hMul(tmp4 + tmp3)
          dsub(tmp2, tmp, tmp2)
          dsub(tmp4, tmp3, tmp4)
          am2 = tmp2.toom6hMul(tmp4)
          
          dadd(x5, x3, tmp)
          dadd(tmp, x1, tmp)
          dadd(x4, x2, tmp2)
          dadd(tmp2, x0, tmp2)
          dadd(y5, y3, tmp3)
          dadd(tmp3, y1, tmp3)
          dadd(y4, y2, tmp4)
          dadd(tmp4, y0, tmp4)
          
          a1 = (tmp2 + tmp).toom6hMul(tmp4 + tmp3)
          dsub(tmp2, tmp, tmp2)
          dsub(tmp4, tmp3, tmp4)
          am1 = tmp2.toom6hMul(tmp4)
          
          tmp = a1 + am1
          tmp.dmulInt(50)        
          tmp2 = a2 + am2
          tmp2.dmulInt(8)        
          tmp3 = a1_2 + am1_2
          tmp3.dmulInt(16)        
          tmp4 = a3 + am3        
          tmp5 = a1_3 + am1_3
                  
          result = tmp.mulInt(35)
          tmp6 = tmp2.mulInt(4)
          dsub(result, tmp6, result)
          tmp6 = tmp4 - tmp3
          dadd(result, tmp6, result)
          result.dmulInt(3)
          result = result + tmp5
          result.ddivInt(480)
          result.ddivInt(350)
          result = result - z0
          
          tmp7 = z0.mulInt(400)
          
          z8 = tmp7.mulInt(70)
          z8.dmulInt(517)
          tmp6 = tmp2.mulInt(746)
          dadd(z8, tmp6, z8)
          tmp6 = tmp3.mulInt(254)
          dadd(z8, tmp6, z8)
          z8.dmulInt(2)
          tmp6 = tmp.mulInt(35)
          tmp6.dmulInt(481)
          dsub(z8, tmp6, z8)
          tmp6 = tmp4.mulInt(193)
          dsub(z8, tmp6, z8)
          tmp6 = tmp5.mulInt(171)
          dsub(z8, tmp6, z8)
          z8.ddivInt(768)
          z8.ddivInt(525)
          z8.ddivInt(5)
          
          z6 = tmp7.mulInt(6)
          z6.dmulInt(649)
          tmp6 = tmp.mulInt(733)
          dsub(tmp6, z6, z6)
          tmp6 = tmp2 + tmp3
          tmp6.dmulInt(26)
          dsub(z6, tmp6, z6)
          tmp6 = tmp4 + tmp5.mulInt(3)
          tmp6.dmulInt(3)
          dadd(z6, tmp6, z6)
          z6.ddivInt(288)
          z6.ddivInt(100)
          
          z4 = tmp7.mulInt(210)
          z4.dmulInt(649)
          tmp6 = tmp2.mulInt(254)
          dadd(z4, tmp6, z4)
          tmp6 = tmp3.mulInt(746)
          dadd(z4, tmp6, z4)
          z4.dmulInt(2)
          tmp6 = tmp.mulInt(35)
          tmp6.dmulInt(481)
          dsub(z4, tmp6, z4)
          tmp6 = tmp4.mulInt(57)
          dsub(z4, tmp6, z4)
          tmp6 = tmp5.mulInt(579)
          dsub(z4, tmp6, z4)
          z4.ddivInt(768)
          z4.ddivInt(525)
          z4.ddivInt(5)
          
          z2 = tmp7
          z2.dmulInt(35)
          z2.dmulInt(517)
          dsub(tmp4, z2, z2)
          tmp.dmulInt(35)
          tmp3.dmulInt(4)
          tmp5.dmulInt(3)
          dsub(tmp, tmp2, tmp6)
          dsub(tmp6, tmp3, tmp6)
          dadd(tmp6, tmp5, tmp6)
          tmp6.dmulInt(9)
          dadd(z2, tmp6, z2)
          z2.ddivInt(875)
          z2.ddivInt(576)
                  
          dsub(a1, am1, tmp)
          tmp.dmulInt(50)
          dsub(a2, am2, tmp2)
          tmp2.dmulInt(16)
          dsub(a1_2, am1_2, tmp3)
          tmp3.dmulInt(8) 
          dsub(a3, am3, tmp4)
          dsub(a1_3, am1_3, tmp5)
          
          z9 = tmp.mulInt(35)
          tmp6 = tmp2.mulInt(4)
          dsub(z9, tmp6, z9)
          z9 = z9 - tmp3
          tmp6 = tmp4.mulInt(3)
          dadd(z9, tmp6, z9)
          z9.dmulInt(9)
          z9 = z9 + tmp5
          z9.ddivInt(875)
          z9.ddivInt(576)
          
          z7 = tmp2.mulInt(746)
          tmp6 = tmp3.mulInt(254)
          dadd(z7, tmp6, z7)
          z7.dmulInt(2)
          tmp6 = tmp.mulInt(35)
          tmp6.dmulInt(481)
          dsub(z7, tmp6, z7)
          tmp6 = tmp4.mulInt(579)
          dsub(z7, tmp6, z7)
          tmp6 = tmp5.mulInt(57)
          dsub(z7, tmp6, z7)
          z7.ddivInt(768)
          z7.ddivInt(525)
          z7.ddivInt(5)
          
          z5 = tmp2 + tmp3
          z5.dmulInt(26)
          tmp6 = tmp.mulInt(733)
          dsub(tmp6, z5, z5)
          tmp6 = tmp4.mulInt(3) + tmp5
          tmp6.dmulInt(3)
          dadd(z5, tmp6, z5)
          z5.ddivInt(288)
          z5.ddivInt(100)
          
          z3 = tmp2.mulInt(254)
          tmp6 = tmp3.mulInt(746)
          dadd(z3, tmp6, z3)
          z3.dmulInt(2)
          tmp6 = tmp.mulInt(35)
          tmp6.dmulInt(481)
          dsub(z3, tmp6, z3)
          tmp6 = tmp4.mulInt(171)
          dsub(z3, tmp6, z3)
          tmp6 = tmp5.mulInt(193)
          dsub(z3, tmp6, z3)
          z3.ddivInt(768)
          z3.ddivInt(525)
          z3.ddivInt(5)
          
          z1 = tmp
          z1.dmulInt(35)
          dsub(z1, tmp2, z1)
          dadd(z1, tmp5, z1)
          tmp3.dmulInt(4)
          dsub(z1, tmp3, z1)
          z1.dmulInt(3)
          dadd(z1, tmp4, z1)
          z1.ddivInt(480)
          z1.ddivInt(350)
          
          result.limbs.insert(zeros, 0)
          result.udadd(z9)
          result.limbs.insert(zeros, 0)
          result.udadd(z8)
          result.limbs.insert(zeros, 0)
          result.udadd(z7)
          result.limbs.insert(zeros, 0)
          result.udadd(z6)
          result.limbs.insert(zeros, 0)
          result.udadd(z5)
          result.limbs.insert(zeros, 0)
          result.udadd(z4)
          result.limbs.insert(zeros, 0)
          result.udadd(z3)
          result.limbs.insert(zeros, 0)
          result.udadd(z2)
          result.limbs.insert(zeros, 0)
          result.udadd(z1)
          result.limbs.insert(zeros, 0)
          result.udadd(z0)
          result.sign = (x.sign == y.sign)
  
  proc toom6hSqr(x: BigInt): BigInt = 
      var
          m: int = len(x.limbs)
          a: int = m div 6
      if m < TOOM6H_THRESHOLD:
          result = x.toom4Sqr()
      else:
          var
              x0: BigInt = BigInt(sign: true, limbs: x.limbs[0..(a - 1)])
              x1: BigInt = BigInt(sign: true, limbs: x.limbs[a..(2 * a - 1)])
              x2: BigInt = BigInt(sign: true, limbs: x.limbs[(2 * a)..(3 * a - 1)])
              x3: BigInt = BigInt(sign: true, limbs: x.limbs[(3 * a)..(4 * a - 1)])
              x4: BigInt = BigInt(sign: true, limbs: x.limbs[(4 * a)..(5 * a - 1)])
              x5: BigInt = BigInt(sign: true, limbs: x.limbs[(5 * a)..(m - 1)])
              a1_3, am1_3, a3, am3, a1_2, am1_2, a2, am2, a1, am1, tmp, tmp2, tmp3, tmp4, tmp5, tmp6, tmp7, z9, z8, z7, z6, z5, z4, z3, z2, z1, z0: BigInt
              zeros: seq[int64] = newSeq[int64](a)
          
          x0.removeLeadingZeros()
          x1.removeLeadingZeros()
          x2.removeLeadingZeros()
          x3.removeLeadingZeros()
          x4.removeLeadingZeros()
          
          z0 = x0.toom6hSqr()
          
          tmp = x5.mulInt(3)
          tmp6 = x3.mulInt(27)
          dadd(tmp, tmp6, tmp)
          tmp6 = x1.mulInt(243)
          dadd(tmp, tmp6, tmp)
          
          tmp2 = x4.mulInt(9)
          tmp6 = x2.mulInt(81) 
          dadd(tmp2, tmp6, tmp2)
          tmp6 = x0.mulInt(729)
          dadd(tmp2, tmp6, tmp2)
          
          tmp3 = x3.mulInt(9)
          tmp6 = x1.mulInt(81)
          dadd(tmp3, tmp6, tmp3)
          tmp3 = tmp3 + x5
          
          tmp4 = x4.mulInt(3)
          tmp6 = x2.mulInt(27)
          dadd(tmp4, tmp6, tmp4)
          tmp6 = x0.mulInt(243)
          dadd(tmp4, tmp6, tmp4)
          
          a1_3 = (tmp + tmp2).toom6hMul(tmp3 + tmp4)
          dsub(tmp2, tmp, tmp2)
          dsub(tmp4, tmp3, tmp4)
          am1_3 = tmp2.toom6hMul(tmp4)
          
          tmp = x5.mulInt(243)
          tmp6 = x3.mulInt(27)
          dadd(tmp, tmp6, tmp)
          tmp6 = x1.mulInt(3)
          dadd(tmp, tmp6, tmp)
          
          tmp2 = x4.mulInt(81)
          tmp6 = x2.mulInt(9)
          dadd(tmp2, tmp6, tmp2)
          tmp2 = tmp2 + x0
          
          a3 = (tmp + tmp2).toom6hSqr()
          dsub(tmp2, tmp, tmp2)
          am3 = tmp2.toom6hSqr()
          
          tmp = x5.mulInt(2)
          tmp6 = x3.mulInt(8)
          dadd(tmp, tmp6, tmp)
          tmp6 = x1.mulInt(32)
          dadd(tmp, tmp6, tmp)
          
          tmp2 = x4.mulInt(4)
          tmp6 = x2.mulInt(16)
          dadd(tmp2, tmp6, tmp2)
          tmp6 = x0.mulInt(64)
          dadd(tmp2, tmp6, tmp2)
          
          tmp3 = x3.mulInt(4)
          tmp6 = x1.mulInt(16)
          dadd(tmp3, tmp6, tmp3)
          tmp3 = tmp3 + x5
          
          tmp4 = x4.mulInt(2)
          tmp6 = x2.mulInt(8)
          dadd(tmp4, tmp6, tmp4)
          tmp6 = x0.mulInt(32)
          dadd(tmp4, tmp6, tmp4)
          
          a1_2 = (tmp2 + tmp).toom6hMul(tmp4 + tmp3)
          dsub(tmp2, tmp, tmp2)
          dsub(tmp4, tmp3, tmp4)
          am1_2 = tmp2.toom6hMul(tmp4)
          
          tmp = x5.mulInt(32)
          tmp6 = x3.mulInt(8)
          dadd(tmp, tmp6, tmp)
          tmp6 = x1.mulInt(2)
          dadd(tmp, tmp6, tmp)
          
          tmp2 = x4.mulInt(16)
          tmp6 = x2.mulInt(4)
          dadd(tmp2, tmp6, tmp2)
          tmp2 = tmp2 + x0
          
          a2 = (tmp2 + tmp).toom6hSqr()
          dsub(tmp2, tmp, tmp2)
          am2 = tmp2.toom6hSqr()
          
          dadd(x5, x3, tmp)
          dadd(tmp, x1, tmp)
          dadd(x4, x2, tmp2)
          dadd(tmp2, x0, tmp2)
          
          a1 = (tmp2 + tmp).toom6hSqr()
          dsub(tmp2, tmp, tmp2)
          am1 = tmp2.toom6hSqr()
          
          tmp = a1 + am1
          tmp.dmulInt(50)        
          tmp2 = a2 + am2
          tmp2.dmulInt(8)        
          tmp3 = a1_2 + am1_2
          tmp3.dmulInt(16)        
          tmp4 = a3 + am3        
          tmp5 = a1_3 + am1_3
                  
          result = tmp.mulInt(35)
          tmp6 = tmp2.mulInt(4)
          dsub(result, tmp6, result)
          tmp6 = tmp4 - tmp3
          dadd(result, tmp6, result)
          result.dmulInt(3)
          result = result + tmp5
          result.ddivInt(480)
          result.ddivInt(350)
          result = result - z0
          
          tmp7 = z0.mulInt(400)
          
          z8 = tmp7.mulInt(70)
          z8.dmulInt(517)
          tmp6 = tmp2.mulInt(746)
          dadd(z8, tmp6, z8)
          tmp6 = tmp3.mulInt(254)
          dadd(z8, tmp6, z8)
          z8.dmulInt(2)
          tmp6 = tmp.mulInt(35)
          tmp6.dmulInt(481)
          dsub(z8, tmp6, z8)
          tmp6 = tmp4.mulInt(193)
          dsub(z8, tmp6, z8)
          tmp6 = tmp5.mulInt(171)
          dsub(z8, tmp6, z8)
          z8.ddivInt(768)
          z8.ddivInt(525)
          z8.ddivInt(5)
          
          z6 = tmp7.mulInt(6)
          z6.dmulInt(649)
          tmp6 = tmp.mulInt(733)
          dsub(tmp6, z6, z6)
          tmp6 = tmp2 + tmp3
          tmp6.dmulInt(26)
          dsub(z6, tmp6, z6)
          tmp6 = tmp4 + tmp5.mulInt(3)
          tmp6.dmulInt(3)
          dadd(z6, tmp6, z6)
          z6.ddivInt(288)
          z6.ddivInt(100)
          
          z4 = tmp7.mulInt(210)
          z4.dmulInt(649)
          tmp6 = tmp2.mulInt(254)
          dadd(z4, tmp6, z4)
          tmp6 = tmp3.mulInt(746)
          dadd(z4, tmp6, z4)
          z4.dmulInt(2)
          tmp6 = tmp.mulInt(35)
          tmp6.dmulInt(481)
          dsub(z4, tmp6, z4)
          tmp6 = tmp4.mulInt(57)
          dsub(z4, tmp6, z4)
          tmp6 = tmp5.mulInt(579)
          dsub(z4, tmp6, z4)
          z4.ddivInt(768)
          z4.ddivInt(525)
          z4.ddivInt(5)
          
          z2 = tmp7
          z2.dmulInt(35)
          z2.dmulInt(517)
          dsub(tmp4, z2, z2)
          tmp.dmulInt(35)
          tmp3.dmulInt(4)
          tmp5.dmulInt(3)
          dsub(tmp, tmp2, tmp6)
          dsub(tmp6, tmp3, tmp6)
          dadd(tmp6, tmp5, tmp6)
          tmp6.dmulInt(9)
          dadd(z2, tmp6, z2)
          z2.ddivInt(875)
          z2.ddivInt(576)
                  
          dsub(a1, am1, tmp)
          tmp.dmulInt(50)
          dsub(a2, am2, tmp2)
          tmp2.dmulInt(16)
          dsub(a1_2, am1_2, tmp3)
          tmp3.dmulInt(8) 
          dsub(a3, am3, tmp4)
          dsub(a1_3, am1_3, tmp5)
          
          z9 = tmp.mulInt(35)
          tmp6 = tmp2.mulInt(4)
          dsub(z9, tmp6, z9)
          z9 = z9 - tmp3
          tmp6 = tmp4.mulInt(3)
          dadd(z9, tmp6, z9)
          z9.dmulInt(9)
          z9 = z9 + tmp5
          z9.ddivInt(875)
          z9.ddivInt(576)
          
          z7 = tmp2.mulInt(746)
          tmp6 = tmp3.mulInt(254)
          dadd(z7, tmp6, z7)
          z7.dmulInt(2)
          tmp6 = tmp.mulInt(35)
          tmp6.dmulInt(481)
          dsub(z7, tmp6, z7)
          tmp6 = tmp4.mulInt(579)
          dsub(z7, tmp6, z7)
          tmp6 = tmp5.mulInt(57)
          dsub(z7, tmp6, z7)
          z7.ddivInt(768)
          z7.ddivInt(525)
          z7.ddivInt(5)
          
          z5 = tmp2 + tmp3
          z5.dmulInt(26)
          tmp6 = tmp.mulInt(733)
          dsub(tmp6, z5, z5)
          tmp6 = tmp4.mulInt(3) + tmp5
          tmp6.dmulInt(3)
          dadd(z5, tmp6, z5)
          z5.ddivInt(288)
          z5.ddivInt(100)
          
          z3 = tmp2.mulInt(254)
          tmp6 = tmp3.mulInt(746)
          dadd(z3, tmp6, z3)
          z3.dmulInt(2)
          tmp6 = tmp.mulInt(35)
          tmp6.dmulInt(481)
          dsub(z3, tmp6, z3)
          tmp6 = tmp4.mulInt(171)
          dsub(z3, tmp6, z3)
          tmp6 = tmp5.mulInt(193)
          dsub(z3, tmp6, z3)
          z3.ddivInt(768)
          z3.ddivInt(525)
          z3.ddivInt(5)
          
          z1 = tmp
          z1.dmulInt(35)
          dsub(z1, tmp2, z1)
          dadd(z1, tmp5, z1)
          tmp3.dmulInt(4)
          dsub(z1, tmp3, z1)
          z1.dmulInt(3)
          dadd(z1, tmp4, z1)
          z1.ddivInt(480)
          z1.ddivInt(350)
          
          result.limbs.insert(zeros, 0)
          result.udadd(z9)
          result.limbs.insert(zeros, 0)
          result.udadd(z8)
          result.limbs.insert(zeros, 0)
          result.udadd(z7)
          result.limbs.insert(zeros, 0)
          result.udadd(z6)
          result.limbs.insert(zeros, 0)
          result.udadd(z5)
          result.limbs.insert(zeros, 0)
          result.udadd(z4)
          result.limbs.insert(zeros, 0)
          result.udadd(z3)
          result.limbs.insert(zeros, 0)
          result.udadd(z2)
          result.limbs.insert(zeros, 0)
          result.udadd(z1)
          result.limbs.insert(zeros, 0)
          result.udadd(z0)
          result.sign = true
  
  # Multiplication. Used algorithms are changed with limbs length.
  # Karatsuba and Toom Cook multiplication are slow when the sizes of two operands are different, 
  # so filling zeros to smaller value.
  proc `*` *(x, y: BigInt): BigInt =
      ## Returns the product of two BigInts.
      var 
          m: int = len(x.limbs)
          n: int = len(y.limbs)
      if n > m:
          result = y * x
      elif x == y:
          if n < KARATSUBA_THRESHOLD:
              result = x.schoolbookSqr()
          elif n < TOOM3_THRESHOLD:
              result = x.karatsubaSqr()
          elif n < TOOM4_THRESHOLD:
              result = x.toom3Sqr()
          elif n < TOOM6H_THRESHOLD * 50:
              result = x.toom4Sqr()
          else:
              result = x.toom6hSqr()
      else:
          if n < KARATSUBA_THRESHOLD:
              result = x.schoolbookMul(y)
          elif n < TOOM3_THRESHOLD:
              result = x.karatsubaMul(y)
          elif n < TOOM4_THRESHOLD:
              result = x.toom3Mul(y)
          elif n < TOOM6H_THRESHOLD:
              result = x.toom4hMul(y)
          else:
              result = x.toom6hMul(y)
              
  proc `*` *(x: BigInt, y: SomeInteger): BigInt =
      ## Returns the product of a BigInt and an integer.
      result = x * newBigInt(y)
  
  proc `*` *(x: SomeInteger, y: BigInt): BigInt =
      ## Returns the product of an integer and a BigInt.
      result = newBigInt(x) * y
  
  proc `+=` *[T: SomeInteger|BigInt](x: var BigInt, y: T) =
      ## x is overwritten by x + y.
      x = x + y
  
  proc `-=` *[T: SomeInteger|BigInt](x: var BigInt, y: T) =
      ## x is overwritten by x - y.
      x = x - y
  
  proc `*=` *[T: SomeInteger|BigInt](x: var BigInt, y: T) =
      ## x is overwritten by x * y.
      x = x * y
  
  proc `^` *(x: BigInt, y: SomeInteger): BigInt =
      ## Returns x to the yth power.
      var
          t: BigInt
          s: string
          m: int 
      if y < 0:
          if abs(x) > newBigInt(1):
              result = zero
          elif abs(x) == newBigInt(1):
              result = x
          elif x == zero:
              raise newException(ValueError, "Division by zero.")
      elif y == 0:
          result = newBigInt(1)
      elif y == 1:
          result = x
      else:
          s = y.toBin(64)
          while ($s[0] == "0") and (len(s) > 1):
              s.compatibleDelete(0,0)
          m = len(s)
          s.compatibleDelete(m,m)
          m = len(s)
          t = x
          result = newBigInt(1)
          for i in countdown(m-1, 0):
              if $s[i] == "1":
                  result *= t
              t *= t
  
  proc `^` *(x, y: BigInt): BigInt =
      ## Returns x to the yth power.
      if abs(y) > newBigInt("9223372036854775807"):
          raise newException(ValueError, "Exponent too large.")
      result = x^(($y).parseBiggestInt)
  
  iterator `..` *(x, y: BigInt): BigInt =
      var t = x
      while t <= y:
          yield t
          t += 1
  
  iterator `..<` *(x, y: BigInt): BigInt =
      var t = x
      while t < y:
          yield t
          t += 1
  
  iterator countup*(x, y: BigInt, step: int = 1): BigInt =
      var t = x
      while t <= y:
          yield t
          t += step
  
  iterator countdown*(x, y: BigInt, step: int = 1): BigInt =
      var t = x
      while t >= y:
          yield t
          t -= step
  
  # BigFloat implementation
  
  proc setPrec*(prec: int) = 
      ## Set precision of BigFloat.
      bfContext.prec = prec
  
  proc getPrec*(): int =
      ## Get current precision of BigFloat.
      result = bfContext.prec
  
  proc truncate(x: BigFloat): BigFloat =
      var 
          m: int = (getPrec().toFloat / LOG_BASE.toFloat).ceil.toInt + 2
          n: int = len(x.intPart.limbs) - m 
      result = new BigFloat
      result.intPart = BigInt(sign: x.intPart.sign, limbs: x.intPart.limbs[max(0, n)..^1])
      result.exp = x.exp
  
  proc truncateInPlace(x: var BigFloat) = 
      var 
          m: int = (getPrec().toFloat / LOG_BASE.toFloat).ceil.toInt + 2
          n: int = len(x.intPart.limbs) - m
      if n > 0:
          x.intPart = BigInt(sign: x.intPart.sign, limbs: x.intPart.limbs[n..^1])
  
  proc truncateForString(x: BigFloat): BigFloat =
      var 
          m: int = (getPrec().toFloat / LOG_BASE.toFloat).ceil.toInt + 1
          n: int = len(x.intPart.limbs) - m 
      result = new BigFloat
      result.intPart = BigInt(sign: x.intPart.sign, limbs: x.intPart.limbs[max(0, n)..^1])
      result.exp = x.exp
  
  proc newBigFloat*(s: string, checkInput: bool = true): BigFloat =
      ## Constructs a new BigFloat object from a string.
      var
          s2: string
          resultSign: bool
          count: int = 1
          m: int
      if checkInput:
          var countPoints: int = 0
          var s3: string = s[0..^1]
          if ($s3[0] == "+") or ($s3[0] == "-"):
              s3.compatibleDelete(0,0)
          for i in (0..<len(s3)):
              if $s3[i] == "+":
                  raise newException(ValueError, "Invalid character(s) in input string: '" & $s3[i]  & "'.")
              elif $s3[i] == "-":
                  raise newException(ValueError, "Invalid character(s) in input string: '" & $s3[i]  & "'.")
              elif not ($s3[i] in validCharsForBigFloat):
                  raise newException(ValueError, "Invalid character(s) in input string: '" & $s3[i]  & "'.")
              elif $s3[i] == ".":
                  countPoints += 1
          if countPoints > 1:
              raise newException(ValueError, "Input string includes multiple '.'.")
      result = new BigFloat
      if $s[0] == "-":
          s2 = s[1..^1]
          resultSign = false
      else:
          s2 = s[0..^1]
          resultSign = true
      if "." in s2:
          if $s2[0] == "0":
              s2 = s2[2..^1]
              while ($s2[0] == "0") and (len(s2) > 1):
                  s2 = s2[1..^1]
                  count += 1
              result.exp = -count
              result.intPart = newBigIntNoCheck(s2)
              result.intPart.sign = resultSign
              result = result.truncate()
          else:
              m = s2.find(".")
              s2.compatibleDelete(m,m)
              result.exp = m - 1
              result.intPart = newBigIntNoCheck(s2)
              result.intPart.sign = resultSign
              result = result.truncate()
      else:
          result.exp = len(s2) - 1
          result.intPart = newBigIntNoCheck(s2)
          result.intPart.sign = resultSign
          result = result.truncate()
  
  proc newBigFloat*(a: BigInt): BigFloat =
      ## Constructs a new BigFloat object from a BigInt.
      result = new BigFloat
      result.intPart = a.clone()
      result.exp = LOG_BASE * (len(result.intPart.limbs) - 1) + len($result.intPart.limbs[^1]) - 1
      result = result.truncate()
  
  proc newBigFloat*(a: SomeInteger): BigFloat =
      ## Constructs a new BigFloat object from an integer.
      result = newBigFloat(newBigInt(a))
  
  proc toStr(x: BigFloat): string = 
      var
          s: string
          s2: string
          m: int
          x2: BigFloat = x.truncateForString()
      if x2.intPart == zero:
          result = "0"
      else:
          s = x2.intPart.abs().toStr()
          m = len(s)
          if x2.exp >= 0:
              if m > x2.exp + 1:
                  s2 = s[0..x2.exp]
                  s2.add(".")
                  s2.add($s[(x2.exp+1)..^1])
                  s = s2
              elif m < x2.exp + 1:
                  s2 = $s[0]
                  s2.add(".")
                  s2.add($s[1..^1])
                  if $s2[^1] == ".":
                      s2.add("0")
                  s2.add("e")
                  s2.add($x2.exp)
                  s = s2
          else:
              if x2.exp >= -10:
                  s2 = "0."
                  s2.add("0".repeat(x2.exp.abs() - 1))
                  s2.add(s)
                  s = s2
              else:
                  s2 = $s[0]
                  s2.add(".")
                  s2.add($s[1..^1])
                  if $s2[^1] == ".":
                      s2.add("0")
                  s2.add("e")
                  s2.add($x2.exp)
                  s = s2
          if x2.intPart.sign:
              result = s
          else:
              result = "-"
              result.add(s)
  
  proc `$` *(x: BigFloat): string =
      ## Converts a BigFloat to a string.
      result = x.toStr()
  
  proc clone(x: BigFloat): BigFloat =
      result = new BigFloat
      result.intPart = x.intPart.clone()
      result.exp = x.exp
  
  proc `-` *(x: BigFloat): BigFloat =
      ## Negates a BigFloat.
      result = new BigFloat
      if x.intPart == zero:
          result = x.clone()
      else:
          result = x.clone()
          result.intPart.sign = not x.intPart.sign
  
  proc abs*(x: BigFloat): BigFloat = 
      ## Absolute value of a BigFloat.
      result = x.clone()
      result.intPart.sign = true
  
  proc `+` *(x, y: BigFloat): BigFloat =
      ## Returns the sum of two BigFloats.
      if x.intPart == zero:
          result = y.clone()
      elif y.intPart == zero:
          result = x.clone()
      elif y.exp > x.exp:
          result = y + x
      else:
          var
              a: int
              b: int
              x2: BigInt
              y2: BigInt
              tmp: string
              zeros: seq[int64]
              xLimbsLength: int
              resultLimbsLength: int
          if x.exp - y.exp > getPrec():
              result = x.clone()
          else:
              a = x.exp - LOG_BASE * (len(x.intPart.limbs) - 1) - len($(x.intPart.limbs[^1])) + 1
              b = y.exp - LOG_BASE * (len(y.intPart.limbs) - 1) - len($(y.intPart.limbs[^1])) + 1
              result = new BigFloat
              if a == b:
                  result.intPart = x.intPart + y.intPart
                  result.exp = x.exp
                  xLimbsLength = LOG_BASE * (len(x.intPart.limbs) - 1) + len($(x.intPart.limbs[^1]))
                  resultLimbsLength = LOG_BASE * (len(result.intPart.limbs) - 1) + len($(result.intPart.limbs[^1]))
                  if resultLimbsLength != xLimbsLength:
                      result.exp += resultLimbsLength - xLimbsLength
              elif a > b:
                  x2 = BigInt(sign: x.intPart.sign, limbs: x.intPart.limbs[0..^1])
                  tmp = "1"
                  tmp.add("0".repeat((a - b) mod LOG_BASE))
                  x2 = x2 * newBigIntNoCheck(tmp)
                  zeros = repeat(0'i64,((a - b) div LOG_BASE))
                  x2.limbs.insert(zeros, 0)
                  result.intPart = x2 + y.intPart
                  result.exp = x.exp
                  xLimbsLength = LOG_BASE * (len(x2.limbs) - 1) + len($(x2.limbs[^1]))
                  resultLimbsLength = LOG_BASE * (len(result.intPart.limbs) - 1) + len($(result.intPart.limbs[^1]))
                  if resultLimbsLength != xLimbsLength:
                      result.exp += resultLimbsLength - xLimbsLength
              else:
                  y2 = BigInt(sign: y.intPart.sign, limbs: y.intPart.limbs[0..^1])
                  tmp = "1"
                  tmp.add("0".repeat((b - a) mod LOG_BASE))
                  y2 = y2 * newBigIntNoCheck(tmp)
                  zeros = repeat(0'i64,((b - a) div LOG_BASE))
                  y2.limbs.insert(zeros, 0)
                  result.intPart = x.intPart + y2
                  result.exp = x.exp
                  xLimbsLength = LOG_BASE * (len(x.intPart.limbs) - 1) + len($(x.intPart.limbs[^1]))
                  resultLimbsLength = LOG_BASE * (len(result.intPart.limbs) - 1) + len($(result.intPart.limbs[^1]))
                  if resultLimbsLength != xLimbsLength:
                      result.exp += resultLimbsLength - xLimbsLength
              result.truncateInPlace()
              
  proc `+` *[T: SomeInteger|BigInt](x: BigFloat, y: T): BigFloat =
      ## Returns the sum of a BigFloat and a BigInt or an integer.
      result = x + newBigFloat(y)
  
  proc `+` *[T: SomeInteger|BigInt](x: T, y: BigFloat): BigFloat =
      ## Returns the sum of a BigInt or an integer and a BigFloat.
      result = newBigFloat(x) + y
  
  proc `-` *(x, y: BigFloat): BigFloat =
      ## Returns the difference of two BigFloat.
      result = x + (-y)
  
  proc `-` *[T: SomeInteger|BigInt](x: BigFloat, y: T): BigFloat =
      ## Returns the difference of a BigFloat and a BigInt or an integer.
      result = x - newBigFloat(y)
  
  proc `-` *[T: SomeInteger|BigInt](x: T, y: BigFloat): BigFloat =
      ## Returns the difference of a BigInt or an integer and a BigFloat.
      result = newBigFloat(x) - y
  
  proc `*` *(x, y: BigFloat): BigFloat =
      ## Returns the product of two BigFloats.
      result = new BigFloat
      if y.exp > x.exp:
          result = y * x
      elif (x.intPart == zero) or (y.intPart == zero):
          result.intPart = newBigInt(0)
          result.exp = 0
      else:
          var
              xLimbsLength: int = LOG_BASE * (len(x.intPart.limbs) - 1) + len($(x.intPart.limbs[^1]))
              yLimbsLength: int = LOG_BASE * (len(y.intPart.limbs) - 1) + len($(y.intPart.limbs[^1]))
              resultLimbsLength: int 
          result.intPart = x.intPart * y.intPart
          result.exp = x.exp + y.exp
          resultLimbsLength = LOG_BASE * (len(result.intPart.limbs) - 1) + len($(result.intPart.limbs[^1]))
          result.exp += resultLimbsLength - xLimbsLength - yLimbsLength + 1
          result.truncateInPlace()
  
  proc `*` *[T: SomeInteger|BigInt](x: BigFloat, y: T): BigFloat =
      ## Returns the product of a BigFloat and a BigInt or an integer.
      result = x * newBigFloat(y)
  
  proc `*` *[T: SomeInteger|BigInt](x: T, y: BigFloat): BigFloat =
      ## Returns the product of a BigInt or an integer and a BigFloat.
      result = newBigFloat(x) * y
  
  proc `>` *(x, y: BigFloat): bool = 
      return (x - y).intPart > zero
  
  proc `>=` *(x, y: BigFloat): bool = 
      return (x - y).intPart >= zero
  
  proc `==` *(x, y: BigFloat): bool = 
      return (x - y).intPart == zero
  
  proc `<=` *(x, y: BigFloat): bool = 
      return (x - y).intPart <= zero
  
  proc `<` *(x, y: BigFloat): bool = 
      return (x - y).intPart < zero
  
  proc max*(x, y: BigFloat): BigFloat =
      if x >= y:
          result = x.clone()
      else:
          result = y.clone()
  
  proc min*(x, y: BigFloat): BigFloat =
      if x < y:
          result = x.clone()
      else:
          result = y.clone()
  
  # Inverse of x by Newton-Raphson method. Used for division.
  proc inv(x: BigFloat): BigFloat =
      var 
          y: BigFloat
          ystring: string
          yfloat: float 
          one: BigFloat
          two: BigFloat
          x2: BigFloat
          t: int = (getPrec() * 53) div 100
          precList: seq[int] = @[t]
          precOrig: int = getPrec()
      while t >= 16:
          t = t div 2
          precList.add(t)
      precList.reverse
      setPrec(16)
      y = x.truncate()
      ystring = $y.intPart
      if len(ystring) > 10:
          ystring = ystring[0..9]
      yfloat = ystring.parseFloat()
      result = newBigFloat((1 / yfloat).formatFloat(format = ffDecimal, precision = 10))
      result.exp -= x.exp - len(ystring) + 1
      if $ystring[0] == "-":
          result.exp -= 1
      x2 = x.truncate()
      result.truncateInPlace()
      one = newBigFloat("1")
      two = newBigFloat("2")
      for i in 0..3:
          result = result + result * (one - x2 * result)
      for i in 0..(len(precList) - 1):
          t = precList[i] + 16
          setPrec(t)
          result = result + result * (one - x.truncate() * result)
      setPrec(precOrig + 16)
      result = result + result * (one - x * result)
      setPrec(precOrig)
      result.truncateInPlace()
  
  proc `/` *(x, y: BigFloat): BigFloat =
      ## x divided by y.
      if y.intPart == zero:
          raise newException(ValueError, "Division by zero.")
      result = x * (y.inv())
  
  proc `/` *[T:SomeInteger|BigInt](x: BigFloat, y: T): BigFloat =
      ## x divided by y.
      result = x / newBigFloat(y)
  
  proc `/` *[T:SomeInteger|BigInt](x: T, y: BigFloat): BigFloat =
      ## x divided by y.
      result = newBigFloat(x) / y
  
  proc `+=` *[T: BigFloat|BigInt|SomeInteger](x: var BigFloat, y: T) = 
      ## x is overwritten by x + y
      x = x + y
  
  proc `-=` *[T: BigFloat|BigInt|SomeInteger](x: var BigFloat, y: T) = 
      ## x is overwritten by x - y
      x = x - y
  
  proc `*=` *[T: BigFloat|BigInt|SomeInteger](x: var BigFloat, y: T) = 
      ## x is overwritten by x * y
      x = x * y
  
  proc `/=` *[T: BigFloat|BigInt|SomeInteger](x: var BigFloat, y: T) = 
      ## x is overwritten by x / y
      x = x / y
  
  # Square root of x by Newton-raphson method.
  proc sqrt*(x: BigFloat): BigFloat = 
      ## Square root of a BigFloat.
      var 
          y: BigFloat
          one: BigFloat
          half: BigFloat
          t: int = (getPrec() * 53) div 100
          precList: seq[int] = @[t]
          precOrig: int = getPrec()
      if not x.intPart.sign:
          raise newException(ValueError, "Negative value for sqrt is not supported.")
      while t >= 16:
          t = t div 2
          precList.add(t)
      precList.reverse
      setPrec(16)
      y = x.truncate()
      one = newBigFloat("1")
      half = newBigFloat("0.5")
      result = newBigFloat("1")
      result.exp += y.exp div 2
      for i in 0..12:
          result = (result * half) + (y * half * result.inv())
      result = result.inv()
      for i in 0..(len(precList) - 1):
          t = precList[i] + 16
          setPrec(t)
          result = result + (result * ((one - (x.truncate() * (result * result))) * half))
      setPrec(precOrig + 16)
      result = result + (result * (((one - (x * (result * result))).truncate()) * half))
      result = result * x
      setPrec(precOrig)
      result.truncateInPlace()
  
  proc sqrt*(x: BigInt): BigFloat =
      ## Returns square root of a BigInt as a BigFloat.
      result = newBigFloat(x).sqrt()
  
  proc `^` *(x: BigFloat, y: SomeInteger): BigFloat =
      ## Returns x to the yth power. Real number exponent is not supported. 
      if y < 0:
          if x.intPart == zero:
              raise newException(ValueError, "Division by zero.")
          else:
              result = (x^abs(y)).inv()
      elif y == 0:
          result = BigFloat(intPart: newBigInt(1), exp: 0)
      elif y == 1:
          result = x.clone()
      else:
          var
              s: string
              m: int
              t: BigFloat
          s = y.toBin(64)
          while ($s[0] == "0") and (len(s) > 1):
              s.compatibleDelete(0,0)
          m = len(s)
          s.compatibleDelete(m,m)
          m = len(s)
          t = x
          result = newBigFloat("1")
          for i in countdown(m-1, 0):
              if $s[i] == "1":
                  result *= t
              t *= t
  
  proc `^` *(x: BigFloat, y: BigInt): BigFloat =
      ## Returns x to the yth power. Real number exponent is not supported. 
      if abs(y) > newBigInt("9223372036854775807"):
          raise newException(ValueError, "Exponent too large.")
      result = x^(($y).parseBiggestInt)
  
  # BigInt division depends on BigFloat division, so implemented here.
  proc `div` *(x, y: BigInt): BigInt =
      ## Returns the quotient of x by y.
      if x == zero:
          return zero.clone()
      else:
          var
              x2: BigInt = x.abs()
              y2: BigInt = y.abs()
          if x2 < y2:
              return zero.clone()
          elif x2 == y2:
              if x.sign == y.sign:
                  result = newBigIntNoCheck("1")
              else:
                  result = newBigIntNoCheck("-1")
          else:
              var 
                  xfloat: BigFloat
                  yfloat: BigFloat
                  zfloat: BigFloat
                  zstring: string
                  m: int = 2 * (16 * len(x.limbs) + 16)
                  precOrig: int = getPrec()
                  n: int
              setPrec(m)
              xfloat = newBigFloat(x2)
              yfloat = newBigFloat(y2)
              zfloat = xfloat / yfloat
              zstring = $zfloat
              n = zstring.find(".") - 1
              setPrec(precOrig)
              result = newBigIntNoCheck(zstring[0..n]) + newBigInt("1")
              if x < result * y:
                  result = result - newBigInt("1")
              if x.sign != y.sign:
                  result.sign = false
  
  proc `div` *(x: BigInt, y: SomeInteger): BigInt =
      ## Returns the quotient of x by y.
      result = x div newBigInt(y)
  
  proc `div` *(x: SomeInteger, y: BigInt): BigInt =
      ## Returns the quotient of x by y.
      result = newBigInt(x) div y
  
  proc `mod` *(x, y: BigInt): BigInt =
      ## Returns the remainder of x by y.
      result = x - y * (x div y)
  
  proc `mod` *(x: BigInt, y: SomeInteger): BigInt =
      ## Returns the remainder of x by y.
      result = x mod newBigInt(y)
  
  proc `mod` *(x: SomeInteger, y: BigInt): BigInt =
      ## Returns the remainder of x by y.
      result = newBigInt(x) mod y
  
  proc divmod*(x, y: BigInt): seq[BigInt] = 
      ## Returns the seq @[x div y, x mod y]
      var t: BigInt 
      t = x div y
      result = @[t, x - y * t]
  
  proc divmod*(x: BigInt, y: SomeInteger): seq[BigInt] =
      ## Returns the seq @[x div y, x mod y]
      result = x.divmod(newBigInt(y))
  
  proc divmod*(x: SomeInteger, y: BigInt): seq[BigInt] =
      ## Returns the seq @[x div y, x mod y]
      result = newBigInt(x).divmod(y)
