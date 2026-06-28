#!/usr/bin/env bash
set -euo pipefail

ROOT="$(pwd)"

if [ ! -d "$ROOT/tools" ] || [ ! -d "$ROOT/document_ja" ] || [ ! -d "$ROOT/document_en" ]; then
  echo "error: please run this script from the Nim-ACL repository root"
  exit 1
fi

mkdir -p document_ja/lib document_en/lib

cat > tools/template.html <<'HTML'
<!DOCTYPE html>
<html lang="@{lang}">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>@{title}</title>
  <link rel="stylesheet" href="@{css_path}">
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
    candidates = [
        EXAMPLE_DIR / f"example_{name}.nim",
        EXAMPLE_DIR / f"{name}.nim",
        EXAMPLE_DIR / f"{name.replace('.', '_')}.nim",
        EXAMPLE_DIR / f"example_{name.replace('.', '_')}.nim",
    ]

    for path in candidates:
        if path.exists():
            return path

    if EXAMPLE_DIR.exists():
        for path in sorted(EXAMPLE_DIR.rglob("*.nim")):
            stem = path.stem
            if stem == name or stem == f"example_{name}" or stem == name.replace(".", "_") or stem == f"example_{name.replace('.', '_')}":
                return path

    return None


def strip_example_metadata(text: str) -> str:
    """Remove common verification/doc metadata blocks from example source.

    This is conservative: if the file is ordinary Nim code, it is returned as-is.
    """
    text = re.sub(r'^\s*#\s*verification-helper:.*?\n', '', text, flags=re.M)

    # Remove leading testament-style discard """ ... """ block.
    text = re.sub(r'^\s*discard\s+""".*?"""\s*\n', '', text, flags=re.S)

    return text.strip("\n")


def render_example(name: str, lang: str) -> str:
    """Render @{example.foo} as a Markdown fenced code block."""
    # Support @{example.foo:bar} by using the part before ':' as filename.
    file_key = name.split(":", 1)[0].strip()

    path = find_example_file(file_key)
    if path is None:
        label = "使用例が見つかりません" if lang == "ja" else "Example not found"
        escaped = html.escape(name)
        return f'<div class="warning">{label}: <code>{escaped}</code></div>'

    code = path.read_text(encoding="utf-8")
    code = strip_example_metadata(code)

    # Markdown fenced code. This is passed to the markdown renderer later.
    return f"```nim\n{code}\n```"


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
    return rewrite_markdown_links(body)


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

cat > document_ja/lib/main.css <<'CSS'
:root {
  --text: #222;
  --muted: #666;
  --border: #ddd;
  --code-bg: #f6f8fa;
  --table-head-bg: #f2f2f2;
  --link: #0366d6;
  --header-bg: #171717;
  --header-border: #2a2a2a;
  --header-text: #f5f5f5;
}

html {
  font-size: 16px;
}

body {
  margin: 0;
  padding: 0;
  color: var(--text);
  font-family:
    -apple-system,
    BlinkMacSystemFont,
    "Segoe UI",
    "Helvetica Neue",
    Arial,
    "Noto Sans",
    "Noto Sans JP",
    sans-serif;
  line-height: 1.65;
  background: #fff;
}

.site-header {
  box-sizing: border-box;
  width: 100%;
  padding: 12px 28px;
  background: var(--header-bg);
  border-bottom: 1px solid var(--header-border);
}

.site-brand {
  display: inline-flex;
  align-items: center;
  gap: 12px;
  color: var(--header-text);
  text-decoration: none;
  font-size: 26px;
  font-weight: 600;
}

.site-brand:hover {
  color: #fff;
  text-decoration: none;
}

.site-logo {
  width: 38px;
  height: 38px;
  object-fit: contain;
  display: inline-block;
}

.site-title {
  line-height: 1;
  letter-spacing: 0.01em;
}

main {
  margin: 0;
  padding: 48px 56px 72px;
  max-width: none;
  box-sizing: border-box;
}

h1 {
  margin: 0 0 24px;
  padding-bottom: 0.3em;
  border-bottom: 1px solid var(--border);
  font-size: 2.45rem;
  font-weight: 400;
  line-height: 1.25;
}

