#!/usr/bin/env bash
set -euo pipefail

if [ ! -f tools/template.html ]; then
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
  <script src="https://cdn.jsdelivr.net/npm/highlight.js@11.11.1/lib/highlight.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/highlight.js@11.11.1/lib/languages/nim.min.js"></script>
  <script>
    window.addEventListener("load", function () {
      if (window.hljs) {
        document.querySelectorAll("pre code").forEach(function (block) {
          if (!block.className) {
            block.className = "language-nim";
          }
          hljs.highlightElement(block);
        });
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

cat >> document_ja/lib/main.css <<'CSS'

/* highlight.js integration */

pre code.hljs {
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
