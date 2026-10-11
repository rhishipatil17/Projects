package(default_visibility = ["//visibility:public"])

exports_files(["armv6_gcc.BUILD"])

# The cc_toolchain itself is defined in armv6_gcc.BUILD inside the downloaded @armv6_gcc repo
toolchain(
    name = "pi_zero_w_toolchain",
    exec_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:x86_64",
    ],
    # Any ARMv6 Linux board (Pi 1, Zero, Zero W); see //platforms
    target_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:arm",
        "//platforms:armv6",
    ],
    toolchain = "@armv6_gcc//:pi_zero_w_cc_toolchain",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)
