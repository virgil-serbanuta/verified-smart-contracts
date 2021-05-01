load("//:proof.bzl", "kompile", "kprove_test", "ktrusted", "klibrary", "kore_test", "kprove_kompile")

kompile(
  name = "invariant-execution",
  srcs = ["invariant-execution.k"],
  deps = [
      ":init-loop-parts-files",
      "//protocol-correctness/proof:execution-proof-files",
      "//protocol-correctness/proof/functions:functions-execute-files",
      "//protocol-correctness/proof/instrumentation/pushlist:pushlist-execute-files",
  ],
)

klibrary(
  name = "invariant-execution-files",
  srcs = ["invariant-execution.k"],
  deps = [
      ":init-loop-parts-files",
      "//protocol-correctness/proof:execution-proof-files",
      "//protocol-correctness/proof/functions:functions-execute-files",
      "//protocol-correctness/proof/instrumentation/pushlist:pushlist-execute-files",
  ],
  visibility = ["//visibility:public"],
)

klibrary(
  name = "init-loop-parts-files",
  srcs = ["init-loop-parts.k"],
  deps = [
      "//protocol-correctness/proof:execution-proof-helpers-files",
      "//protocol-correctness/proof:invariant-files",
      "//protocol-correctness:pseudocode-files",
  ],
)

kprove_test(
  name = "proof-perform-action-endpoint",
  srcs = ["proof-perform-action-endpoint.k"],
  trusted = [
      ":trusted-perform-parts-1",
      ":trusted-perform-parts-2",
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-New-marker",
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-no-quorum-marker",
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-None-marker",
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-nothing-marker",
  ],
  semantics = ":invariant-execution",
  timeout = "eternal",
  breadth = "26",
  #depth ~49
)

kprove_test(
  name = "proof-perform-parts-1",
  srcs = ["proof-perform-parts-1.k"],
  trusted = [
      ":trusted-perform-parts-add-board-member",
      ":trusted-perform-parts-add-proposer-signers",
      ":trusted-perform-parts-add-proposer-no-signers",
      ":trusted-perform-parts-change-quorum",
      # ":trusted-perform-parts-New",
      # ":trusted-perform-parts-no-quorum",
      # ":trusted-perform-parts-None",
      ":trusted-perform-parts-remove-user",
      ":trusted-perform-parts-sc-call",
      ":trusted-perform-parts-sc-deploy",
      ":trusted-perform-parts-send-egld",
  ],
  semantics = ":invariant-execution",
  timeout = "eternal",
  breadth = "7",
  #depth ???
)

kprove_test(
  name = "proof-perform-parts-2",
  srcs = ["proof-perform-parts-2.k"],
  trusted = [
      ":trusted-perform-parts-add-board-member",
      ":trusted-perform-parts-add-proposer-signers",
      ":trusted-perform-parts-add-proposer-no-signers",
      ":trusted-perform-parts-change-quorum",
      # ":trusted-perform-parts-New",
      # ":trusted-perform-parts-no-quorum",
      # ":trusted-perform-parts-None",
      ":trusted-perform-parts-remove-user",
      ":trusted-perform-parts-sc-call",
      ":trusted-perform-parts-sc-deploy",
      ":trusted-perform-parts-send-egld",
  ],
  semantics = ":invariant-execution",
  timeout = "eternal",
  breadth = "7", # >1
  #depth ???
)

kprove_test(
  name = "proof-perform-parts-change-quorum",
  srcs = ["proof-perform-parts-change-quorum.k"],
  trusted = [
      ":trusted-perform-parts-change-quorum-with-quorum",
      ":trusted-perform-parts-change-quorum-no-quorum",
  ],
  semantics = ":invariant-execution",
  timeout = "eternal",
  breadth = "6",
  # depth = 21
)

kprove_test(
  name = "proof-perform-parts-change-quorum-with-quorum",
  srcs = ["proof-perform-parts-change-quorum-with-quorum.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-change-quorum",
  ],
  semantics = ":invariant-execution",
)

kprove_test(
  name = "proof-perform-parts-change-quorum-no-quorum",
  srcs = ["proof-perform-parts-change-quorum-no-quorum.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-change-quorum-no-quorum",
  ],
  semantics = ":invariant-execution",
)

# kprove_test(
#   name = "proof-perform-parts-New",
#   srcs = ["proof-perform-parts-New.k"],
#   trusted = [
#       "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-New",
#   ],
#   semantics = ":invariant-execution",
# )

# kprove_test(
#   name = "proof-perform-parts-None",
#   srcs = ["proof-perform-parts-None.k"],
#   trusted = [
#       "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-None",
#   ],
#   semantics = ":invariant-execution",
# )

