---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _pathExtension: py
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 70, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir).decode()\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/python.py\"\
    , line 84, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "#!/usr/bin/env python3\n\nfrom logging import Logger, basicConfig, getLogger\n\
    from os import getenv\nfrom pathlib import Path\n\nimport markdown\nimport toml\n\
    from jinja2 import DictLoader, Environment, Template, escape\n\nlogger: Logger\
    \ = getLogger(__name__)\n\nsources = toml.load(\"../test/example/problems.toml\"\
    )['sources']\n\n\nclass ExampleReader:\n\n    def __init__(self, problem_dir:\
    \ Path):\n        self.problem_dir = problem_dir\n\n    def __getitem__(self,\
    \ key: str):\n        logger.info('read example: {}'.format(key))\n        if\
    \ key not in sources:\n            print('example file not found')\n         \
    \   raise RuntimeError()\n        problem = sources[key]\n        if problem ==\
    \ '':\n            s = '### How to Use\\n'\n        else:\n            s = '###\
    \ AC code of [{}]({})\\n'.format(problem, problem)\n        example = open(self.problem_dir\
    \ / (key + '.nim')).read()\n        \n        s += '\\n'\n        s += '<div class=\"\
    sample-code\">'\n        s += str(escape(example))\n        s += '</div>\\n'\n\
    \        s += '\\n'\n        \n        return s\n\n\nhtml_head = open('template_head.html',\
    \ 'r').read()\nhtml_body = open('template_body.html', 'r').read()\n\ndef convert(md_statement:\
    \ str, base_dir: Path) -> str:\n    keywords = toml.load(base_dir / 'keywords.toml')\n\
    \n    environment = Environment(\n        variable_start_string=\"@{\", variable_end_string=\"\
    }\", loader=DictLoader({'task': md_statement}))\n    template = environment.get_template('task')\n\
    \n    mid_statement = template.render(\n        keyword=keywords,\n        example=ExampleReader(Path('..')\
    \ / 'test' / 'example')\n    )\n\n    # evaluate markdown\n    statement = markdown.markdown(mid_statement,\
    \ extensions=[\n        'fenced_code',\n        'md_in_html',\n    ], tab_length=2)\n\
    \n\n    return html_head + html_body.format(statement)\n\n\nif __name__ == \"\
    __main__\":\n    basicConfig(\n        format=\"%(asctime)s [%(levelname)s] %(message)s\"\
    ,\n        datefmt=\"%H:%M:%S\",\n        level=getenv('LOG_LEVEL', 'INFO'),\n\
    \    )\n\n    langs = ['en', 'ja']\n    for lang in langs:\n        logger.info('start\
    \ converting, lang={}'.format(lang))\n        base_dir : Path = Path('..') / 'document_{}'.format(lang)\
    \        \n\n        for md_file in base_dir.glob('*.md'):\n            logger.info('convert\
    \ {}'.format(md_file))\n            statement = convert(open(md_file).read(),\
    \ base_dir)\n\n            html_file = base_dir / (md_file.stem + '.html')\n \
    \           with open(html_file, 'w') as f:\n                f.write(statement)\n"
  dependsOn: []
  isVerificationFile: false
  path: tools/generate_document.py
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: tools/generate_document.py
layout: document
redirect_from:
- /library/tools/generate_document.py
- /library/tools/generate_document.py.html
title: tools/generate_document.py
---
