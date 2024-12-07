load(":rule.bzl", "patchelf_toolchain")

toolchain_type(name = "toolchain_type")

patchelf_toolchain(
    name = "patchelf_toolchain_decl",
    patchelf_binary = "@com_github_rules_patchelf_binary//:patchelf",
)

toolchain(
    name = "patchelf_toolchain",
    toolchain = ":patchelf_toolchain_decl",
    toolchain_type = ":toolchain_type",
)
