# Bazel rules for ghdl [![Test status](https://github.com/filmil/bazel_rules_ghdl/workflows/Test/badge.svg)](https://github.com/filmil/bazel_rules_ghdl/workflows/Test/badge.svg)

## Examples

### `ghdl_verilog`

Use GDHL to convert a vhdl file to verilog.

```
cd integration && bazel build //... && cat bazel-bin/verilog.v
```

## Notes

* Uses https://github.com/filmil/bazel-rules-bid. This means it will download
  and try to use a Docker image with ghdl installed in it. If you are unwilling
  or unable to run docker images in your builds, you should reconsider using it.

* The docker image in use is defined here:
  https://github.com/filmil/eda_tools/tree/main/ghdl

## References

* https://github.com/solsjo/rules_ghdl: an alternative rule set. Does not use
  docker, but not hermetic.
