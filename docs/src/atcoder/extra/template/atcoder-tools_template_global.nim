include atcoder/extra/header/chaemon_header

{% if mod %}
const MOD = {{ mod }}
{% endif %}
{% if yes_str %}
const YES = "{{ yes_str }}"
{% endif %}
{% if no_str %}
const NO = "{{ no_str }}"
{% endif %}
{% if prediction_success %}
{{ global_declaration }}
{% endif %}

const DEBUG = true

{% if prediction_success %}
{{"# input part {{{"}}
block:
  {{global_input_part}}
{{"#}}}"}}
{% else %}
# Failed to predict input format
{% endif %}

block main:
  # write code here
  
  break