# kprove_test(
#   name = "proof-perform-parts-no-quorum",
#   srcs = ["proof-perform-parts-no-quorum.k"],
#   trusted = [
#       "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-no-quorum",
#   ],
#   semantics = ":invariant-execution",
# )

# kprove_test(
#   name = "proof-perform-parts-nothing",
#   srcs = ["proof-perform-parts-nothing.k"],
#   trusted = [
#       "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-nothing",
#   ],
#   semantics = ":invariant-execution",
# )

kprove_test(
  name = "proof-perform-parts-sc-call",
  srcs = ["proof-perform-parts-sc-call.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-sc-call",
  ],
  semantics = ":invariant-execution",
)

kprove_test(
  name = "proof-perform-parts-sc-deploy",
  srcs = ["proof-perform-parts-sc-deploy.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-sc-deploy",
  ],
  semantics = ":invariant-execution",
)

kprove_test(
  name = "proof-perform-parts-send-egld",
  srcs = ["proof-perform-parts-send-egld.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-send-egld",
  ],
  semantics = ":invariant-execution",
)

kprove_test(
  name = "proof-perform-parts-add-board-member",
  srcs = ["proof-perform-parts-add-board-member.k"],
  trusted = [
      "trusted-perform-parts-add-board-member-eq",
      "trusted-perform-parts-add-board-member-neq",
      ":trusted-perform-parts-add-board-member-new",
      ":trusted-perform-parts-add-board-member-none",
  ],
  semantics = ":invariant-execution",
  timeout = "eternal",
  breadth = "9", # 0
  # 57 states
)

kprove_test(
  name = "proof-perform-parts-add-board-member-eq",
  srcs = ["proof-perform-parts-add-board-member-eq.k"],
  trusted = [
      ":trusted-perform-parts-add-board-member-boardmember-eq",
      ":trusted-perform-parts-add-board-member-proposer-eq",
  ],
  semantics = ":invariant-execution",
  timeout = "long",
  breadth = "6", # 0 
)

kprove_test(
  name = "proof-perform-parts-add-board-member-neq",
  srcs = ["proof-perform-parts-add-board-member-neq.k"],
  trusted = [
      ":trusted-perform-parts-add-board-member-boardmember",
      ":trusted-perform-parts-add-board-member-proposer",
  ],
  semantics = ":invariant-execution",
  timeout = "eternal",
  breadth = "7", # 0 
  # depth = ~27
)

kprove_test(
  name = "proof-perform-parts-add-proposer-signers",
  srcs = ["proof-perform-parts-add-proposer-signers.k"],
  trusted = [
      ":trusted-perform-parts-add-proposer-signers-eq",
      ":trusted-perform-parts-add-proposer-signers-neq",
      ":trusted-perform-parts-add-proposer-New",
      ":trusted-perform-parts-add-proposer-None",
  ],
  semantics = ":invariant-execution",
  timeout = "eternal",
  breadth = "5",
  # depth = ~25
)

kprove_test(
  name = "proof-perform-parts-add-proposer-signers-eq",
  srcs = ["proof-perform-parts-add-proposer-signers-eq.k"],
  trusted = [
      ":trusted-perform-parts-add-proposer-BoardMember-eq",
      ":trusted-perform-parts-add-proposer-BoardMember-no-quorum-eq",
      ":trusted-perform-parts-add-proposer-Proposer-eq",
  ],
  semantics = ":invariant-execution",
  timeout = "eternal",
  breadth = "3",
  # depth = ~32
)

kprove_test(
  name = "proof-perform-parts-add-proposer-signers-neq",
  srcs = ["proof-perform-parts-add-proposer-signers-neq.k"],
  trusted = [
      ":trusted-perform-parts-add-proposer-BoardMember-no-quorum",
      ":trusted-perform-parts-add-proposer-BoardMember",
      ":trusted-perform-parts-add-proposer-Proposer",
  ],
  semantics = ":invariant-execution",
  timeout = "eternal",
  breadth = "4",
  # depth = ~35
)

kprove_test(
  name = "proof-perform-parts-add-proposer-no-signers",
  srcs = ["proof-perform-parts-add-proposer-no-signers.k"],
  trusted = [
      ":trusted-perform-parts-add-proposer-no-signers-eq",
      ":trusted-perform-parts-add-proposer-no-signers-neq",
      ":trusted-perform-parts-add-proposer-New",
      ":trusted-perform-parts-add-proposer-None",
  ],
  timeout = "eternal",
  semantics = ":invariant-execution",
  breadth = "5",
  # depth = ~25
)

kprove_test(
  name = "proof-perform-parts-add-proposer-no-signers-eq",
  srcs = ["proof-perform-parts-add-proposer-no-signers-eq.k"],
  trusted = [
      ":trusted-perform-parts-add-proposer-BoardMember-eq",
      ":trusted-perform-parts-add-proposer-BoardMember-no-quorum-eq",
      ":trusted-perform-parts-add-proposer-Proposer-eq",
  ],
  semantics = ":invariant-execution",
  timeout = "eternal",
  breadth = "2",
  # depth = ~22
)

