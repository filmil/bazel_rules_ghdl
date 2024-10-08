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
        "deps": "The dependencies of this library",
        "cf_file": "The 'cf' file that GHDL provides",
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
    library_name = name

    # If the user has overridden the library name, apply that name.
    if ctx.attr.library_name:
        library_name = ctx.attr.library_name
    docker_run = ctx.executable._script
    std = ctx.attr.standard

    output_file = ctx.actions.declare_file("{}/{}-obj{}.cf".format(name, library_name, std))
    output_dir = ctx.actions.declare_directory("{}.{}.build".format(library_name, name))
    cache_dir = ctx.actions.declare_directory("{}.{}.cache".format(library_name, name))
    #outputs = [output_file, output_dir, cache_dir]
    outputs = [output_file]
    aux_dirs = [output_dir, cache_dir]

    # sources
    inputs = []

    input_files = []
    for src in ctx.attr.srcs:
        input_files += [f for f in src.files.to_list()]
    inputs += input_files

    libargs = []
    dep_sources = []
    lib_inputs = []
    # process deps.
    for dep in ctx.attr.deps:
        ghdl = dep[GhdlProvider]
        lib_depset = ghdl.library  # is a depset.
        for lib in lib_depset.to_list():
            libargs += ["-P{}".format(lib.dirname)]
            inputs += [lib]
            lib_inputs += [lib] # Redundant, but I'm not in the mood to refactor.
        prov_sources = ghdl.sources
        for file in prov_sources.to_list():
            dep_sources += [file]
        for file in ghdl.deps.to_list():
            lib_inputs += [file]

    args = ctx.actions.args()
    script = _script_cmd(
        docker_run.path,
        output_dir.path,
        cache_dir.path,
    )
    ctx.actions.run_shell(
        progress_message = \
            "{cmd} Library {library}".format(
            cmd=cmd, library=library_name),
        inputs = inputs + dep_sources + lib_inputs,
        outputs = outputs + aux_dirs,
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
          {libargs} \
          {files}
        """.format(
            script=script,
            cmd=cmd,
            library=library_name,
            std=std,
            workdir=output_file.dirname,
            libargs=" ".join(libargs),
            files=" ".join([f.path for f in input_files])
        ),
    )

    return [
        GhdlProvider(
            library=depset(outputs),
            name=library_name,
            sources=depset(input_files, transitive=[depset(dep_sources)]),
            deps=depset(lib_inputs),
            cf_file=output_file,
        ),
        DefaultInfo(
            files=depset(outputs+dep_sources+input_files),
            runfiles=ctx.runfiles(files=outputs+dep_sources+input_files),
        ),
    ]

ghdl_library = rule(
    implementation = _ghdl_library,
    attrs = {
        "srcs": attr.label_list(
            allow_files = [".vhd", ".vhdl"],
        ),
        "deps": attr.label_list(
            providers = [GhdlProvider],
        ),
        "vendor": attr.string_list(
            doc = "A list of libraries to be treated as vendor library black boxes",
        ),
        "standard": attr.string(
            default="08",
        ),
        "library_name": attr.string(
            doc = """Override the library name from target name if needed.
                     This is useful when there already is a target name that
                     is the same as the library name this rule would
                     have produced.
                  """,
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
    lib = ctx.attr.lib
    ghdl = lib[GhdlProvider]
    lib_name = ghdl.name
    cf_file = ghdl.cf_file

    output_file = ctx.actions.declare_file("{}/{}.v".format(name, lib_name))
    output_dir = ctx.actions.declare_directory("{}.build".format(name))
    cache_dir = ctx.actions.declare_directory("{}.cache".format(name))
    outputs = [output_file, output_dir, cache_dir]

    libargs = []
    inputs = []
    libraries = []
    # process deps.
    for dep in ctx.attr.deps:
        ghdl = dep[GhdlProvider]
        name = ghdl.name
        lib_depset = ghdl.library  # is a depset.
        for lib in lib_depset.to_list():
            libargs += ["-P{}".format(lib.dirname)]
            libraries += [lib]
            for file in dep.files.to_list():
                inputs += [file]

    libargs += ["-P{}".format(lib.files.to_list()[0].dirname)]
    inputs += lib.files.to_list()

    inputs += [source for source in ghdl.sources.to_list()]
    #for source in ghdl.sources.to_list():
        #inputs += [source]
    for file in ghdl.deps.to_list():
        libargs += ["-P{}".format(file.dirname)]
        inputs += [file]

    generics = [
        "-g{key}={value}".format(key=k,value=v)
            for (k, v) in ctx.attr.generics.items()]
    vendor = [ "--vendor-library={}".format(s) for s in ctx.attr.vendor]

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
        inputs = inputs + libraries,
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
            workdir=cf_file.dirname,
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
