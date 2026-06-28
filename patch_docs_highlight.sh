#!/usr/bin/env bash
set -euo pipefail

if [ ! -f tools/template.html ] || [ ! -f tools/generate_document.py ]; then
  echo "error: please run from Nim-ACL repository root"
  exit 1
fi

cat > tools/template.html <<'HTML'
<!DOCTYPE html>
<html lang="@{lang}">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>@{title}</title>
  <link rel="stylesheet" href="@{css_path}">

  <link rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/highlight.js@11.11.1/styles/github.min.css">
  <script defer
          src="https://cdn.jsdelivr.net/npm/highlight.js@11.11.1/lib/highlight.min.js"></script>
  <script defer
          src="https://cdn.jsdelivr.net/npm/highlight.js@11.11.1/lib/languages/nim.min.js"></script>
  <script>
    document.addEventListener("DOMContentLoaded", function () {
      if (window.hljs) {
        hljs.highlightAll();
      }
    });
  </script>

  <script>
    window.MathJax = {
      tex: {
        inlineMath: [['$', '$'], ['\\(', '\\)']],
        displayMath: [['$$', '$$'], ['\\[', '\\]']],
        processEscapes: true
      },
      svg: {
        fontCache: 'global'
      }
    };
  </script>
  <script defer src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-svg.js"></script>
</head>
<body>
  <header class="site-header">
    <a class="site-brand" href="@{index_path}">
      <img class="site-logo" src="@{logo_path}" alt="" aria-hidden="true">
      <span class="site-title">Nim-ACL</span>
    </a>
  </header>
  <main>
@{body}
  </main>
</body>
</html>
HTML

python3 - <<'PY'
from pathlib import Path

path = Path("tools/generate_document.py")
s = path.read_text(encoding="utf-8")

if "def ensure_code_block_language" not in s:
    marker = "\n\ndef rewrite_markdown_links(body: str) -> str:\n"
    insert = r'''

def ensure_code_block_language(body: str) -> str:
    """Ensure plain Markdown code blocks are highlighted as Nim.

    Python-Markdown emits <pre><code> for indented code blocks.
    highlight.js needs a language class. Nim-ACL docs are overwhelmingly
    Nim snippets, so we default unclassified code blocks to language-nim.
    Fenced blocks like ```nim already keep their class.
    """
    body = body.replace("<pre><code>", '<pre><code class="language-nim">')
    return body
'''
    s = s.replace(marker, insert + marker)

old = "    return rewrite_markdown_links(body)\n"
new = "    body = rewrite_markdown_links(body)\n    body = ensure_code_block_language(body)\n    return body\n"

if old in s:
    s = s.replace(old, new)
elif "ensure_code_block_language(body)" not in s:
    raise SystemExit("could not patch render_markdown return; please inspect tools/generate_document.py")

path.write_text(s, encoding="utf-8")
PY

cat >> document_ja/lib/main.css <<'CSS'

/* Syntax highlighting */

pre code.hljs,
pre code.language-nim {
  display: block;
  overflow-x: auto;
  padding: 0;
  background: transparent;
}

pre {
  background: #f6f8fa;
}

.hljs {
  background: transparent;
}
CSS

cp document_ja/lib/main.css document_en/lib/main.css

echo "done."
echo "Next:"
echo "  source .venv/bin/activate"
echo "  python tools/generate_document.py"
