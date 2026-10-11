# Downloaded by bazel under externals/platforms/os/BUILD
# os/BUILD
# constraint_setting(name = "os")
# constraint_value(name = "linux", constraint_setting = ":os")
# constraint_value(name = "windows", constraint_setting = ":os")
# ...                                   # 23 OS values in total

# Downloaded by bazel under externals/platforms/cpu/BUILD
# cpu/BUILD
# constraint_setting(name = "cpu")
# constraint_value(name = "x86_64",  constraint_setting = ":cpu")
# constraint_value(name = "aarch64", constraint_setting = ":cpu")   # 64-bit ARM
# constraint_value(name = "armv7",   constraint_setting = ":cpu")
# constraint_value(name = "armv6-m", constraint_setting = ":cpu")   # Cortex-M, not the Pi
# alias(name = "arm", actual = ":aarch32")                          # generic 32-bit ARM
# ...                                   # 28 CPU values in total

package(default_visibility = ["//visibility:public"])

# ARM architecture revision. @platforms only has the generic cpu:arm (armv6-m is Cortex-M),
# so toolchains use this to say which ARM cores they produce code for.
constraint_setting(name = "arm_arch")
constraint_value(
    name = "armv6",
    constraint_setting = ":arm_arch",
)

# Target board, for board-specific code (e.g. select() on GPIO pin maps)
constraint_setting(name = "board")
constraint_value(
    name = "pi_zero_w",
    constraint_setting = ":board",
)

# Raspberry Pi Zero W: BCM2835, ARM1176JZF-S (ARMv6 + VFPv2), 32-bit Linux
platform(
    name = "rpi_zero_w",
    constraint_values = [
        "@platforms//os:linux",
        "@platforms//cpu:arm",
        ":armv6",
        ":pi_zero_w",
    ],
)
