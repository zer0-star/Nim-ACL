#!/usr/bin/env bash
set -euo pipefail

if [ ! -f tools/generate_document.py ] || [ ! -f tools/template.html ]; then
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

cat > tools/generate_document.py <<'PY'
#!/usr/bin/env python3
from __future__ import annotations

from pathlib import Path
import html
import os
import re
import sys
import tomllib


TOOL_DIR = Path(__file__).resolve().parent
ROOT = TOOL_DIR.parent
EXAMPLE_DIR = ROOT / "test" / "example"


def rel_link(from_path: Path, to_path: Path) -> str:
    return os.path.relpath(to_path, from_path.parent).replace(os.sep, "/")


def flatten_toml(data: dict, prefix: str = "") -> dict[str, str]:
    result: dict[str, str] = {}

    for key, value in data.items():
        full_key = f"{prefix}.{key}" if prefix else key
        if isinstance(value, dict):
            result.update(flatten_toml(value, full_key))
        else:
            result[full_key] = str(value)

    return result


def load_keywords(doc_dir: Path) -> dict[str, str]:
    path = doc_dir / "keywords.toml"
    if not path.exists():
        return {}

    with path.open("rb") as f:
        data = tomllib.load(f)

    keywords = flatten_toml(data)

    for key, value in list(keywords.items()):
        keywords.setdefault(key.split(".")[-1], value)

    return keywords


def default_keyword_replacements(lang: str) -> dict[str, str]:
    if lang == "ja":
        return {
            "keyword.constraints": '<h4 class="doc-keyword">制約</h4>',
            "keyword.complexity": '<h4 class="doc-keyword">計算量</h4>',
        }

    return {
        "keyword.constraints": '<h4 class="doc-keyword">Constraints</h4>',
        "keyword.complexity": '<h4 class="doc-keyword">Complexity</h4>',
    }


def find_example_file(name: str) -> Path | None:
    key = name.strip()
    key_under = key.replace(".", "_")

    candidates = [
        EXAMPLE_DIR / f"example_{key}.nim",
        EXAMPLE_DIR / f"{key}.nim",
        EXAMPLE_DIR / f"{key_under}.nim",
        EXAMPLE_DIR / f"example_{key_under}.nim",
    ]

    for path in candidates:
        if path.exists():
            return path

    if EXAMPLE_DIR.exists():
        for path in sorted(EXAMPLE_DIR.rglob("*.nim")):
            stem = path.stem
            if stem in {key, f"example_{key}", key_under, f"example_{key_under}"}:
                return path

    return None


def strip_example_metadata(text: str) -> str:
    text = re.sub(r'^\s*#\s*verification-helper:.*?\n', '', text, flags=re.M)
    text = re.sub(r'^\s*discard\s+""".*?"""\s*\n', '', text, flags=re.S)
    return text.strip("\n")


def render_example(name: str, lang: str) -> str:
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


def replace_placeholders(text: str, keywords: dict[str, str], lang: str) -> str:
    fixed = default_keyword_replacements(lang)

    def repl(m: re.Match[str]) -> str:
        key = m.group(1).strip()

        if key.startswith("example."):
            return render_example(key[len("example."):], lang)

        if key in fixed:
            return fixed[key]

        if key in keywords:
            return keywords[key]

        short_key = key.split(".")[-1]
        if short_key in keywords:
            return keywords[short_key]

        return m.group(0)

    return re.sub(r"@\{([^}]+)\}", repl, text)


def title_from_markdown(text: str) -> str:
    for line in text.splitlines():
        if line.startswith("# "):
            return line[2:].strip()
    return "Nim-ACL"


def rewrite_markdown_links(body: str) -> str:
    return re.sub(
        r'href="([^"]+)\.md(#.*?)?"',
        lambda m: f'href="{m.group(1)}.html{m.group(2) or ""}"',
        body,
    )


def convert_code_blocks_to_ace(body: str) -> str:
    """Convert Markdown-generated block code to Ace-powered Nim blocks.

    Inline <code>...</code> is intentionally left unchanged.
    """
    def repl(m: re.Match[str]) -> str:
        code = m.group(1)
        return f'<div class="sample-code">{code}</div>'

    return re.sub(
        r'<pre><code(?: class="[^"]*")?>(.*?)</code></pre>',
        repl,
        body,
        flags=re.S | re.I,
    )


def render_markdown(text: str) -> str:
    try:
        import markdown
    except ModuleNotFoundError:
        print(
            "error: Python package 'markdown' is required.\n"
            "Install it in a virtual environment:\n"
            "  python3 -m venv .venv\n"
            "  source .venv/bin/activate\n"
            "  python -m pip install -r tools/requirements.txt\n"
            "  python tools/generate_document.py",
            file=sys.stderr,
        )
        raise

    body = markdown.markdown(
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


def render_page(
    template: str,
    *,
    lang: str,
    title: str,
    css_path: str,
    index_path: str,
    logo_path: str,
    body: str,
) -> str:
    return (
        template
        .replace("@{lang}", lang)
        .replace("@{title}", html.escape(title))
        .replace("@{css_path}", css_path)
        .replace("@{index_path}", index_path)
        .replace("@{logo_path}", logo_path)
        .replace("@{body}", body)
    )


def convert_one(
    md_path: Path,
    doc_dir: Path,
    lang: str,
    template: str,
    keywords: dict[str, str],
) -> Path:
    raw = md_path.read_text(encoding="utf-8")
    raw = replace_placeholders(raw, keywords, lang)

    title = title_from_markdown(raw)
    body = render_markdown(raw)

    html_path = md_path.with_suffix(".html")

    css_path = rel_link(html_path, doc_dir / "lib" / "main.css")
    index_path = rel_link(html_path, doc_dir / "index.html")
    logo_path = rel_link(html_path, doc_dir / "lib" / "logo-crown.png")

    page = render_page(
        template,
        lang=lang,
        title=title,
        css_path=css_path,
        index_path=index_path,
        logo_path=logo_path,
        body=body,
    )

    html_path.write_text(page, encoding="utf-8")
    return html_path


def convert_doc_dir(dirname: str, lang: str, template: str) -> int:
    doc_dir = ROOT / dirname
    if not doc_dir.exists():
        print(f"skip: {dirname} does not exist")
        return 0

    keywords = load_keywords(doc_dir)

    count = 0
    for md_path in sorted(doc_dir.rglob("*.md")):
        rel_parts = md_path.relative_to(doc_dir).parts
        if "lib" in rel_parts:
            continue

        html_path = convert_one(md_path, doc_dir, lang, template, keywords)
        print(f"write: {html_path.relative_to(ROOT)}")
        count += 1

    print(f"{dirname}: {count} files")
    return count


def main() -> None:
    template_path = TOOL_DIR / "template.html"
    if not template_path.exists():
        raise FileNotFoundError(f"template not found: {template_path}")

    template = template_path.read_text(encoding="utf-8")

    total = 0
    total += convert_doc_dir("document_ja", "ja", template)
    total += convert_doc_dir("document_en", "en", template)

    print(f"total: {total} files")


if __name__ == "__main__":
    main()
PY

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
