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
