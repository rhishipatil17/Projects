load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def _pigpio_ext_impl(_ctx):
    http_archive(
        name = "pigpio",
        urls = ["https://github.com/joan2937/pigpio/archive/refs/heads/master.tar.gz"],
        strip_prefix = "pigpio-master",
        build_file_content = """
package(default_visibility = ["//visibility:public"])

cc_library(
    name = "pigpio",
    srcs = glob(["*.c"]),
    hdrs = ["pigpio.h"],
)
        """,
    )

pigpio_ext = module_extension(implementation = _pigpio_ext_impl)
