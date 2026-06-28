#!/usr/bin/env bash
set -euo pipefail

if [ ! -f tools/generate_document.py ] || [ ! -f tools/template.html ] || [ ! -f document_ja/lib/main.css ]; then
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

# Remove any previous convert_code_blocks_to_ace function.
s = re.sub(
    r'\n\ndef convert_code_blocks_to_ace\(body: str\) -> str:.*?\n\n(?=def render_markdown)',
    '\n\n',
    s,
    flags=re.S,
)

# Ensure render_markdown does NOT convert normal markdown code blocks to Ace.
s = re.sub(
    r'    body = rewrite_markdown_links\(body\)\n\s*body = convert_code_blocks_to_ace\(body\)\n\s*return body',
    '    body = rewrite_markdown_links(body)\n    return body',
    s,
)

# Ensure render_example alone emits Ace sample-code.
s = re.sub(
    r'def render_example\(name: str, lang: str\) -> str:.*?\n\n(?=def replace_placeholders)',
    r'''def render_example(name: str, lang: str) -> str:
    """Render @{example.foo} as an Ace-powered Nim code block with source URL."""
    file_key = name.split(":", 1)[0].strip()

    path = find_example_file(file_key)
    if path is None:
        label = "使用例が見つかりません" if lang == "ja" else "Example not found"
        escaped = html.escape(name)
        return f'<div class="warning">{label}: <code>{escaped}</code></div>'

    code = path.read_text(encoding="utf-8")
    code = strip_example_metadata(code)

    escaped_code = html.escape(code)

    url = example_url_for(file_key, path) if "example_url_for" in globals() else None
    if url:
        escaped_url = html.escape(url)
        caption = (
            f'<p class="example-caption">'
            f'AC code of <a href="{escaped_url}">{escaped_url}</a>'
            f'</p>\n'
        )
    else:
        caption = ""

    return f'{caption}<div class="sample-code">{escaped_code}</div>'
''',
    s,
    flags=re.S,
)

path.write_text(s, encoding="utf-8")
PY

# Append final overrides. These override older duplicated rules safely.
cat >> document_ja/lib/main.css <<'CSS'

/* Official AC Library-like code styling overrides */

/* Inline code only: pink/red, like official docs. */
p code,
li code,
td code,
dd code,
blockquote code {
  color: #e83e8c;
  background: #f8f8f8;
  padding: 0.15em 0.35em;
  border-radius: 3px;
}

/* Normal markdown code blocks: no line numbers, plain boxed block. */
pre {
  margin: 1em 0;
  padding: 0.65em 0.85em;
  border: 1px solid #e5e5e5;
  border-radius: 2px;
  background: #fff;
  overflow-x: auto;
}

pre code,
pre code.language-nim,
pre code.hljs {
  display: block;
  padding: 0;
  color: #333;
  background: transparent;
  font-size: 13px;
  line-height: 1.45;
}

/* Example caption, matching official 'AC code of ...'. */
.example-caption {
  margin: 1.2em 0 0.4em;
  font-size: 1.05rem;
}

.example-caption a {
  font-weight: 500;
}

/* Only @{example...} blocks use Ace and line numbers. */
.sample-code {
  width: 100%;
  margin: 0.75em 0 1.25em;
  border: 1px solid #e5e5e5;
  background: #fff;
  font-size: 13px;
  line-height: 1.45;
}

.sample-code .ace_gutter {
  background: #f2f2f2;
  color: #777;
  border-right: 1px solid #e5e5e5;
}

.sample-code .ace_content {
  background: #fff;
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