kprove_test(
  name = "proof-perform-parts-add-proposer-no-signers-neq",
  srcs = ["proof-perform-parts-add-proposer-no-signers-neq.k"],
  trusted = [
      ":trusted-perform-parts-add-proposer-BoardMember-no-quorum",
      ":trusted-perform-parts-add-proposer-BoardMember",
      ":trusted-perform-parts-add-proposer-Proposer",
  ],
  semantics = ":invariant-execution",
  timeout = "eternal",
  breadth = "3",
  # depth = ~23
)

kprove_test(
  name = "proof-perform-parts-remove-user",
  srcs = ["proof-perform-parts-remove-user.k"],
  trusted = [
      ":trusted-perform-parts-remove-user-eq",
      ":trusted-perform-parts-remove-user-neq",
      ":trusted-perform-parts-remove-user-New",
      ":trusted-perform-parts-remove-user-None",
  ],
  semantics = ":invariant-execution",
  timeout = "eternal",
  breadth = "9",
  # depth = 32
)

kprove_test(
  name = "proof-perform-parts-remove-user-eq",
  srcs = ["proof-perform-parts-remove-user-eq.k"],
  trusted = [
      ":trusted-perform-parts-remove-user-BoardMember-eq",
      ":trusted-perform-parts-remove-user-BoardMember-too-few-eq",
      ":trusted-perform-parts-remove-user-Proposer-eq",
      ":trusted-perform-parts-remove-user-Proposer-nobody-left-eq",
  ],
  semantics = ":invariant-execution",
  timeout = "eternal",
  breadth = "12",
  # depth = ~24
)

kprove_test(
  name = "proof-perform-parts-remove-user-neq",
  srcs = ["proof-perform-parts-remove-user-neq.k"],
  trusted = [
      ":trusted-perform-parts-remove-user-BoardMember",
      ":trusted-perform-parts-remove-user-BoardMember-too-few",
      ":trusted-perform-parts-remove-user-Proposer",
      ":trusted-perform-parts-remove-user-Proposer-nobody-left",
  ],
  semantics = ":invariant-execution",
  timeout = "eternal",
  breadth = "13",
  # depth = ~25
)

kprove_test(
  name = "proof-perform-parts-add-board-member-boardmember-eq",
  srcs = ["proof-perform-parts-add-board-member-boardmember-eq.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-add-board-member-BoardMember-eq",
  ],
  semantics = ":invariant-execution",
)

kprove_test(
  name = "proof-perform-parts-add-board-member-boardmember",
  srcs = ["proof-perform-parts-add-board-member-boardmember.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-add-board-member-BoardMember",
  ],
  semantics = ":invariant-execution",
)

kprove_test(
  name = "proof-perform-parts-add-board-member-new",
  srcs = ["proof-perform-parts-add-board-member-new.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-add-board-member-New",
  ],
  semantics = ":invariant-execution",
)

kprove_test(
  name = "proof-perform-parts-add-board-member-none",
  srcs = ["proof-perform-parts-add-board-member-none.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-add-board-member-None",
  ],
  semantics = ":invariant-execution",
)

kprove_test(
  name = "proof-perform-parts-add-board-member-proposer-eq",
  srcs = ["proof-perform-parts-add-board-member-proposer-eq.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-add-board-member-Proposer-eq",
  ],
  semantics = ":invariant-execution",
)

kprove_test(
  name = "proof-perform-parts-add-board-member-proposer",
  srcs = ["proof-perform-parts-add-board-member-proposer.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-add-board-member-Proposer",
  ],
  semantics = ":invariant-execution",
)

kprove_test(
  name = "proof-perform-parts-add-proposer-BoardMember-eq",
  srcs = ["proof-perform-parts-add-proposer-BoardMember-eq.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-add-proposer-BoardMember-eq",
  ],
  semantics = ":invariant-execution",
)

kprove_test(
  name = "proof-perform-parts-add-proposer-BoardMember",
  srcs = ["proof-perform-parts-add-proposer-BoardMember.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-add-proposer-BoardMember",
  ],
  semantics = ":invariant-execution",
)

kprove_test(
  name = "proof-perform-parts-add-proposer-BoardMember-no-quorum-eq",
  srcs = ["proof-perform-parts-add-proposer-BoardMember-no-quorum-eq.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-add-proposer-BoardMember-no-quorum-eq",
  ],
  semantics = ":invariant-execution",
)

