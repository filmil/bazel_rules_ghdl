load("@bazel_skylib//lib:paths.bzl", "paths")
load("@bazel_rules_bid//build:rules.bzl", "run_docker_cmd")


CONTAINER = "filipfilmar/ghdl:0.5"

CMD = "ghdl"


GhdlProvider = provider(
    doc = "A provider of GHDL library",
    fields = {
        "library": "The resulting library file",        
        "name": "The name of the library",
        "sources": "The source files of this library",
    }
)

def _script_cmd(
    script_path, 
    dir_reference, 
    cache_dir, 
    source_dir="", mounts=None, envs=None, tools=None):
    return run_docker_cmd(
        CONTAINER,
        script_path,
        dir_reference,
        scratch_dir="{}:/.cache".format(cache_dir),
        source_dir=source_dir,
        mounts=mounts,
        envs=envs,
        tools=tools,
    )

def _ghdl_library(ctx):
    cmd = CMD
    name = ctx.label.name
    docker_run = ctx.executable._script
    std = ctx.attr.standard

    output_file = ctx.actions.declare_file("{}-obj{}.cf".format(name, std))
    output_dir = ctx.actions.declare_directory("{}.build".format(name))
    cache_dir = ctx.actions.declare_directory("{}.cache".format(name))
    outputs = [output_file, output_dir, cache_dir]

    # sources
    input_depsets = []
    inputs = []

    input_files = []
    for t in ctx.attr.srcs:
        input_depsets = t.files
        input_files += [f for f in t.files.to_list()]
    inputs += input_files

    args = ctx.actions.args()

    script = _script_cmd(
        docker_run.path, 
        output_dir.path, 
        cache_dir.path, 
    )
    ctx.actions.run_shell(
        progress_message = \
            "{cmd} Library {library}".format(
            cmd=cmd, library=name),
        inputs = inputs,
        outputs = outputs,
        tools = [docker_run],
        mnemonic = "GHDL",
        command = """\
        {script} \
          {cmd} \
          -a \
          --workdir={workdir} \
          --work={library} \
          --std={std} \
          --warn-library \
          {files}
        """.format(
            script=script,
            cmd=cmd,
            library=name,
            std=std,
            workdir=output_file.dirname,
            files=" ".join([f.path for f in input_files])
        ),
    )

    return [
        GhdlProvider(
            library=depset(outputs),
            name=name,
            sources=depset(direct=[input_depsets]),
        ),
        DefaultInfo(
            files=depset(outputs),
            runfiles=ctx.runfiles(files=outputs),
        ),
    ]

ghdl_library = rule(
    implementation = _ghdl_library,
    attrs = {
        "srcs": attr.label_list(
            allow_files = [".vhd", ".vhdl"],
        ),
        "standard": attr.string(
            default="08",
        ),
        "_script": attr.label(
            default=Label("@bazel_rules_bid//build:docker_run"),
            executable=True,
            cfg="host"),
    },
)

def _ghdl_verilog(ctx):
    cmd = CMD
    name = ctx.label.name
    docker_run = ctx.executable._script

    output_file = ctx.actions.declare_file("{}.v".format(name))
    output_dir = ctx.actions.declare_directory("{}.build".format(name))
    cache_dir = ctx.actions.declare_directory("{}.cache".format(name))
    outputs = [output_file, output_dir, cache_dir]

    libargs = []
    inputs = []
    # process deps.
    for dep in ctx.attr.deps:
        ghdl = dep[GhdlProvider]
        name = ghdl.name
        lib = ghdl.library
        libargs += ["-P{}".format(lib.dirname)]
        for file in dep.files.to_list():
            inputs += [file]

    lib = ctx.attr.lib
    ghdl = lib[GhdlProvider]
    lib_name = ghdl.name
    libargs += ["-P{}".format(lib.files.to_list()[0].dirname)]
    inputs += lib.files.to_list()
    for source in ghdl.sources.to_list():
        inputs += [file for file in source.to_list()]

    generics = []
    for k, v in ctx.attr.generics.items():
        generics += [ "-g{key}={value}".format(key=k,value=v)]
    vendor = []
    for s in ctx.attr.vendor:
        vendor += [ "--vendor-library={lib}".format(lib=s) ]

    arch = ctx.attr.arch or ""

    script = _script_cmd(
        docker_run.path, 
        output_dir.path, 
        cache_dir.path, 
    )
    ctx.actions.run_shell(
        progress_message = \
            "{cmd} Library {library}".format(
            cmd=cmd, library=name),
        inputs = inputs,
        outputs = outputs,
        tools = [docker_run],
        mnemonic = "GHDLSYNTH",
        command = """\
        {script} \
          {cmd} \
          synth \
          {libargs} \
          {generics} \
          {vendor} \
          --workdir={workdir} \
          --work={library} \
          --out=verilog \
          --std={std} \
          {unit} \
          {arch}  \
          > {output}
        """.format(
            script=script,
            cmd=cmd,
            library=lib_name,
            workdir=output_file.dirname,
            libargs=" ".join(libargs),
            unit=ctx.attr.unit,
            arch=arch,
            output=output_file.path,
            std=ctx.attr.standard,
            generics=" ".join(generics),
            vendor=" ".join(vendor),
        ),
    )

    return [
        DefaultInfo(
            files=depset([output_file]),
        ),
    ]

ghdl_verilog = rule(
    implementation = _ghdl_verilog,
    attrs = {
        "arch": attr.string(
            default = "",
            doc = "The architecture to use for the entity, if there are multiple available",
        ),
        "unit": attr.string(
            doc = "The top level unit to elaborate."
        ),
        "lib": attr.label(
            providers = [ GhdlProvider ],
        ),
        "deps": attr.label_list(
            providers = [ GhdlProvider ],
            doc = "A list of GHDL libraries crated using ghdl_library",
        ),
        "standard": attr.string(
            default="08",
            doc = "The VHDL language standard to use. Supported versions depend on the GHDL version used",
        ),
        "generics": attr.string_dict(
            allow_empty = True,
            doc = "A map of string to string, definint the top level unit generic parameters",
        ),
        "vendor": attr.string_list(
            doc = "A list of libraries to be treated as vendor library black boxes",
        ),
        "_script": attr.label(
            default=Label("@bazel_rules_bid//build:docker_run"),
            executable=True,
            cfg="host"),
    },
)
