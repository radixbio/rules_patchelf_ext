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
    cmd = ctx.attr.command
    outs = []
    for file in ctx.files.objs:
        ctx.actions.run(
            outputs = [ctx.actions.declare_file("null")],
            inputs = [file],
            executable = str(patchelf.files_to_run.executable.short_path),
            command = cmd + " " + file.path,
        )
        outs.append(file)
    return [
        DefaultInfo(
            files = depset(outs),
        ),
    ]

patchelf = rule(
    implementation = _patchelf_impl,
    attrs = {
        "objs": attr.label_list(
            allow_files = [".so", ".dylib"],
        ),
        "command": attr.string(),
    },
    toolchains = ["@com_github_rules_patchelf//:toolchain_type"],
)
