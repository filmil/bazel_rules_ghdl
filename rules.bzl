load("//internal:providers.bzl", _GHDLInfo = "GHDLInfo", _GhdlLibraryInfo = "GhdlLibraryInfo", _ElaborateProvider = "ElaborateProvider")
load("//internal:toolchain.bzl", _ghdl_toolchain = "ghdl_toolchain")
load("//internal:ghdl_analyze.bzl", _ghdl_analyze = "ghdl_analyze")
load("//internal:ghdl_elaborate.bzl", _ghdl_elaborate = "ghdl_elaborate")
load("//internal:ghdl_test.bzl", _ghdl_test = "ghdl_test")
load("//internal:ghdl_verilog.bzl", _ghdl_verilog = "ghdl_verilog")
load("//internal:macros.bzl", _wave_view = "wave_view")

# Public rules
ghdl_analyze = _ghdl_analyze
ghdl_elaborate = _ghdl_elaborate
ghdl_test = _ghdl_test
ghdl_verilog = _ghdl_verilog

# Public toolchain and providers
ghdl_toolchain = _ghdl_toolchain
GHDLInfo = _GHDLInfo
GhdlLibraryInfo = _GhdlLibraryInfo
ElaborateProvider = _ElaborateProvider

# Public macros
wave_view = _wave_view
