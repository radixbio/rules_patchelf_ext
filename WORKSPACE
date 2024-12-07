local_repository(
    name = "com_github_rules_patchelf",
    path = ".",
)

load("@com_github_rules_patchelf//:patchelf_configure.bzl", "patchelf_configure")

patchelf_configure(
    version = "0.18.0",
)

load("@com_github_rules_patchelf//:patchelf_dependencies.bzl", "patchelf_dependencies")

patchelf_dependencies()

register_toolchains(
    "@com_github_rules_patchelf//:patchelf_toolchain",  # This toolchain is build-host specific
)
