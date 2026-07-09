# Contributing to Nim-ACL

This repository keeps compatibility with existing Nim-ACL / ACL-style APIs while adding small convenience facades, tests, and documentation.

## Local verification policy

Before pushing changes that touch library code, tests, or documentation, run:

~~~bash
bash tools/quick_verify.sh
~~~

The script runs the main smoke tests for:

- core ACL modules
- extra FPS facade
- monoid helpers
- graph template / graph algorithm helpers
- universal segtree
- generated documentation consistency

It writes the full log to:

~~~text
/tmp/nacl_quick_verify.log
~~~

and prints a short final result block:

~~~text
===== NACL RESULT START =====
STATUS: OK
...
===== NACL RESULT END =====
~~~

When sharing logs in issue comments or review threads, prefer sharing only this final `NACL RESULT` block unless the status is `NG`.

## Documentation policy

Documentation is generated from `document_ja/**/*.md` and `document_en/**/*.md`.

To regenerate docs, publish to `gh-pages`, and run a short live-page sanity check, run:

~~~bash
bash tools/publish_docs.sh
~~~

The script writes the full log to:

~~~text
/tmp/nacl_publish_docs.log
~~~

and prints a short final `NACL RESULT` block.

## CI policy

The `quick-verify` GitHub Actions workflow should call:

~~~bash
bash tools/quick_verify.sh
~~~

This keeps CI behavior aligned with the local smoke test.

In CI, `tools/quick_verify.sh` treats generated documentation diffs as non-strict by default. This avoids Linux/macOS documentation rendering drift from failing unrelated code checks. Documentation publication remains the responsibility of `tools/publish_docs.sh`. Set `NACL_STRICT_DOCS=1` to make CI fail on generated documentation diffs.

When adding a new facade or user-facing helper, prefer the following sequence:

1. Add or update implementation.
2. Add targeted tests.
3. Add or update Japanese documentation.
4. Run `bash tools/quick_verify.sh`.
5. Commit and push.
6. Run `bash tools/publish_docs.sh` when documentation changed.

## Generated binaries

Local Nim test runs may generate executable files next to test files and may also create `.nim_runtime/` or `nimcache/`. Verification scripts remove the known generated test artifacts automatically. Do not commit generated binaries or generated runtime directories.

## Warning policy

Nim/C++ backend warnings such as generated-array-bound warnings may appear during local test builds. Treat them as warnings unless the test command fails. A successful run must still end with `STATUS: OK` in the `NACL RESULT` block.
