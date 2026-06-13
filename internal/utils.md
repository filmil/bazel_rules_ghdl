<!-- Generated with Stardoc: http://skydoc.bazel.build -->



<a id="get_ghdl_vhdl_libs_and_prefix"></a>

## get_ghdl_vhdl_libs_and_prefix

<pre>
load("@rules_ghdl//internal:utils.bzl", "get_ghdl_vhdl_libs_and_prefix")

get_ghdl_vhdl_libs_and_prefix(<a href="#get_ghdl_vhdl_libs_and_prefix-ghdl_info">ghdl_info</a>, <a href="#get_ghdl_vhdl_libs_and_prefix-std">std</a>)
</pre>

Finds the GHDL standard libraries for the given VHDL standard and calculates GHDL_PREFIX.

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="get_ghdl_vhdl_libs_and_prefix-ghdl_info"></a>ghdl_info |  GHDLInfo provider.   |  none |
| <a id="get_ghdl_vhdl_libs_and_prefix-std"></a>std |  The VHDL standard string (e.g. '08').   |  none |

**RETURNS**

A tuple of (active_lib_files, prefix_dir).


<a id="get_single_file_from"></a>

## get_single_file_from

<pre>
load("@rules_ghdl//internal:utils.bzl", "get_single_file_from")

get_single_file_from(<a href="#get_single_file_from-target">target</a>)
</pre>

Retrieves the single file associated with a target.

**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="get_single_file_from-target"></a>target |  The target from which to extract the file.   |  none |

**RETURNS**

The single `File` object from the target.


