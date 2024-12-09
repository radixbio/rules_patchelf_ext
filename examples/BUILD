load("@com_github_rules_patchelf//:rule.bzl", "patchelf")

# Target @com_github_rules_patchelf//examples:link_with_me_first up-to-date:
#   bazel-bin/external/com_github_rules_patchelf/examples/liblink_with_me_first.a
#   bazel-bin/external/com_github_rules_patchelf/examples/liblink_with_me_first.so
cc_library(
    name = "link_with_me_first",
    srcs = ["foo.cc"],
    hdrs = ["foo.h"],
    linkstatic = False,
)

# Target @com_github_rules_patchelf//examples:patchelf_link_with_me up-to-date:
#   bazel-bin/external/com_github_rules_patchelf/examples/libpatchelf_link_with_me.a
#   bazel-bin/external/com_github_rules_patchelf/examples/libpatchelf_link_with_me.so
cc_library(
    name = "patchelf_link_with_me",
    srcs = ["bar.cc"],
    hdrs = ["foo.h"],
    linkstatic = False,
)

# $ ldd bazel-bin/external/com_github_rules_patchelf/examples/main
#         linux-vdso.so.1 (0x000076bf06a81000)
#         libexternal_Scom_Ugithub_Urules_Upatchelf_Sexamples_Sliblink_Uwith_Ume_Ufirst.so
cc_binary(
    name = "main",
    srcs = ["main.cc"],
    deps = [":link_with_me_first"],
    linkstatic = False,
)

# $ ldd bazel-bin/external/com_github_rules_patchelf/examples/main_patched
#         linux-vdso.so.1 (0x0000711160159000)
#         libpatchelf_link_with_me.so => not found
patchelf(
    name = "main_patched",
    obj = ":main",
    command = "--replace-needed libexternal_Scom_Ugithub_Urules_Upatchelf_Sexamples_Sliblink_Uwith_Ume_Ufirst.so libpatchelf_link_with_me.so",
    output = "main_patched",
    target_compatible_with = [
        "@platforms//os:linux"
    ],
)

# $ ldd bazel-bin/external/com_github_rules_patchelf/examples/main_rpath
#         linux-vdso.so.1 (0x000071d176802000)
#         libpatchelf_link_with_me.so => /home/dhash/radix/code/monorepo/bazel-bin/external/com_github_rules_patchelf/examples/libpatchelf_link_with_me.so (0x000071d1767f3000)
patchelf(
    name = "main_rpath",
    obj = ":main_patched",
    command = "--set-rpath $ORIGIN",  # note: the lack of quotes around $ORIGIN
    output = "main_rpath",
    target_compatible_with = [
        "@platforms//os:linux"
    ],
)
