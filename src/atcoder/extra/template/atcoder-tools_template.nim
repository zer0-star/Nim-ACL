import macros
macro Please(x): untyped = nnkStmtList.newTree()

Please use Nim-ACL 
Please use Nim-ACL
Please use Nim-ACL

const
  DO_CHECK = true
  DEBUG = true
  DO_TEST = false
  USE_DEFAULT_TABLE = true

include lib/header/chaemon_header

{% if yes_str %}
const YES = "{{ yes_str }}"
{% endif %}
{% if no_str %}
const NO = "{{ no_str }}"
{% endif %}
{% if mod %}
import atcoder/modint
const MOD = {{ mod }}
type mint = modint{{ mod }}
{% endif %}

{% if prediction_success %}
solveProc solve({{formal_arguments}}):
  discard

when not DO_TEST:
  {{input_part_with_solve_function}}
else:
  discard
{% else %}
# Failed to predict input format
solveProc solve():
  discard

when not DO_TEST:
  solve()
else:
  discard
{% endif %}
