<!-- Generated with Stardoc: http://skydoc.bazel.build -->



<a id="ghdl_analyze"></a>

## ghdl_analyze

<pre>
load("@rules_ghdl//:rules.bzl", "ghdl_analyze")

ghdl_analyze(<a href="#ghdl_analyze-name">name</a>, <a href="#ghdl_analyze-deps">deps</a>, <a href="#ghdl_analyze-args">args</a>, <a href="#ghdl_analyze-library">library</a>, <a href="#ghdl_analyze-standard">standard</a>)
</pre>

Analyzes a vhdl_library target to produce a GHDL library object directory.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="ghdl_analyze-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="ghdl_analyze-deps"></a>deps |  A list of other compiled ghdl_analyze targets that this library depends on.   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `[]`  |
| <a id="ghdl_analyze-args"></a>args |  Additional arguments to pass to GHDL.   | List of strings | optional |  `[]`  |
| <a id="ghdl_analyze-library"></a>library |  The vhdl_library target to compile/analyze.   | <a href="https://bazel.build/concepts/labels">Label</a> | required |  |
| <a id="ghdl_analyze-standard"></a>standard |  The VHDL standard to use for compilation (e.g., '08', '19'). If empty, defaults to the standard specified in the library, or '08'.   | String | optional |  `""`  |


<a id="ghdl_elaborate"></a>

## ghdl_elaborate

<pre>
load("@rules_ghdl//:rules.bzl", "ghdl_elaborate")

ghdl_elaborate(<a href="#ghdl_elaborate-name">name</a>, <a href="#ghdl_elaborate-library">library</a>, <a href="#ghdl_elaborate-standard">standard</a>)
</pre>

Elaborates a VHDL design using GHDL.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="ghdl_elaborate-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="ghdl_elaborate-library"></a>library |  The ghdl_analyze compiled target to elaborate.   | <a href="https://bazel.build/concepts/labels">Label</a> | optional |  `None`  |
| <a id="ghdl_elaborate-standard"></a>standard |  The VHDL standard to use for elaboration (e.g., '08', '19').   | String | optional |  `"08"`  |


<a id="ghdl_toolchain"></a>

## ghdl_toolchain

<pre>
load("@rules_ghdl//:rules.bzl", "ghdl_toolchain")

ghdl_toolchain(<a href="#ghdl_toolchain-name">name</a>, <a href="#ghdl_toolchain-analyzer">analyzer</a>, <a href="#ghdl_toolchain-vhdl_libs">vhdl_libs</a>)
</pre>

Defines the GHDL toolchain, linking to the GHDL analyzer and standard library.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="ghdl_toolchain-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="ghdl_toolchain-analyzer"></a>analyzer |  The GHDL executable.   | <a href="https://bazel.build/concepts/labels">Label</a> | optional |  `None`  |
| <a id="ghdl_toolchain-vhdl_libs"></a>vhdl_libs |  The standard VHDL libraries for GHDL.   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `[]`  |


<a id="ghdl_verilog"></a>

## ghdl_verilog

<pre>
load("@rules_ghdl//:rules.bzl", "ghdl_verilog")

ghdl_verilog(<a href="#ghdl_verilog-name">name</a>, <a href="#ghdl_verilog-deps">deps</a>, <a href="#ghdl_verilog-arch">arch</a>, <a href="#ghdl_verilog-args">args</a>, <a href="#ghdl_verilog-generics">generics</a>, <a href="#ghdl_verilog-lib">lib</a>, <a href="#ghdl_verilog-standard">standard</a>, <a href="#ghdl_verilog-unit">unit</a>, <a href="#ghdl_verilog-vendor">vendor</a>)
</pre>

Synthesizes a GHDL library into a Verilog netlist.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="ghdl_verilog-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="ghdl_verilog-deps"></a>deps |  A list of GHDL compiled libraries created using ghdl_analyze   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `[]`  |
| <a id="ghdl_verilog-arch"></a>arch |  The architecture to use for the entity, if there are multiple available   | String | optional |  `""`  |
| <a id="ghdl_verilog-args"></a>args |  Additional arguments to pass to GHDL   | List of strings | optional |  `[]`  |
| <a id="ghdl_verilog-generics"></a>generics |  A map of string to string, defining the top level unit generic parameters   | <a href="https://bazel.build/rules/lib/core/dict">Dictionary: String -> String</a> | optional |  `{}`  |
| <a id="ghdl_verilog-lib"></a>lib |  The target GHDL compiled library to synthesize.   | <a href="https://bazel.build/concepts/labels">Label</a> | optional |  `None`  |
| <a id="ghdl_verilog-standard"></a>standard |  The VHDL language standard to use.   | String | optional |  `"08"`  |
| <a id="ghdl_verilog-unit"></a>unit |  The top level unit to elaborate.   | String | optional |  `""`  |
| <a id="ghdl_verilog-vendor"></a>vendor |  A list of libraries to be treated as vendor library black boxes   | List of strings | optional |  `[]`  |


