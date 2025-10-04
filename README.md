# Bazel rules for ghdl

[![Test status](https://github.com/filmil/bazel_rules_ghdl/actions/workflows/test.yml/badge.svg)](https://github.com/filmil/bazel_rules_ghdl/actions/workflows/test.yml)
[![Publish BCR status](https://github.com/filmil/bazel_rules_ghdl/actions/workflows/publish-bcr.yml/badge.svg)](https://github.com/filmil/bazel_rules_ghdl/actions/workflows/publish-bcr.yml)
[![Publish status](https://github.com/filmil/bazel_rules_ghdl/actions/workflows/publish.yml/badge.svg)](https://github.com/filmil/bazel_rules_ghdl/actions/workflows/publish.yml)
[![Tag and Release status](https://github.com/filmil/bazel_rules_ghdl/actions/workflows/tag-and-release.yml/badge.svg)](https://github.com/filmil/bazel_rules_ghdl/actions/workflows/tag-and-release.yml)

This repository contains a [`bazel`][bb] rule set for running [`ghdl`][gg], the
VHDL simulator and synthesizer, specifically to convert VHDL designs into
Verilog.

This is useful as Verilog open source tools are way more popular than VHDL
ones, and often useful modules may be written in both languages. By converting
to Verilog, you automatically get a chance to use the open source HDL ecosystem
of tools.

[bb]: https://bazel.build
[gg]: https://github.com/ghdl/ghdl

### Prerequisites

* `bazel` installation via [`bazelisk`][aa]. I recommend downloading `bazelisk`
  and placing it somewhere in your `$PATH` under the name `bazel`.

Everything else will be downloaded for use the first time you run the build.

[aa]: https://hdlfactory.com/note/2024/08/24/bazel-installation-via-the-bazelisk-method/

## Examples

In general, see [integration/](integration/) for example use.

### `ghdl_verilog`

Use GDHL to convert a vhdl file to verilog.  The build process will build an
intermediate result of a single VHDL library as well.

```
cd integration && bazel build //... && cat bazel-bin/verilog/lib.v
```

To see how it builds a library, run this:

```
cd integration && bazel build //:lib
```

## Notes

* Only Linux host and target are supported for now, although it should be
  straightforward (but not necessarily trivial) to add support for other archs.

## References

* https://github.com/solsjo/rules_ghdl: an alternative rule set, which is not
  hermetic.


