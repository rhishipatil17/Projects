package(default_visibility = ["//visibility:public"])

exports_files(["x86_64_gcc.BUILD"])

# The cc_toolchain itself is defined in x86_64_gcc.BUILD inside the downloaded @x86_64_gcc repo.
# Matches the host platform, so once registered it replaces the system gcc for local builds.
toolchain(
    name = "x86_64_toolchain",
    exec_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:x86_64",
    ],
    target_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:x86_64",
    ],
    toolchain = "@x86_64_gcc//:x86_64_gcc_toolchain",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)
