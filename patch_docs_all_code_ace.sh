#!/usr/bin/env bash
set -euo pipefail

if [ ! -f tools/generate_document.py ] || [ ! -f tools/template.html ]; then
  echo "error: please run from Nim-ACL repository root"
  exit 1
fi

python - <<'PY'
from pathlib import Path
import re

path = Path("tools/generate_document.py")
s = path.read_text(encoding="utf-8")

# Add convert_code_blocks_to_ace() before render_markdown().
if "def convert_code_blocks_to_ace" not in s:
    marker = "\n\ndef render_markdown(text: str) -> str:\n"
    insert = r'''

def convert_code_blocks_to_ace(body: str) -> str:
    """Convert Markdown-generated block code to Ace-powered Nim code blocks.

    Python-Markdown emits:
      <pre><code>...</code></pre>
      <pre><code class="language-nim">...</code></pre>

    We convert those blocks to:
      <div class="sample-code">...</div>

    Inline <code>...</code> is intentionally left unchanged.
    """
    def repl(m: re.Match[str]) -> str:
        code = m.group(1)
        return f'<div class="sample-code">{code}</div>'

    body = re.sub(
        r'<pre><code(?: class="[^"]*")?>(.*?)</code></pre>',
        repl,
        body,
        flags=re.S | re.I,
    )
    return body
'''
    s = s.replace(marker, insert + marker)

# Make render_markdown call convert_code_blocks_to_ace().
old = """    body = markdown.markdown(
        text,
        extensions=[
            "fenced_code",
            "tables",
            "toc",
            "sane_lists",
        ],
        output_format="html5",
    )
    return rewrite_markdown_links(body)
"""

new = """    body = markdown.markdown(
        text,
        extensions=[
            "fenced_code",
            "tables",
            "toc",
            "sane_lists",
        ],
        output_format="html5",
    )
    body = rewrite_markdown_links(body)
    body = convert_code_blocks_to_ace(body)
    return body
"""

if old in s:
    s = s.replace(old, new)
elif "convert_code_blocks_to_ace(body)" not in s:
    raise SystemExit("could not patch render_markdown; please inspect tools/generate_document.py")

# Make render_example return the same sample-code format. This may already be done.
s = re.sub(
    r'def render_example\(name: str, lang: str\) -> str:.*?\n\n(?=def replace_placeholders)',
    r'''def render_example(name: str, lang: str) -> str:
    """Render @{example.foo} as an Ace-powered Nim code block."""
    file_key = name.split(":", 1)[0].strip()

    path = find_example_file(file_key)
    if path is None:
        label = "使用例が見つかりません" if lang == "ja" else "Example not found"
        escaped = html.escape(name)
        return f'<div class="warning">{label}: <code>{escaped}</code></div>'

    code = path.read_text(encoding="utf-8")
    code = strip_example_metadata(code)

    escaped_code = html.escape(code)
    return f'<div class="sample-code">{escaped_code}</div>'
''',
    s,
    flags=re.S,
)

path.write_text(s, encoding="utf-8")
PY

# Replace the Ace CSS block with a more official-AC-Library-like look.
cat >> document_ja/lib/main.css <<'CSS'

/* Ace code blocks, aligned with AC Library docs */

.sample-code {
  width: 100%;
  margin: 1em 0;
  border: 1px solid #e5e5e5;
  background: #ffffff;
  font-size: 14px;
  line-height: 1.45;
}

.sample-code .ace_gutter {
  background: #f2f2f2;
  color: #777;
  border-right: 1px solid #e5e5e5;
}

.sample-code .ace_content {
  background: #ffffff;
}

.sample-code .ace_marker-layer .ace_active-line,
.sample-code .ace_gutter-active-line {
  background: transparent;
}

.sample-code .ace_print-margin {
  display: none;
}

.sample-code .ace_cursor {
  display: none !important;
}
CSS

cp document_ja/lib/main.css document_en/lib/main.css

echo "done."
echo
echo "Next:"
echo "  source .venv/bin/activate"
echo "  python tools/generate_document.py"
