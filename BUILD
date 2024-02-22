load("//bazel/rules/rules_patchelf:rule.bzl", "patchelf_toolchain")

toolchain_type(name = "toolchain_type")

patchelf_toolchain(
    name = "patchelf_linux_x64",
    patchelf_binary = "@patchelf_x64//:patchelf",
)

patchelf_toolchain(
    name = "patchelf_linux_aarch64",
    patchelf_binary = "@patchelf_aarch64//:patchelf",
)

patchelf_toolchain(
    name = "patchelf_macos_aarch64",
    patchelf_binary = "@patchelf_aarch64//:patchelf",
)

toolchain(
    name = "patchelf_linux_x64_toolchain",
    exec_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:x86_64",
    ],
    target_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:x86_64",
    ],
    toolchain = ":patchelf_linux_x64",
    toolchain_type = ":toolchain_type",
)

toolchain(
    name = "patchelf_linux_aarch64_toolchain",
    exec_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:aarch64",
    ],
    target_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:aarch64",
    ],
    toolchain = ":patchelf_linux_aarch64",
    toolchain_type = ":toolchain_type",
)

toolchain(
    name = "patchelf_macos_aarch64_toolchain",
    exec_compatible_with = [
        "@platforms//os:macos",
        "@platforms//cpu:aarch64",
    ],
    target_compatible_with = [
        "@platforms//os:macos",
        "@platforms//cpu:aarch64",
    ],
    toolchain = ":patchelf_macos_aarch64",
    toolchain_type = ":toolchain_type",
)
