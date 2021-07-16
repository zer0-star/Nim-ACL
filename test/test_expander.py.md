---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: py
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/python.py\"\
    , line 96, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "#!/usr/bin/env python3\n\nimport unittest\nfrom logging import Logger, basicConfig,\
    \ getLogger\nfrom os import getenv, environ, pathsep\nfrom pathlib import Path\n\
    from shutil import copy\nfrom subprocess import run\nfrom tempfile import TemporaryDirectory\n\
    from typing import List\n\nlogger = getLogger(__name__)  # type: Logger\n\n\n\
    class Test(unittest.TestCase):\n    def compile_test(self, source: Path, expander_args=[],\
    \ env=None):\n        if not env:\n            env = environ.copy()\n        lib_dir\
    \ = Path.cwd().resolve()\n        expander_path = Path('expander.py').resolve()\n\
    \        with TemporaryDirectory() as new_dir:\n            tmp = Path(new_dir)\n\
    \            proc = run(['python', str(expander_path), str(\n                source.resolve())]\
    \ + expander_args, cwd=str(tmp), env=env)\n            self.assertEqual(proc.returncode,\
    \ 0)\n            proc = run(['g++', 'combined.cpp', '-std=c++14'], cwd=str(tmp))\n\
    \            self.assertEqual(proc.returncode, 0)\n\n    def test_dsu(self):\n\
    \        self.compile_test(Path('test/expander/include_dsu.cpp'),\n          \
    \                expander_args=['--lib', str(Path.cwd().resolve())])\n\n    def\
    \ test_unusual_format(self):\n        self.compile_test(Path('test/expander/include_unusual_format.cpp'),\n\
    \                          expander_args=['--lib', str(Path.cwd().resolve())])\n\
    \n    def test_all(self):\n        self.compile_test(Path('test/expander/include_all.cpp'),\n\
    \                          expander_args=['--lib', str(Path.cwd().resolve())])\n\
    \n    def test_comment_out(self):\n        self.compile_test(Path('test/expander/comment_out.cpp'),\n\
    \                          expander_args=['--lib', str(Path.cwd().resolve())])\n\
    \n    def test_env_value(self):\n        env = environ.copy()\n        env['CPLUS_INCLUDE_PATH']\
    \ = str(Path.cwd().resolve())\n        self.compile_test(Path('test/expander/include_all.cpp'),\
    \ env=env)\n        env['CPLUS_INCLUDE_PATH'] = pathsep + \\\n            pathsep\
    \ + str(Path.cwd().resolve()) + pathsep\n        self.compile_test(Path('test/expander/include_all.cpp'),\
    \ env=env)\n\n\nif __name__ == \"__main__\":\n    basicConfig(\n        level=getenv('LOG_LEVEL',\
    \ 'DEBUG'),\n        format=\"%(asctime)s %(levelname)s %(name)s : %(message)s\"\
    \n    )\n    unittest.main()\n"
  dependsOn: []
  isVerificationFile: false
  path: test/test_expander.py
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: test/test_expander.py
layout: document
redirect_from:
- /library/test/test_expander.py
- /library/test/test_expander.py.html
title: test/test_expander.py
---
