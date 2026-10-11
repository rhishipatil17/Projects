# Projects

Database
PiArm

# Template for BUILD file
package(default_visibility = ["//visibility:public"])
cc_binary(
    name = "main_app"
    srcs = ["main.cpp"],
)
cc_test(
    name = "main_test",
    srcs = ["test_main.cpp"],
    deps = [
        "@googletest//:gtest_main",
    ],
)
# Template for pigpio library usage
cc_binary(
    name = "main_app",
    srcs = ["main.cpp"],
    deps = [
        "@pigpio//:pigpio",
    ],
)

# Build a target for pi
bazel build //<target_path>:<target> --config=pi_zero_w

# Build gtest suite for rpi
bazel build //<target_path>:<test_target> --config=pi_zero_w

# Run unit tests locally
bazel test //<target_path>:<test_target>

# Run unit tests and generate coverage report (add --config=pi_zero_w to generate bin for rpi)
bazel coverage //<target_path>:<test_target> --combined_report=lcov

# Visualize coverage output in html form (genhtml is available after installing lcov)
# Output available in: bazel-coverage-html/index.html
genhtml bazel-out/_coverage/_coverage_report.dat -o bazel-coverage-html


# Upload a package to github dependencies repo
gh release create <tag> <path/to/file.tar.gz> --repo rhishipatil17/bazel-deps --notes ""

<tag> : title of package; format: title-version (version- v0.0)
<file.tar.gz> : keep the package in tar.gz format
--notes : "Location: <url>"
          add the url to the actual location where the file was downloaded from for future reference
