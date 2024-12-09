PatchelfInfo = provider(
    doc = "Patchelf",
    fields = ["patchelf_binary"],
)

def _patchelf_toolchain_impl(ctx):
    toolchain_info = platform_common.ToolchainInfo(
        patchelf = PatchelfInfo(
            patchelf_binary = ctx.attr.patchelf_binary,
        ),
    )
    return [toolchain_info]

patchelf_toolchain = rule(
    implementation = _patchelf_toolchain_impl,
    attrs = {
        "patchelf_binary": attr.label(
            mandatory = True,
            allow_single_file = True,
            executable = True,
            cfg = "exec",
        ),
    },
)

def _patchelf_impl(ctx):
    patchelf = ctx.toolchains["@com_github_rules_patchelf//:toolchain_type"].patchelf.patchelf_binary
    file = ctx.file.obj
    cmd = ctx.attr.command

    arguments = (cmd + " " + file.path).split(" ")
    out = None

    if ctx.attr.output:
        out = ctx.actions.declare_file(ctx.attr.output)
        arguments.append("--output")
        arguments.append(out.path)
    else:
        out = ctx.actions.declare_file(ctx.attr.name + "_null")

    ctx.actions.run(
        outputs = [out],
        inputs = [ctx.file.obj, patchelf.files_to_run.executable],
        executable = str(patchelf.files_to_run.executable.path),
        arguments = arguments,
    )

    return [
        DefaultInfo(
            files = depset([out]),
        ),
    ]

# TODO: perhaps rename this to patchelf_shared_library
# since it's not creating executable outputs
patchelf = rule(
    implementation = _patchelf_impl,
    attrs = {
        "obj": attr.label(
            allow_single_file = True,
        ),
        "command": attr.string(),
        "output": attr.string(),  # TODO: should this be mandatory since otherwise it's in-place?
    },
    toolchains = ["@com_github_rules_patchelf//:toolchain_type"],
)
