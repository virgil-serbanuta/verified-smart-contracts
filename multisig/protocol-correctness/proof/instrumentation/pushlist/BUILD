load("//:proof.bzl", "kompile", "kprove_test", "ktrusted", "klibrary")

kompile(
  name = "pushlist-execute",
  srcs = ["pushlist-execute.k"],
  deps = [
      "//protocol-correctness:pseudocode-files",
  ],
)

klibrary(
  name = "pushlist-execute-files",
  srcs = ["pushlist-execute.k"],
  deps = [
      "//protocol-correctness:pseudocode-files",
  ],
  visibility = ["//visibility:public"],
)

kprove_test(
  name = "proof-push-list-not-empty",
  srcs = ["proof-push-list-not-empty.k"],
  trusted = [],
  semantics = ":pushlist-execute",
  breadth = "2",
  # depth = ~2
)

ktrusted(
  name = "trusted-push-list-not-empty",
  srcs = ["proof-push-list-not-empty.k"],
  visibility = ["//visibility:public"],
)
