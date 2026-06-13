<!-- Generated with Stardoc: http://skydoc.bazel.build -->



<a id="ElaborateProvider"></a>

## ElaborateProvider

<pre>
load("@rules_ghdl//internal:providers.bzl", "ElaborateProvider")

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
load("@rules_ghdl//internal:providers.bzl", "GHDLInfo")

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
load("@rules_ghdl//internal:providers.bzl", "GhdlLibraryInfo")

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