kprove_test(
  name = "proof-perform-parts-add-proposer-BoardMember-no-quorum",
  srcs = ["proof-perform-parts-add-proposer-BoardMember-no-quorum.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-add-proposer-BoardMember-no-quorum",
  ],
  semantics = ":invariant-execution",
)

kprove_test(
  name = "proof-perform-parts-add-proposer-New",
  srcs = ["proof-perform-parts-add-proposer-New.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-add-proposer-New",
  ],
  semantics = ":invariant-execution",
)

kprove_test(
  name = "proof-perform-parts-add-proposer-None",
  srcs = ["proof-perform-parts-add-proposer-None.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-add-proposer-None",
  ],
  semantics = ":invariant-execution",
)

kprove_test(
  name = "proof-perform-parts-add-proposer-Proposer-eq",
  srcs = ["proof-perform-parts-add-proposer-Proposer-eq.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-add-proposer-Proposer-eq",
  ],
  semantics = ":invariant-execution",
)

kprove_test(
  name = "proof-perform-parts-add-proposer-Proposer",
  srcs = ["proof-perform-parts-add-proposer-Proposer.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-add-proposer-Proposer",
  ],
  semantics = ":invariant-execution",
)

kprove_test(
  name = "proof-perform-parts-remove-user-BoardMember-eq",
  srcs = ["proof-perform-parts-remove-user-BoardMember-eq.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-remove-user-BoardMember-eq",
  ],
  semantics = ":invariant-execution",
)

kprove_test(
  name = "proof-perform-parts-remove-user-BoardMember",
  srcs = ["proof-perform-parts-remove-user-BoardMember.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-remove-user-BoardMember",
  ],
  semantics = ":invariant-execution",
)

kprove_test(
  name = "proof-perform-parts-remove-user-BoardMember-too-few-eq",
  srcs = ["proof-perform-parts-remove-user-BoardMember-too-few-eq.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-remove-user-BoardMember-too-few-eq",
  ],
  semantics = ":invariant-execution",
)

kprove_test(
  name = "proof-perform-parts-remove-user-BoardMember-too-few",
  srcs = ["proof-perform-parts-remove-user-BoardMember-too-few.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-remove-user-BoardMember-too-few",
  ],
  semantics = ":invariant-execution",
)

kprove_test(
  name = "proof-perform-parts-remove-user-New",
  srcs = ["proof-perform-parts-remove-user-New.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-remove-user-New",
  ],
  semantics = ":invariant-execution",
)

kprove_test(
  name = "proof-perform-parts-remove-user-None",
  srcs = ["proof-perform-parts-remove-user-None.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-remove-user-None",
  ],
  semantics = ":invariant-execution",
)

kprove_test(
  name = "proof-perform-parts-remove-user-Proposer-eq",
  srcs = ["proof-perform-parts-remove-user-Proposer-eq.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-remove-user-Proposer-eq",
  ],
  semantics = ":invariant-execution",
)

kprove_test(
  name = "proof-perform-parts-remove-user-Proposer",
  srcs = ["proof-perform-parts-remove-user-Proposer.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-remove-user-Proposer",
  ],
  semantics = ":invariant-execution",
)

kprove_test(
  name = "proof-perform-parts-remove-user-Proposer-nobody-left-eq",
  srcs = ["proof-perform-parts-remove-user-Proposer-nobody-left-eq.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-remove-user-Proposer-nobody-left-eq",
  ],
  semantics = ":invariant-execution",
)

kprove_test(
  name = "proof-perform-parts-remove-user-Proposer-nobody-left",
  srcs = ["proof-perform-parts-remove-user-Proposer-nobody-left.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-perform-action-endpoint-remove-user-Proposer-nobody-left",
  ],
  semantics = ":invariant-execution",
)

kprove_test(
  name = "proof-propose-add-board-member",
  srcs = ["proof-propose-add-board-member.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-propose-action-BoardMember",
      "//protocol-correctness/proof/functions:trusted-propose-action-Proposer",
      "//protocol-correctness/proof/functions:trusted-propose-action-error-no-user",
      "//protocol-correctness/proof/functions:trusted-propose-action-error-no-role",
  ],
  semantics = ":invariant-execution",
  timeout = "eternal",
  breadth = "4", # 0
)

kprove_test(
  name = "proof-propose-add-proposer",
  srcs = ["proof-propose-add-proposer.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-propose-action-BoardMember",
      "//protocol-correctness/proof/functions:trusted-propose-action-Proposer",
      "//protocol-correctness/proof/functions:trusted-propose-action-error-no-user",
      "//protocol-correctness/proof/functions:trusted-propose-action-error-no-role",
  ],
  semantics = ":invariant-execution",
  timeout = "eternal",
  breadth = "6",
  # depth = ~38
)

