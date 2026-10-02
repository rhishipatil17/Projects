load("@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl", "feature", "flag_group", "flag_set")

def _impl(ctx):
    tool_paths = [
        {"name": "gcc", "path": "/opt/cross-pi-gcc/bin/arm-linux-gnueabihf-gcc"},
        {"name": "ld", "path": "/opt/cross-pi-gcc/bin/arm-linux-gnueabihf-ld"},
        {"name": "ar", "path": "/opt/cross-pi-gcc/bin/arm-linux-gnueabihf-ar"},
        {"name": "cpp", "path": "/opt/cross-pi-gcc/bin/arm-linux-gnueabihf-cpp"},
        {"name": "gcov", "path": "/opt/cross-pi-gcc/bin/arm-linux-gnueabihf-gcov"},
        {"name": "nm", "path": "/opt/cross-pi-gcc/bin/arm-linux-gnueabihf-nm"},
        {"name": "objdump", "path": "/opt/cross-pi-gcc/bin/arm-linux-gnueabihf-objdump"},
        {"name": "strip", "path": "/opt/cross-pi-gcc/bin/arm-linux-gnueabihf-strip"},
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
                        ],
                    ),
                ],
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
        features = [armv6_flags],
    )

cc_armv6_toolchain_config = rule(
    implementation = _impl,
    attrs = {},
    provides = [CcToolchainConfigInfo],
)
