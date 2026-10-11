load("@rules_cc//cc:action_names.bzl", "ALL_CC_COMPILE_ACTION_NAMES", "ALL_CC_LINK_ACTION_NAMES")
load("@rules_cc//cc:cc_toolchain_config_lib.bzl", "feature", "flag_group", "flag_set", "tool_path")
load("@rules_cc//cc/common:cc_common.bzl", "cc_common")
load("@rules_cc//cc/toolchains:cc_toolchain_config_info.bzl", "CcToolchainConfigInfo")

# TODO: check the tool prefix and header dirs against the uploaded archive:
#   ls bin/
#   echo | bin/<prefix>g++ -no-canonical-prefixes -xc++ -E -v - 2>&1 | sed -n '/#include <...>/,/End of/p'
# Values below assume a Bootlin x86-64 glibc toolchain.

# Paths are relative to the @x86_64_gcc repo root, where this config is instantiated
def _impl(ctx):
    tool_paths = [
        tool_path(name = "gcc", path = "bin/x86_64-buildroot-linux-gnu-gcc"),
        tool_path(name = "ld", path = "bin/x86_64-buildroot-linux-gnu-ld"),
        tool_path(name = "ar", path = "bin/x86_64-buildroot-linux-gnu-ar"),
        tool_path(name = "cpp", path = "bin/x86_64-buildroot-linux-gnu-cpp"),
        tool_path(name = "gcov", path = "bin/x86_64-buildroot-linux-gnu-gcov"),
        tool_path(name = "nm", path = "bin/x86_64-buildroot-linux-gnu-nm"),
        tool_path(name = "objdump", path = "bin/x86_64-buildroot-linux-gnu-objdump"),
        tool_path(name = "strip", path = "bin/x86_64-buildroot-linux-gnu-strip"),
    ]

    # Compiler's own system headers, so Bazel's include check accepts them.
    # These are prefixes, so a top-level dir covers every header below it.
    builtin_include_dirs = [
        "%crosstool_top%/lib/gcc/x86_64-buildroot-linux-gnu",  # gcc's own headers (stddef.h, ...)
        "%crosstool_top%/x86_64-buildroot-linux-gnu",  # libstdc++ and the glibc sysroot headers
    ]

    compile_flags = feature(
        name = "compile_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = ALL_CC_COMPILE_ACTION_NAMES,
                flag_groups = [flag_group(flags = [
                    # Report header paths relative to the execroot, not absolute
                    "-no-canonical-prefixes",
                ])],
            ),
        ],
    )

    # Link the C++ standard library when linking C++ binaries
    default_link_flags = feature(
        name = "default_link_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = ALL_CC_LINK_ACTION_NAMES,
                flag_groups = [flag_group(flags = ["-lstdc++", "-lm"])],
            ),
        ],
    )

    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        toolchain_identifier = "x86_64-toolchain",
        host_system_name = "local",
        target_system_name = "x86_64-linux-gnu",
        target_cpu = "k8",
        target_libc = "glibc",
        compiler = "gcc",
        abi_version = "unknown",
        abi_libc_version = "unknown",
        tool_paths = tool_paths,
        cxx_builtin_include_directories = builtin_include_dirs,
        features = [compile_flags, default_link_flags],
    )

cc_x86_64_toolchain_config = rule(
    implementation = _impl,
    attrs = {},
    provides = [CcToolchainConfigInfo],
)
