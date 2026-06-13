# Instructions

Firstly, read README.md to understand how to build and what the purpose of
things is.

## Core Rules

- **Bazel 9.1.0 Compatibility**: This project uses Bazel 9.1.0. Ensure all
  changes are compatible with this version.
- **Go Commands**: Do not run `go` directly. Always use `bazel run
  @rules_go//go -- <args>`.
- **Go Scripting**: Use Go for scripting tasks instead of Python. Use the
  library `github.com/bitfield/script` for shell-like commands.
  - **Commands:**
    - **NEVER** run `go` directly. Always use `bazel run @rules_go//go -- <args>`.
    - Use `bazel run //:gazelle` to update build rules.
    - Use `bazel mod tidy` to update `MODULE.bazel`.
    - Build: `bazel build //...`
    - Test: `bazel test //...`
- **DO NOT** downgrade dependencies. If a downgrade is needed, stop and ask the
  user for permission.
- To manipulate bazel BUILD files with buildozer, use:
  `bazel run @buildozer -- ARGS`

## Modification Restrictions

Never auto-modify the following files:
* Anything in `//tools/bazel`
* Any dotfile (except when specifically instructed).
* Any `*.lock` files.
* Any `*.nix` files.

Unless otherwise instructed, only apply maintenance tasks to files in the git
index, or uncommitted files, to avoid redoing work on files that are already
committed to git.

## Formatting

**Do not run buildifier** on VHDL files, as it will mess up the VHDL file ordering.

## License Maintenance

When maintaining the license files do not modify the following:

* Files matching `*.gtkw`.
* Files under the directory `//third_party`.
* Any files with filenames beginning with a dot.

For all source files and all BUILD files, verify that they have a license
reference at the beginning of the file.

If a file does not have a license reference, add the SPDX license tag for
Apache 2.0 header, appropriately enclosed in comments for the source file.

## BCR Publishing

- Follow standard Bazel Central Registry (BCR) publishing procedures.
- Update the `version` parameter in the `module` statement in `MODULE.bazel`
  when releasing.
- Add `@bazel-io skip_check unstable_url` at the end of the PR description for
  BCR.

# Build and test

* To test, test both the "main" repo and the "integration" repo.
  * To test main repo:
    `bazel build //... && bazel test //...`
  * To test integration repo:
    `cd integration && bazel build //... && bazel test //...`

## Source control guidance

- Prefer rebase over merge: `git pull origin main --rebase`.
- PRs should be created against the `main` branch.
- Before creating PRs, rebase from main, and fix any conflicts.
- When resolving conflicts, use the `--no-edit` git option to prevent
  interactive editor invocations.

## Engineering Standards

- **Error Handling:** Never ignore errors. Propagate them with context or log
  them explicitly.
- Every feature MUST have unit tests.
- Large features MUST have integration tests.
- After every feature implementation, build and run tests to verify
  functionality and prevent regressions.
- **Feature Documentation:** Every new feature must be described in a Markdown
  report placed in the `//doc` directory. Additionally, the new report must be
  linked within the documentation index at `//doc/README.md`.

## Workspace Conventions

- Use "Conventional Commits 1.0.0" for commit messages.