h2 {
  margin-top: 2rem;
  padding-bottom: 0.2em;
  border-bottom: 1px solid var(--border);
  font-size: 1.75rem;
  font-weight: 400;
  line-height: 1.3;
}

h3 {
  margin-top: 1.5rem;
  font-size: 1.3rem;
  font-weight: 500;
  line-height: 1.35;
}

h4,
h5,
h6 {
  margin-top: 1.25rem;
  line-height: 1.35;
}

.doc-keyword {
  margin-top: 1.2rem;
  margin-bottom: 0.4rem;
  font-size: 1.05rem;
  font-weight: 600;
  border-bottom: none;
}

p {
  margin: 0.8em 0;
}

a {
  color: var(--link);
  text-decoration: none;
}

a:hover {
  text-decoration: underline;
}

ul,
ol {
  padding-left: 1.6em;
}

li {
  margin: 0.25em 0;
}

pre {
  overflow-x: auto;
  padding: 12px 14px;
  border-radius: 4px;
  background: var(--code-bg);
  line-height: 1.45;
}

code {
  padding: 0.15em 0.35em;
  border-radius: 3px;
  background: var(--code-bg);
  font-family:
    ui-monospace,
    SFMono-Regular,
    Consolas,
    "Liberation Mono",
    Menlo,
    monospace;
  font-size: 0.92em;
}

pre code {
  padding: 0;
  background: transparent;
  font-size: 0.95em;
}

table {
  width: 100%;
  border-collapse: collapse;
  margin: 1em 0;
}

th,
td {
  border: 1px solid var(--border);
  padding: 6px 10px;
  vertical-align: top;
}

th {
  background: var(--table-head-bg);
  font-weight: 600;
}

mjx-container[jax="SVG"][display="true"] {
  overflow-x: auto;
  overflow-y: hidden;
  max-width: 100%;
}

mjx-container {
  line-height: 1.2;
}

blockquote {
  margin: 1em 0;
  padding: 0.5em 1em;
  color: var(--muted);
  border-left: 4px solid var(--border);
  background: #fafafa;
}

hr {
  border: 0;
  border-top: 1px solid var(--border);
  margin: 2em 0;
}

img {
  max-width: 100%;
}

.nav {
  margin: 1em 0 2em;
  color: var(--muted);
}

.nav a {
  margin-right: 0.8em;
}

.warning {
  border-left: 4px solid #f0ad4e;
  background: #fff8e5;
  padding: 0.75em 1em;
}

.experimental {
  border-left: 4px solid #6f42c1;
  background: #f7f2ff;
  padding: 0.75em 1em;
}

@media (max-width: 640px) {
  .site-header {
    padding: 12px 16px;
  }

  .site-brand {
    font-size: 20px;
    gap: 10px;
  }

  .site-logo {
    width: 30px;
    height: 30px;
  }

  main {
    padding: 32px 18px 52px;
  }

  h1 {
    font-size: 1.8rem;
  }

  h2 {
    font-size: 1.4rem;
  }
}
CSS

cp document_ja/lib/main.css document_en/lib/main.css

if [ -f tools/requirements.txt ]; then
  if ! grep -qi '^Markdown\b' tools/requirements.txt; then
    printf '\nMarkdown\n' >> tools/requirements.txt
  fi
else
  printf 'Markdown\n' > tools/requirements.txt
fi

if [ ! -f document_ja/lib/logo-crown.png ]; then
  if command -v curl >/dev/null 2>&1; then
    if curl -fsSL -o document_ja/lib/logo-crown.png \
      https://raw.githubusercontent.com/nim-lang/assets/master/Art/logo-crown.png; then
      echo "downloaded logo-crown.png"
    else
      echo "warning: failed to download logo-crown.png"
      echo "Please place it manually at document_ja/lib/logo-crown.png"
    fi
  fi
fi

if [ -f document_ja/lib/logo-crown.png ]; then
  cp document_ja/lib/logo-crown.png document_en/lib/logo-crown.png
fi

echo "done."
echo
echo "Next:"
echo "  source .venv/bin/activate"
echo "  python -m pip install -r tools/requirements.txt"
echo "  python tools/generate_document.py"
