_OS_ARCH_LUT = {
    "windows": "win",
    "amd64": "x86_64",
    "x86": "i386",
    "i386": "i386",
    "i686": "i686",
    "s390x": "s390x",
    "riscv64": "riscv64",
    "ppc64le": "ppc64le",
    "armv7l": "armv7l",
    "aarch64": "aarch64",
}

_PATCHELF_URL = "https://github.com/NixOS/patchelf/releases/download/{version}/patchelf-{version}-{arch}.tar.gz"
_PATCHELF_WIN_URL = "https://github.com/NixOS/patchelf/releases/download/{version}/patchelf-{win}-{version}.exe"

def _patchelf_configure_impl(repository_ctx):
    os = repository_ctx.os.name.lower()
    arch = repository_ctx.os.arch.lower()
    version = repository_ctx.attr.version

    url = None
    win = False
    darwin = False
    if os.find("windows") != -1:
        if repository_ctx.os.arch.find("64") != -1:
            url = _PATCHELF_WIN_URL.format(win = "win64", version = version)
            win = True
        else:
            url = _PATCHELF_WIN_URL.format(win = "win32", version = version)
            win = True
    elif os.find("darwin") != -1 or os.find("mac") != -1:
        darwin = True
    else:
        url = _PATCHELF_URL.format(version = version, arch = _OS_ARCH_LUT[arch])

    config_file_content = """
    PATCHELF_VERSION="{patchelf_version}"
    PATCHELF_URL="{patchelf_url}"
    PATCHELF_WIN={patchelf_win}
    PATCHELF_DARWIN={patchelf_darwin}
    PATCHELF_ARCH="{patchelf_arch}"
    """.format(
        patchelf_version = version,
        patchelf_url = url,
        patchelf_win = win,
        patchelf_darwin = darwin,
        patchelf_arch = _OS_ARCH_LUT[arch],
    ).replace(" ", "")

    repository_ctx.file("config.bzl", config_file_content)
    repository_ctx.file("BUILD")

_patchelf_configure = repository_rule(
    implementation = _patchelf_configure_impl,
    attrs = {
        "version": attr.string(
            mandatory = True,
        ),
    },
)

def patchelf_configure(version):
    _patchelf_configure(
        name = "com_github_rules_patchelf_config",
        version = version,
    )
