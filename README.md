# Bazel rules for ghdl [![Test status](https://github.com/filmil/bazel_rules_ghdl/workflows/Test/badge.svg)](https://github.com/filmil/bazel_rules_ghdl/workflows/Test/badge.svg)

This repository contains a [`bazel`][bb] rule set for running [`ghdl`][gg], the
VHDL simulator and synthesizer, specifically to convert VHDL designs into Verilog.

This is useful as Verilog open source tools are way more popular than VHDL ones, and
often useful modules may be written in both languages. By converting to Verilog, you
automatically get a chance to use the open source HDL ecosystem of tools.

[bb]: https://bazel.build
[gg]: https://github.com/ghdl/ghdl

### Prerequisites

* `bazel` installation via [`bazelisk`][aa]. I recommend downloading `bazelisk`
  and placing it somewhere in your `$PATH` under the name `bazel`.

* `docker`: the build uses a build-in-docker approach to avoid installing complex
  dependencies.  See Notes section below as well.

Everything else will be downloaded for use the first time you run the build.

[aa]: https://hdlfactory.com/note/2024/08/24/bazel-installation-via-the-bazelisk-method/

## Examples

In general, see [integration/](integration/) for example use.

### `ghdl_verilog`

Use GDHL to convert a vhdl file to verilog.  The build process will build an
intermediate result of a single VHDL library as well.

```
cd integration && bazel build //... && cat bazel-bin/verilog.v
```

To see how it builds a library, run this:

```
cd integration && bazel build //:lib
```

## Notes

* Uses https://github.com/filmil/bazel-rules-bid. This means it will download
  and try to use a Docker image with `ghdl` installed in it. If you are unwilling
  or unable to run docker images in your builds, you may not be able to use it.

  While using docker complicates the build deployment somewhat, it is a fairly
  straightforward way to work around the complexity that is building a
  `bazel`-compatible distribution of `ghdl`. I thought this was a reasonable
  tradeoff.

* The docker image in use is defined here:
  https://github.com/filmil/eda_tools/tree/main/ghdl

* Only Linux host and target are supported.

## References

* https://github.com/solsjo/rules_ghdl: an alternative rule set. Does not use
  docker, but is not hermetic.
