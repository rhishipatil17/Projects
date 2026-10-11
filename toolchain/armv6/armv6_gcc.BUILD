# BUILD file for the downloaded @armv6_gcc repository.
# The cc_toolchain lives here so tool paths in the config resolve relative to the archive root.
load("@rules_cc//cc:defs.bzl", "cc_toolchain")
load("@//toolchain/armv6:cc_toolchain_config.bzl", "cc_armv6_toolchain_config")

package(default_visibility = ["//visibility:public"])

filegroup(
    name = "all_files",
    srcs = glob(
        ["**"],
        exclude = ["share/**"],
    ),
)

cc_armv6_toolchain_config(name = "pi_zero_w_config")

cc_toolchain(
    name = "pi_zero_w_cc_toolchain",
    toolchain_identifier = "armv6-toolchain",
    toolchain_config = ":pi_zero_w_config",
    all_files = ":all_files",
    ar_files = ":all_files",
    compiler_files = ":all_files",
    dwp_files = ":all_files",
    linker_files = ":all_files",
    objcopy_files = ":all_files",
    strip_files = ":all_files",
    supports_param_files = 0,
)
