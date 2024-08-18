# Bazel rules for ghdl [![Test status](https://github.com/filmil/bazel_rules_ghdl/workflows/Test/badge.svg)](https://github.com/filmil/bazel_rules_ghdl/workflows/Test/badge.svg)

This repository contains a [`bazel`][bb] rule set for running [`ghdl`][gg], the
VHDL simulator and synthesizer.

[bb]: https://bazel.build
[gg]: https://github.com/ghdl/ghdl

### Prerequisites

* `bazel` installation via [`bazelisk`][aa]. I recommend downloading `bazelisk`
  and placing it somewhere in your `$PATH` under the name `bazel`.

* `docker`: the build uses a build-in-docker approach to avoid installing complex
  dependencies.  See Notes section below as well.

Everything else will be downloaded for use the first time you run the build.

[aa]: https://github.com/bazelbuild/bazelisk?tab=readme-ov-file#installation

## Examples

In general, see [integration/](integration/) for example use.

### `ghdl_verilog`

Use GDHL to convert a vhdl file to verilog.  The build process will build an
intermediate result of a single VHDL library as well.

```
cd integration && bazel build //... && cat bazel-bin/verilog.v
```

### `ghdl_verilog`

If you want to see how it builds a library, run this:

```
cd integration && bazel build //:lib
```

## Notes

* Uses https://github.com/filmil/bazel-rules-bid. This means it will download
  and try to use a Docker image with `ghdl` installed in it. If you are unwilling
  or unable to run docker images in your builds, you should reconsider using it.

* The docker image in use is defined here:
  https://github.com/filmil/eda_tools/tree/main/ghdl

* Only Linux host and target are supported.

## References

* https://github.com/solsjo/rules_ghdl: an alternative rule set. Does not use
  docker, but not hermetic.
