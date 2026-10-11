load("@rules_cc//cc:action_names.bzl", "ALL_CC_COMPILE_ACTION_NAMES", "ALL_CC_LINK_ACTION_NAMES")
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

    # Compiler's own system headers, so Bazel's include check accepts them.
    # These are prefixes, so a top-level dir covers every header below it.
    builtin_include_dirs = [
        "%crosstool_top%/lib/gcc/arm-linux-gnueabihf",  # gcc's own headers (stddef.h, ...)
        "%crosstool_top%/arm-linux-gnueabihf",  # libstdc++ and the glibc sysroot headers
    ]

    # Force compiler to emit ARMv6 VFP hardware-float code for Pi Zero W.
    # The linker gets the same flags so it picks the matching hard-float libraries.
    armv6_cpu_flags = [
        "-mcpu=arm1176jzf-s",
        "-mfloat-abi=hard",
        "-mfpu=vfp",
    ]
    armv6_flags = feature(
        name = "armv6_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = ALL_CC_COMPILE_ACTION_NAMES,
                flag_groups = [flag_group(flags = armv6_cpu_flags + [
                    # Report header paths relative to the execroot, not absolute
                    "-no-canonical-prefixes",
                ])],
            ),
            flag_set(
                actions = ALL_CC_LINK_ACTION_NAMES,
                flag_groups = [flag_group(flags = armv6_cpu_flags)],
            ),
        ],
    )

    # Link the C++ standard library statically: GCC 14's libstdc++ is newer than the
    # one on the Pi's OS, so a dynamic link fails at runtime with "GLIBCXX_3.4.xx not found"
    default_link_flags = feature(
        name = "default_link_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = ALL_CC_LINK_ACTION_NAMES,
                flag_groups = [flag_group(flags = [
                    "-Wl,-Bstatic",
                    "-lstdc++",
                    "-Wl,-Bdynamic",
                    "-static-libgcc",
                    "-lm",
                ])],
            ),
        ],
    )

    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        toolchain_identifier = "armv6-toolchain",
        host_system_name = "local",
        target_system_name = "arm-linux-gnueabihf",
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
