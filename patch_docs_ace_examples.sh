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

  <script src="https://cdn.jsdelivr.net/npm/ace-builds@1.37.5/src-min-noconflict/ace.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/ace-builds@1.37.5/src-min-noconflict/mode-nim.js"></script>
  <script>
    window.addEventListener("load", function () {
      if (!window.ace) return;

      ace.config.set(
        "basePath",
        "https://cdn.jsdelivr.net/npm/ace-builds@1.37.5/src-min-noconflict/"
      );

      for (const e of document.getElementsByClassName("sample-code")) {
        const code = e.textContent.replace(/^\n/, "").replace(/\s+$/, "");
        e.textContent = code;

        const editor = ace.edit(e);
        editor.setTheme("ace/theme/textmate");
        editor.getSession().setMode("ace/mode/nim");
        editor.getSession().setUseWrapMode(false);
        editor.setReadOnly(true);
        editor.setShowPrintMargin(false);
        editor.setHighlightActiveLine(false);
        editor.setHighlightGutterLine(false);
        editor.setOptions({
          maxLines: Infinity,
          minLines: 1,
          fontSize: "14px",
          tabSize: 2,
          useSoftTabs: true
        });

        editor.renderer.setShowGutter(true);
        editor.renderer.setScrollMargin(8, 8, 0, 0);

        const cursor = editor.renderer.$cursorLayer;
        if (cursor && cursor.element) {
          cursor.element.style.display = "none";
        }
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

python - <<'PY'
from pathlib import Path
import re

path = Path("tools/generate_document.py")
s = path.read_text(encoding="utf-8")

new_func = r'''def render_example(name: str, lang: str) -> str:
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
'''

s2 = re.sub(
    r'def render_example\(name: str, lang: str\) -> str:.*?\n\n(?=def replace_placeholders)',
    new_func + "\n\n",
    s,
    flags=re.S,
)

if s2 == s:
    raise SystemExit("could not replace render_example; please inspect tools/generate_document.py")

path.write_text(s2, encoding="utf-8")
PY

cat >> document_ja/lib/main.css <<'CSS'

/* Ace code samples, similar to official AC Library docs */

.sample-code {
  width: 100%;
  margin: 1em 0;
  border: 1px solid #e5e5e5;
  background: #f8f8f8;
  font-size: 14px;
  line-height: 1.45;
}

.sample-code .ace_gutter {
  background: #eeeeee;
  color: #777;
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
CSS

cp document_ja/lib/main.css document_en/lib/main.css

echo "done."
echo
echo "Next:"
echo "  source .venv/bin/activate"
echo "  python tools/generate_document.py"