<a id="ElaborateProvider"></a>

## ElaborateProvider

<pre>
load("@rules_ghdl//:rules.bzl", "ElaborateProvider")

ElaborateProvider(<a href="#ElaborateProvider-entity">entity</a>)
</pre>

Provides information about an elaborated VHDL entity.

**FIELDS**

| Name  | Description |
| :------------- | :------------- |
| <a id="ElaborateProvider-entity"></a>entity |  string: The name of the elaborated entity.    |


<a id="GHDLInfo"></a>

## GHDLInfo

<pre>
load("@rules_ghdl//:rules.bzl", "GHDLInfo")

GHDLInfo(<a href="#GHDLInfo-analyzer">analyzer</a>, <a href="#GHDLInfo-vhdl_libs">vhdl_libs</a>)
</pre>

Information on how to run GHDL for VHDL analysis, elaboration and simulation.

**FIELDS**

| Name  | Description |
| :------------- | :------------- |
| <a id="GHDLInfo-analyzer"></a>analyzer |  The GHDL executable file.    |
| <a id="GHDLInfo-vhdl_libs"></a>vhdl_libs |  The standard VHDL libraries for GHDL.    |


<a id="GhdlLibraryInfo"></a>

## GhdlLibraryInfo

<pre>
load("@rules_ghdl//:rules.bzl", "GhdlLibraryInfo")

GhdlLibraryInfo(<a href="#GhdlLibraryInfo-libraries">libraries</a>, <a href="#GhdlLibraryInfo-library_name">library_name</a>, <a href="#GhdlLibraryInfo-library_dir">library_dir</a>, <a href="#GhdlLibraryInfo-transitive_sources">transitive_sources</a>)
</pre>

Contains the information about the binary files in a compiled GHDL library.

**FIELDS**

| Name  | Description |
| :------------- | :------------- |
| <a id="GhdlLibraryInfo-libraries"></a>libraries |  List[(string, File)]: A mapping from a library name to its directory location. Contains both this library and its dependencies, ensuring no duplicate keys.    |
| <a id="GhdlLibraryInfo-library_name"></a>library_name |  string: The name of the library (e.g., `ieee`, `work`).    |
| <a id="GhdlLibraryInfo-library_dir"></a>library_dir |  File: The container directory where the library is located.    |
| <a id="GhdlLibraryInfo-transitive_sources"></a>transitive_sources |  depset[File]: All transitive VHDL source files of this library and its dependencies.    |


<a id="ghdl_test"></a>

## ghdl_test

<pre>
load("@rules_ghdl//:rules.bzl", "ghdl_test")

ghdl_test(<a href="#ghdl_test-name">name</a>, <a href="#ghdl_test-srcs">srcs</a>, <a href="#ghdl_test-deps">deps</a>, <a href="#ghdl_test-standard">standard</a>, <a href="#ghdl_test-args">args</a>, <a href="#ghdl_test-entity">entity</a>, <a href="#ghdl_test-entities">entities</a>)
</pre>

Defines a GHDL VHDL test target.

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="ghdl_test-name"></a>name |  <p align="center"> - </p>   |  none |
| <a id="ghdl_test-srcs"></a>srcs |  <p align="center"> - </p>   |  none |
| <a id="ghdl_test-deps"></a>deps |  <p align="center"> - </p>   |  `[]` |
| <a id="ghdl_test-standard"></a>standard |  <p align="center"> - </p>   |  `"08"` |
| <a id="ghdl_test-args"></a>args |  <p align="center"> - </p>   |  `[]` |
| <a id="ghdl_test-entity"></a>entity |  <p align="center"> - </p>   |  `None` |
| <a id="ghdl_test-entities"></a>entities |  <p align="center"> - </p>   |  `[]` |


<a id="wave_view"></a>

## wave_view

<pre>
load("@rules_ghdl//:rules.bzl", "wave_view")

wave_view(<a href="#wave_view-name">name</a>, <a href="#wave_view-wave_file">wave_file</a>, <a href="#wave_view-args">args</a>, <a href="#wave_view-viewer">viewer</a>)
</pre>

Dummy or helper wave_view macro for GHDL wave files.

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="wave_view-name"></a>name |  <p align="center"> - </p>   |  none |
| <a id="wave_view-wave_file"></a>wave_file |  <p align="center"> - </p>   |  none |
| <a id="wave_view-args"></a>args |  <p align="center"> - </p>   |  `[]` |
| <a id="wave_view-viewer"></a>viewer |  <p align="center"> - </p>   |  `"gtkwave"` |