kprove_test(
  name = "proof-propose-remove-user",
  srcs = ["proof-propose-remove-user.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-propose-action-BoardMember",
      "//protocol-correctness/proof/functions:trusted-propose-action-Proposer",
      "//protocol-correctness/proof/functions:trusted-propose-action-error-no-user",
      "//protocol-correctness/proof/functions:trusted-propose-action-error-no-role",
  ],
  semantics = ":invariant-execution",
  timeout = "eternal",
  breadth = "6",
  # depth = ~38
)

kprove_test(
  name = "proof-propose-change-quorum",
  srcs = ["proof-propose-change-quorum.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-propose-action-BoardMember",
      "//protocol-correctness/proof/functions:trusted-propose-action-Proposer",
      "//protocol-correctness/proof/functions:trusted-propose-action-error-no-user",
      "//protocol-correctness/proof/functions:trusted-propose-action-error-no-role",
  ],
  semantics = ":invariant-execution",
  timeout = "eternal",
  breadth = "6",
  # depth = ~38
)

kprove_test(
  name = "proof-propose-send-egld",
  srcs = ["proof-propose-send-egld.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-propose-action-BoardMember",
      "//protocol-correctness/proof/functions:trusted-propose-action-Proposer",
      "//protocol-correctness/proof/functions:trusted-propose-action-error-no-user",
      "//protocol-correctness/proof/functions:trusted-propose-action-error-no-role",
  ],
  semantics = ":invariant-execution",
  timeout = "eternal",
  breadth = "6",
  # depth = ~38
)

kprove_test(
  name = "proof-propose-sc-deploy-1",
  srcs = ["proof-propose-sc-deploy-1.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-propose-sc-deploy-error-no-user",
  ],
  semantics = ":invariant-execution",
  timeout = "eternal",
  breadth = "1",
  # depth = ~8
)

kprove_test(
  name = "proof-propose-sc-deploy-2",
  srcs = ["proof-propose-sc-deploy-2.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-propose-sc-deploy-error-no-role",
  ],
  semantics = ":invariant-execution",
  timeout = "eternal",
  breadth = "1",
  # depth = ~8
)

kprove_test(
  name = "proof-propose-sc-deploy-3",
  srcs = ["proof-propose-sc-deploy-3.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-propose-sc-deploy-BoardMember",
  ],
  semantics = ":invariant-execution",
  timeout = "eternal",
  breadth = "1",
  # depth = ~8
)

kprove_test(
  name = "proof-propose-sc-deploy-4",
  srcs = ["proof-propose-sc-deploy-4.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-propose-sc-deploy-Proposer",
  ],
  semantics = ":invariant-execution",
  timeout = "eternal",
  breadth = "1",
  # depth = ~8
)

kprove_test(
  name = "proof-propose-sc-deploy",
  srcs = ["proof-propose-sc-deploy.k"],
  trusted = [
      ":trusted-propose-sc-deploy-1",
      ":trusted-propose-sc-deploy-2",
      ":trusted-propose-sc-deploy-3",
      ":trusted-propose-sc-deploy-4",
  ],
  semantics = ":invariant-execution",
  timeout = "eternal",
  breadth = "6",
  # depth = ~?
)

kprove_test(
  name = "proof-propose-sc-call",
  srcs = ["proof-propose-sc-call.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-propose-action-BoardMember",
      "//protocol-correctness/proof/functions:trusted-propose-action-Proposer",
      "//protocol-correctness/proof/functions:trusted-propose-action-error-no-user",
      "//protocol-correctness/proof/functions:trusted-propose-action-error-no-role",
  ],
  semantics = ":invariant-execution",
  timeout = "eternal",
  breadth = "6",
  # depth = ~38
)

kprove_test(
  name = "proof-sign",
  srcs = ["proof-sign.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-sign-empty-action",
      "//protocol-correctness/proof/functions:trusted-sign-caller-not-user",
      "//protocol-correctness/proof/functions:trusted-sign-caller-none",
      "//protocol-correctness/proof/functions:trusted-sign-caller-proposer",
      "//protocol-correctness/proof/functions:trusted-sign-no-signers",
      "//protocol-correctness/proof/functions:trusted-sign-existing-signers-in-list",
      "//protocol-correctness/proof/functions:trusted-sign-existing-signers-not-in-list",
      "//protocol-correctness/proof/instrumentation/pushlist:trusted-push-list-not-empty",
  ],
  semantics = ":invariant-execution",
  timeout = "eternal",
  breadth = "10",
  # depth = ~42
)

