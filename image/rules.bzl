
def _rootfs_impl(ctx):
    name = ctx.attr.name
    xrootfs = ctx.executable._xrootfs
    image_tar = ctx.attr.src.files.to_list()[0]

    output_dir = ctx.actions.declare_directory(name)

    inputs = [image_tar]
    outputs = [output_dir]

    args = ctx.actions.args()

    args.add("--image-tar", image_tar.path)
    args.add("--rootfs-dir", output_dir.path)
    args.add("--marker", "HERE")

    ctx.actions.run(
        inputs = inputs,
        outputs = outputs,
        mnemonic = "xrootfs",
        progress_message = "Extracting rootfs",
        executable = xrootfs,
        arguments = [args],
    )

    return [
        DefaultInfo(files=depset([output_dir])),
    ]


rootfs = rule(
    implementation = _rootfs_impl,
    attrs = {
        "src": attr.label(
            allow_single_file = True,
            mandatory = True,
        ),
        "_xrootfs": attr.label(
            default = "@multitool//tools/xrootfs",
            executable = True,
            cfg = "host",
        ),
    },

)
