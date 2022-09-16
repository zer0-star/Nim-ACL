when defined SecondCompile:
  const DO_CHECK = false;const DEBUG = false
else:
  const DO_CHECK = true;const DEBUG = true
const
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

when not defined(DO_TEST):
  {{input_part}}
  solve({{actual_arguments}})
else:
  discard
{% else %}
# Failed to predict input format
solveProc solve():
  discard

when not defined(DO_TEST):
  solve()
else:
  discard
{% endif %}
