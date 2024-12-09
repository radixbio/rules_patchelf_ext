load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load("@com_github_rules_patchelf_config//:config.bzl", "PATCHELF_DARWIN", "PATCHELF_URL", "PATCHELF_VERSION", "PATCHELF_WIN")

def patchelf_dependencies():
    patchelf_build = None
    if PATCHELF_WIN:
        patchelf_build = 'exports_files(["' + "patchelf.exe" + '"])'
        maybe(
            http_archive,
            name = "com_github_rules_patchelf_binary",
            strip_prefix = "bin",
            url = PATCHELF_URL,
            build_file_content = patchelf_build,
        )
    elif PATCHELF_DARWIN:
        # patchelf does not have an official macos MachO build, so i'm doing this
        # because Nix is hell
        # and I don't know how to make the tests pass on the actual macos repo
        # so...
        patchelf_build = """
package(default_visibility = ["@com_github_rules_patchelf//:__subpackages__"])
cc_binary(
    name = "patchelf",
    srcs = ["src/patchelf.cc", "src/elf.h", "src/patchelf.h"],
    copts = ["-Wall", "-Wextra", "-Wcast-qual", "-std=c++17"],
    local_defines = ["_FILE_OFFSET_BITS=64"]
)
        """
        maybe(
            git_repository,
            name = "com_github_rules_patchelf_binary",
            tag = PATCHELF_VERSION,
            remote = "https://github.com/NixOS/patchelf.git",
            build_file_content = patchelf_build,
        )
    else:
        patchelf_build = 'exports_files(["patchelf"])'
        maybe(
            http_archive,
            name = "com_github_rules_patchelf_binary",
            strip_prefix = "bin",
            url = PATCHELF_URL,
            build_file_content = patchelf_build,
        )
