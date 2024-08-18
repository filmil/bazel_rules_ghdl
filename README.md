# Bazel rules for ghdl [![Test status](https://github.com/filmil/bazel_rules_ghdl/workflows/Test/badge.svg)](https://github.com/filmil/bazel_rules_ghdl/workflows/Test/badge.svg)

## Examples

### `ghdl_verilog`

Use GDHL to convert a vhdl file to verilog.

```
cd integration && bazel build //... && cat bazel-bin/verilog.v
```