kprove_test(
  name = "proof-unsign",
  srcs = ["proof-unsign.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-unsign-no-action",
      "//protocol-correctness/proof/functions:trusted-unsign-only-signer",
      "//protocol-correctness/proof/functions:trusted-unsign-other-signers-not-first",
      "//protocol-correctness/proof/functions:trusted-unsign-other-signers-first",
      "//protocol-correctness/proof/functions:trusted-unsign-not-signed",
      "//protocol-correctness/proof/functions:trusted-unsign-no-signers",
      "//protocol-correctness/proof/functions:trusted-unsign-Proposer",
      "//protocol-correctness/proof/functions:trusted-unsign-no-role-marker",
      "//protocol-correctness/proof/functions:trusted-unsign-no-user-marker",
  ],
  semantics = ":invariant-execution",
  timeout = "eternal",
  breadth = "17",
  # depth = ~66
)

kprove_test(
  name = "proof-discard-action",
  srcs = ["proof-discard-action.k"],
  trusted = [
      ":trusted-discard-action-3",
      "//protocol-correctness/proof/functions:trusted-discard-action-no-role-marker",
      "//protocol-correctness/proof/functions:trusted-discard-action-no-user-marker",
  ],
  semantics = ":invariant-execution",
  timeout = "eternal",
  breadth = "8",
  # depth = ~44
)

kprove_test(
  name = "proof-discard-action-1",
  srcs = ["proof-discard-action-1.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-discard-action-has-signers",
      "//protocol-correctness/proof/functions:trusted-discard-action-no-valid-signers",
      "//protocol-correctness/proof/functions:trusted-discard-action-no-valid-signers-no-action",
  ],
  semantics = ":invariant-execution",
  timeout = "eternal",
  breadth = "4",
  # depth = ~20
)

kprove_test(
  name = "proof-discard-action-2",
  srcs = ["proof-discard-action-2.k"],
  trusted = [
      "//protocol-correctness/proof/functions:trusted-discard-action-has-signers",
      "//protocol-correctness/proof/functions:trusted-discard-action-no-valid-signers",
      "//protocol-correctness/proof/functions:trusted-discard-action-no-valid-signers-no-action",
  ],
  semantics = ":invariant-execution",
  timeout = "eternal",
  breadth = "4",
  # depth = ~20
)

kprove_test(
  name = "proof-discard-action-3",
  srcs = ["proof-discard-action-3.k"],
  trusted = [
      ":trusted-discard-action-1",
      ":trusted-discard-action-2",
      "//protocol-correctness/proof/functions:trusted-discard-action-no-signers",
      "//protocol-correctness/proof/functions:trusted-discard-action-no-signers-no-action",
  ],
  semantics = ":invariant-execution",
  timeout = "eternal",
  breadth = "9",
  # depth = ~20
)

kprove_test(
  name = "proof-init-loop-error",
  srcs = ["proof-init-loop-error.k"],
  trusted = [
  ],
  semantics = ":invariant-execution",
  timeout = "eternal",
  breadth = "2", # >1
  # depth = ~
)

kprove_test(
  name = "proof-init-loop-no-error",
  srcs = ["proof-init-loop-no-error.k"],
  trusted = [
  ],
  semantics = ":invariant-execution",
  timeout = "eternal",
  breadth = "2", # >1
  # depth = ~
)

kprove_test(
  name = "proof-init",
  srcs = ["proof-init.k"],
  trusted = [
      ":proof-init-loop-error",
      ":proof-init-loop-no-error",
      "//protocol-correctness/proof/functions:trusted-listlen",
  ],
  semantics = ":invariant-execution",
  timeout = "eternal",
  breadth = "5", # >1
  # depth = ~213
)

ktrusted(
  name = "trusted-perform-parts-add-board-member-boardmember-eq",
  srcs = ["proof-perform-parts-add-board-member-boardmember-eq.k"],
  visibility = ["//visibility:public"],
)

ktrusted(
  name = "trusted-perform-parts-add-board-member-boardmember",
  srcs = ["proof-perform-parts-add-board-member-boardmember.k"],
  visibility = ["//visibility:public"],
)

ktrusted(
  name = "trusted-perform-parts-add-board-member-new",
  srcs = ["proof-perform-parts-add-board-member-new.k"],
  visibility = ["//visibility:public"],
)

ktrusted(
  name = "trusted-perform-parts-add-board-member-none",
  srcs = ["proof-perform-parts-add-board-member-none.k"],
  visibility = ["//visibility:public"],
)

ktrusted(
  name = "trusted-perform-parts-add-board-member-proposer-eq",
  srcs = ["proof-perform-parts-add-board-member-proposer-eq.k"],
  visibility = ["//visibility:public"],
)

ktrusted(
  name = "trusted-perform-parts-add-board-member-proposer",
  srcs = ["proof-perform-parts-add-board-member-proposer.k"],
  visibility = ["//visibility:public"],
)

ktrusted(
  name = "trusted-perform-parts-add-proposer-BoardMember-eq",
  srcs = ["proof-perform-parts-add-proposer-BoardMember-eq.k"],
  visibility = ["//visibility:public"],
)

