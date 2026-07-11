# Berlekamp–Massey

Finds the shortest linear recurrence determined by a finite sequence prefix.

## API

```nim
proc berlekampMassey*[T](
    sequence: openArray[T],
): seq[T]
```

If the returned sequence is `coefficient`, each determined later term
satisfies

```text
sequence[n] =
  coefficient[0] * sequence[n - 1] +
  coefficient[1] * sequence[n - 2] +
  ...
```

Coefficients are ordered from the immediately preceding term backward.
For example, the Fibonacci sequence returns `@[1, 1]`.

## Example

```nim
import atcoder/modint
import atcoder/extra/math/berlekamp_massey

type mint = modint998244353

let sequence =
  @[
    mint.init(0),
    mint.init(1),
    mint.init(1),
    mint.init(2),
    mint.init(3),
    mint.init(5),
    mint.init(8),
  ]

let coefficient =
  berlekampMassey(sequence)

doAssert coefficient == @[
  mint.init(1),
  mint.init(1),
]
```

## Algebraic requirements

`T` must behave like a field and provide:

- `default(T)` as the additive identity
- `+`, `-`, `*`, `/`
- `==`, `!=`

A prime-modulus `modint` is the usual choice.

## Edge cases

- An empty sequence returns an empty recurrence.
- An all-zero sequence also returns an empty recurrence.
- A nonzero constant sequence returns `@[1]`.
- The result is the shortest relation determined by the supplied prefix.

## Complexity

For a sequence of length `n`:

- Time: `O(n^2)`
- Memory: `O(n)`

## Relationship with Kitamasa

`berlekampMassey` infers a recurrence from a sequence.
Use `kitamasa` when the recurrence is known and a distant term is needed.
