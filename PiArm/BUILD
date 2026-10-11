package(default_visibility = ["//visibility:public"])

# Pulls in every external dependency PiArm needs, so they can be downloaded up front:
# Nothing is compiled; Bazel only downloads and unpacks the archives into its cache.
# bazel fetch //PiArm:deps
filegroup(
    name = "deps",
    srcs = [
        "@armv6_gcc//:all_files",
        "@googletest//:gtest",
        "@googletest//:gtest_main",
        "@pigpio//:pigpio",
    ],
    tags = ["manual"],
)
