# BUILD file for the downloaded @x86_64_gcc repository.
# The cc_toolchain lives here so tool paths in the config resolve relative to the archive root.
load("@rules_cc//cc:defs.bzl", "cc_toolchain")
load("@//toolchain/x86_64:cc_toolchain_config.bzl", "cc_x86_64_toolchain_config")

package(default_visibility = ["//visibility:public"])

filegroup(
    name = "all_files",
    srcs = glob(
        ["**"],
        exclude = ["share/**"],
    ),
)

cc_x86_64_toolchain_config(name = "x86_64_gcc_config")

cc_toolchain(
    name = "x86_64_gcc_toolchain",
    toolchain_identifier = "x86_64-toolchain",
    toolchain_config = ":x86_64_gcc_config",
    all_files = ":all_files",
    ar_files = ":all_files",
    compiler_files = ":all_files",
    dwp_files = ":all_files",
    linker_files = ":all_files",
    objcopy_files = ":all_files",
    strip_files = ":all_files",
    supports_param_files = 0,
)