ktrusted(
  name = "trusted-perform-parts-add-proposer-BoardMember-no-quorum-eq",
  srcs = ["proof-perform-parts-add-proposer-BoardMember-no-quorum-eq.k"],
  visibility = ["//visibility:public"],
)

ktrusted(
  name = "trusted-perform-parts-add-proposer-BoardMember-no-quorum",
  srcs = ["proof-perform-parts-add-proposer-BoardMember-no-quorum.k"],
  visibility = ["//visibility:public"],
)

ktrusted(
  name = "trusted-perform-parts-add-proposer-BoardMember",
  srcs = ["proof-perform-parts-add-proposer-BoardMember.k"],
  visibility = ["//visibility:public"],
)

ktrusted(
  name = "trusted-perform-parts-add-proposer-New",
  srcs = ["proof-perform-parts-add-proposer-New.k"],
  visibility = ["//visibility:public"],
)

ktrusted(
  name = "trusted-perform-parts-add-proposer-None",
  srcs = ["proof-perform-parts-add-proposer-None.k"],
  visibility = ["//visibility:public"],
)

ktrusted(
  name = "trusted-perform-parts-add-proposer-Proposer-eq",
  srcs = ["proof-perform-parts-add-proposer-Proposer-eq.k"],
  visibility = ["//visibility:public"],
)

ktrusted(
  name = "trusted-perform-parts-add-proposer-Proposer",
  srcs = ["proof-perform-parts-add-proposer-Proposer.k"],
  visibility = ["//visibility:public"],
)

ktrusted(
  name = "trusted-perform-parts-add-board-member-eq",
  srcs = ["proof-perform-parts-add-board-member-eq.k"],
  visibility = ["//visibility:public"],
)

ktrusted(
  name = "trusted-perform-parts-add-board-member-neq",
  srcs = ["proof-perform-parts-add-board-member-neq.k"],
  visibility = ["//visibility:public"],
)

ktrusted(
  name = "trusted-perform-parts-add-board-member",
  srcs = ["proof-perform-parts-add-board-member.k"],
  visibility = ["//visibility:public"],
)

ktrusted(
  name = "trusted-perform-parts-add-proposer-signers-eq",
  srcs = ["proof-perform-parts-add-proposer-signers-eq.k"],
  visibility = ["//visibility:public"],
)

ktrusted(
  name = "trusted-perform-parts-add-proposer-signers-neq",
  srcs = ["proof-perform-parts-add-proposer-signers-neq.k"],
  visibility = ["//visibility:public"],
)

ktrusted(
  name = "trusted-perform-parts-add-proposer-signers",
  srcs = ["proof-perform-parts-add-proposer-signers.k"],
  visibility = ["//visibility:public"],
)

ktrusted(
  name = "trusted-perform-parts-add-proposer-no-signers-eq",
  srcs = ["proof-perform-parts-add-proposer-no-signers-eq.k"],
  visibility = ["//visibility:public"],
)

ktrusted(
  name = "trusted-perform-parts-add-proposer-no-signers-neq",
  srcs = ["proof-perform-parts-add-proposer-no-signers-neq.k"],
  visibility = ["//visibility:public"],
)

ktrusted(
  name = "trusted-perform-parts-add-proposer-no-signers",
  srcs = ["proof-perform-parts-add-proposer-no-signers.k"],
  visibility = ["//visibility:public"],
)

ktrusted(
  name = "trusted-perform-parts-remove-user-BoardMember-eq",
  srcs = ["proof-perform-parts-remove-user-BoardMember-eq.k"],
  visibility = ["//visibility:public"],
)

ktrusted(
  name = "trusted-perform-parts-remove-user-BoardMember-too-few-eq",
  srcs = ["proof-perform-parts-remove-user-BoardMember-too-few-eq.k"],
  visibility = ["//visibility:public"],
)

ktrusted(
  name = "trusted-perform-parts-remove-user-BoardMember",
  srcs = ["proof-perform-parts-remove-user-BoardMember.k"],
  visibility = ["//visibility:public"],
)

ktrusted(
  name = "trusted-perform-parts-remove-user-BoardMember-too-few",
  srcs = ["proof-perform-parts-remove-user-BoardMember-too-few.k"],
  visibility = ["//visibility:public"],
)

ktrusted(
  name = "trusted-perform-parts-remove-user-New",
  srcs = ["proof-perform-parts-remove-user-New.k"],
  visibility = ["//visibility:public"],
)

ktrusted(
  name = "trusted-perform-parts-remove-user-None",
  srcs = ["proof-perform-parts-remove-user-None.k"],
  visibility = ["//visibility:public"],
)

