load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load("@com_github_rules_patchelf_config//:config.bzl", "PATCHELF_URL", "PATCHELF_WIN")

def patchelf_dependencies():
    patchelf_build = None
    if PATCHELF_WIN:
        patchelf_build = 'exports_files(["' + "patchelf.exe" + '"])'
    else:
        patchelf_build = 'exports_files(["patchelf"])'

    maybe(
        http_archive,
        name = "com_github_rules_patchelf_binary",
        strip_prefix = "bin",
        url = PATCHELF_URL,
        build_file_content = patchelf_build,
    )
