# BUILD file for the downloaded @pigpio repository
load("@rules_cc//cc:defs.bzl", "cc_library")

package(default_visibility = ["//visibility:public"])

# Core library only; the other .c files (pigpiod, pigs, x_pigpio, ...) are programs with their own main()
cc_library(
    name = "pigpio",
    srcs = ["pigpio.c", "command.c"],
    hdrs = ["pigpio.h", "command.h"],
    # Included by pigpio.c as source text ("custom.cext"), not a normal header
    textual_hdrs = ["custom.cext"],
    linkopts = ["-pthread"],
)
