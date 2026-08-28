load(":cc_toolchain_config.bzl", "cc_armv6_toolchain_config")

package(default_visibility = ["//visibility:public"])

filegroup(name = "empty")

# Define target platform
platform(
    name = "rpi_zero_w_platform",
    constraint_values = [
        "@platforms//os:linux",
        "@platforms//cpu:armv6",
    ],
)

cc_armv6_toolchain_config(name = "pi_zero_w_config")

cc_toolchain(
    name = "pi_zero_w_cc_toolchain",
    toolchain_identifier = "armv6-toolchain",
    toolchain_config = ":pi_zero_w_config",
    all_files = ":empty",
    compiler_files = ":empty",
    dwp_files = ":empty",
    linker_files = ":empty",
    objcopy_files = ":empty",
    strip_files = ":empty",
    supports_param_files = 0,
)

toolchain(
    name = "pi_zero_w_toolchain",
    exec_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:x86_64",
    ],
    target_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:armv6",
    ],
    toolchain = ":pi_zero_w_cc_toolchain",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)
