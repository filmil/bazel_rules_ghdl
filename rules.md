<!-- Generated with Stardoc: http://skydoc.bazel.build -->



<a id="ghdl_library"></a>

## ghdl_library

<pre>
load("@rules_ghdl//:rules.bzl", "ghdl_library")

ghdl_library(<a href="#ghdl_library-name">name</a>, <a href="#ghdl_library-deps">deps</a>, <a href="#ghdl_library-srcs">srcs</a>, <a href="#ghdl_library-library_name">library_name</a>, <a href="#ghdl_library-standard">standard</a>, <a href="#ghdl_library-vendor">vendor</a>)
</pre>

Analyzes VHDL source files to produce a GHDL library object file.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="ghdl_library-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="ghdl_library-deps"></a>deps |  A list of GHDL libraries created using ghdl_library.   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `[]`  |
| <a id="ghdl_library-srcs"></a>srcs |  The list of VHDL source files.   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `[]`  |
| <a id="ghdl_library-library_name"></a>library_name |  Override the library name from target name if needed. This is useful when there already is a target name that is the same as the library name this rule would have produced.   | String | optional |  `""`  |
| <a id="ghdl_library-standard"></a>standard |  The VHDL language standard to use.   | String | optional |  `"08"`  |
| <a id="ghdl_library-vendor"></a>vendor |  A list of libraries to be treated as vendor library black boxes   | List of strings | optional |  `[]`  |


<a id="ghdl_verilog"></a>

## ghdl_verilog

<pre>
load("@rules_ghdl//:rules.bzl", "ghdl_verilog")

ghdl_verilog(<a href="#ghdl_verilog-name">name</a>, <a href="#ghdl_verilog-deps">deps</a>, <a href="#ghdl_verilog-arch">arch</a>, <a href="#ghdl_verilog-generics">generics</a>, <a href="#ghdl_verilog-lib">lib</a>, <a href="#ghdl_verilog-standard">standard</a>, <a href="#ghdl_verilog-unit">unit</a>, <a href="#ghdl_verilog-vendor">vendor</a>)
</pre>

Synthesizes a GHDL library into a Verilog netlist.

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="ghdl_verilog-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="ghdl_verilog-deps"></a>deps |  A list of GHDL libraries created using ghdl_library   | <a href="https://bazel.build/concepts/labels">List of labels</a> | optional |  `[]`  |
| <a id="ghdl_verilog-arch"></a>arch |  The architecture to use for the entity, if there are multiple available   | String | optional |  `""`  |
| <a id="ghdl_verilog-generics"></a>generics |  A map of string to string, defining the top level unit generic parameters   | <a href="https://bazel.build/rules/lib/core/dict">Dictionary: String -> String</a> | optional |  `{}`  |
| <a id="ghdl_verilog-lib"></a>lib |  The target GHDL library to synthesize.   | <a href="https://bazel.build/concepts/labels">Label</a> | optional |  `None`  |
| <a id="ghdl_verilog-standard"></a>standard |  The VHDL language standard to use. Supported versions depend on the GHDL version used   | String | optional |  `"08"`  |
| <a id="ghdl_verilog-unit"></a>unit |  The top level unit to elaborate.   | String | optional |  `""`  |
| <a id="ghdl_verilog-vendor"></a>vendor |  A list of libraries to be treated as vendor library black boxes   | List of strings | optional |  `[]`  |


<a id="GhdlProvider"></a>

## GhdlProvider

<pre>
load("@rules_ghdl//:rules.bzl", "GhdlProvider")

GhdlProvider(<a href="#GhdlProvider-library">library</a>, <a href="#GhdlProvider-name">name</a>, <a href="#GhdlProvider-sources">sources</a>, <a href="#GhdlProvider-deps">deps</a>, <a href="#GhdlProvider-cf_file">cf_file</a>)
</pre>

A provider of GHDL library

**FIELDS**

| Name  | Description |
| :------------- | :------------- |
| <a id="GhdlProvider-library"></a>library |  The resulting library file    |
| <a id="GhdlProvider-name"></a>name |  The name of the library    |
| <a id="GhdlProvider-sources"></a>sources |  The source files of this library    |
| <a id="GhdlProvider-deps"></a>deps |  The dependencies of this library    |
| <a id="GhdlProvider-cf_file"></a>cf_file |  The 'cf' file that GHDL provides    |


