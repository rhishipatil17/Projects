load("@rules_cc//cc:cc_toolchain_config_lib.bzl", "feature", "flag_group", "flag_set", "tool_path")
load("@rules_cc//cc/common:cc_common.bzl", "cc_common")
load("@rules_cc//cc/toolchains:cc_toolchain_config_info.bzl", "CcToolchainConfigInfo")

# Paths are relative to the @armv6_gcc repo root, where this config is instantiated
def _impl(ctx):
    tool_paths = [
        tool_path(name = "gcc", path = "bin/arm-linux-gnueabihf-gcc"),
        tool_path(name = "ld", path = "bin/arm-linux-gnueabihf-ld"),
        tool_path(name = "ar", path = "bin/arm-linux-gnueabihf-ar"),
        tool_path(name = "cpp", path = "bin/arm-linux-gnueabihf-cpp"),
        tool_path(name = "gcov", path = "bin/arm-linux-gnueabihf-gcov"),
        tool_path(name = "nm", path = "bin/arm-linux-gnueabihf-nm"),
        tool_path(name = "objdump", path = "bin/arm-linux-gnueabihf-objdump"),
        tool_path(name = "strip", path = "bin/arm-linux-gnueabihf-strip"),
    ]

    # Compiler's own system headers, so Bazel's include check accepts them
    builtin_include_dirs = [
        "%crosstool_top%/lib/gcc/arm-linux-gnueabihf/14.2.0/include",
        "%crosstool_top%/lib/gcc/arm-linux-gnueabihf/14.2.0/include-fixed",
        "%crosstool_top%/arm-linux-gnueabihf/include",
        "%crosstool_top%/arm-linux-gnueabihf/libc/usr/include",
    ]

    # Force compiler to emit ARMv6 VFP hardware-float code for Pi Zero W
    armv6_flags = feature(
        name = "armv6_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = [
                    "c-compile",
                    "c++-compile",
                    "c++-link",
                ],
                flag_groups = [
                    flag_group(
                        flags = [
                            "-mcpu=arm1176jzf-s",
                            "-mfloat-abi=hard",
                            "-mfpu=vfp",
                            # Report header paths relative to the execroot, not absolute
                            "-no-canonical-prefixes",
                        ],
                    ),
                ],
            ),
        ],
    )

    # Link the C++ standard library when linking C++ binaries
    default_link_flags = feature(
        name = "default_link_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = ["c++-link-executable", "c++-link-dynamic-library", "c++-link-nodeps-dynamic-library"],
                flag_groups = [flag_group(flags = ["-lstdc++", "-lm"])],
            ),
        ],
    )

    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        toolchain_identifier = "armv6-toolchain",
        host_system_name = "local",
        target_system_name = "armv6-linux-gnueabihf",
        target_cpu = "armv6",
        target_libc = "glibc",
        compiler = "gcc",
        abi_version = "unknown",
        abi_libc_version = "unknown",
        tool_paths = tool_paths,
        cxx_builtin_include_directories = builtin_include_dirs,
        features = [armv6_flags, default_link_flags],
    )

cc_armv6_toolchain_config = rule(
    implementation = _impl,
    attrs = {},
    provides = [CcToolchainConfigInfo],
)