ktrusted(
  name = "trusted-perform-parts-remove-user-Proposer-eq",
  srcs = ["proof-perform-parts-remove-user-Proposer-eq.k"],
  visibility = ["//visibility:public"],
)

ktrusted(
  name = "trusted-perform-parts-remove-user-Proposer-nobody-left-eq",
  srcs = ["proof-perform-parts-remove-user-Proposer-nobody-left-eq.k"],
  visibility = ["//visibility:public"],
)

ktrusted(
  name = "trusted-perform-parts-remove-user-Proposer",
  srcs = ["proof-perform-parts-remove-user-Proposer.k"],
  visibility = ["//visibility:public"],
)

ktrusted(
  name = "trusted-perform-parts-remove-user-Proposer-nobody-left",
  srcs = ["proof-perform-parts-remove-user-Proposer-nobody-left.k"],
  visibility = ["//visibility:public"],
)

ktrusted(
  name = "trusted-perform-parts-change-quorum-with-quorum",
  srcs = ["proof-perform-parts-change-quorum-with-quorum.k"],
  visibility = ["//visibility:public"],
)

ktrusted(
  name = "trusted-perform-parts-change-quorum-no-quorum",
  srcs = ["proof-perform-parts-change-quorum-no-quorum.k"],
  visibility = ["//visibility:public"],
)

# ktrusted(
#   name = "trusted-perform-parts-New",
#   srcs = ["proof-perform-parts-New.k"],
#   visibility = ["//visibility:public"],
# )

# ktrusted(
#   name = "trusted-perform-parts-no-quorum",
#   srcs = ["proof-perform-parts-no-quorum.k"],
#   visibility = ["//visibility:public"],
# )

# ktrusted(
#   name = "trusted-perform-parts-None",
#   srcs = ["proof-perform-parts-None.k"],
#   visibility = ["//visibility:public"],
# )

ktrusted(
  name = "trusted-perform-parts-nothing",
  srcs = ["proof-perform-parts-nothing.k"],
  visibility = ["//visibility:public"],
)

ktrusted(
  name = "trusted-perform-parts-remove-user",
  srcs = ["proof-perform-parts-remove-user.k"],
  visibility = ["//visibility:public"],
)

ktrusted(
  name = "trusted-perform-parts-remove-user-eq",
  srcs = ["proof-perform-parts-remove-user-eq.k"],
  visibility = ["//visibility:public"],
)

ktrusted(
  name = "trusted-perform-parts-remove-user-neq",
  srcs = ["proof-perform-parts-remove-user-neq.k"],
  visibility = ["//visibility:public"],
)

ktrusted(
  name = "trusted-perform-parts-change-quorum",
  srcs = ["proof-perform-parts-change-quorum.k"],
  visibility = ["//visibility:public"],
)

ktrusted(
  name = "trusted-perform-parts-sc-call",
  srcs = ["proof-perform-parts-sc-call.k"],
  visibility = ["//visibility:public"],
)

ktrusted(
  name = "trusted-perform-parts-sc-deploy",
  srcs = ["proof-perform-parts-sc-deploy.k"],
  visibility = ["//visibility:public"],
)

ktrusted(
  name = "trusted-perform-parts-send-egld",
  srcs = ["proof-perform-parts-send-egld.k"],
  visibility = ["//visibility:public"],
)

ktrusted(
  name = "trusted-perform-parts-1",
  srcs = ["proof-perform-parts-1.k"],
  visibility = ["//visibility:public"],
)

ktrusted(
  name = "trusted-perform-parts-2",
  srcs = ["proof-perform-parts-2.k"],
  visibility = ["//visibility:public"],
)

ktrusted(
  name = "trusted-propose-sc-deploy-1",
  srcs = ["proof-propose-sc-deploy-1.k"],
  visibility = ["//visibility:public"],
)

ktrusted(
  name = "trusted-propose-sc-deploy-2",
  srcs = ["proof-propose-sc-deploy-2.k"],
  visibility = ["//visibility:public"],
)

ktrusted(
  name = "trusted-propose-sc-deploy-3",
  srcs = ["proof-propose-sc-deploy-3.k"],
  visibility = ["//visibility:public"],
)

ktrusted(
  name = "trusted-propose-sc-deploy-4",
  srcs = ["proof-propose-sc-deploy-4.k"],
  visibility = ["//visibility:public"],
)

ktrusted(
  name = "trusted-discard-action-1",
  srcs = ["proof-discard-action-1.k"],
  visibility = ["//visibility:public"],
)

ktrusted(
  name = "trusted-discard-action-2",
  srcs = ["proof-discard-action-2.k"],
  visibility = ["//visibility:public"],
)

ktrusted(
  name = "trusted-discard-action-3",
  srcs = ["proof-discard-action-3.k"],
  visibility = ["//visibility:public"],
)
