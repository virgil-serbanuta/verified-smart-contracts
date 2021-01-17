module TRUSTED-COUNT-CAN-SIGN
  imports EXECUTION

  claim <T> countCanSignLhs(
                SignerIds:ExpressionList,
                K:K,
                Users:UsersCell,
                NumBoardMembers:KItem,
                NumProposers:Usize,
                UserIdToRole:Map,
                Quorum:KItem,
                ActionState:ActionStateCell,
                Variables:Map,
                Stack:List,
                ExternalCallEnv:ExternalCallEnvCell)
        </T>
      => <T> countCanSignRhs(
                ?Count:Usize,
                K,
                Users,
                NumBoardMembers,
                NumProposers,
                UserIdToRole,
                Quorum,
                ActionState,
                ?Variables:Map,
                Stack,
                ExternalCallEnv)
        </T>
    requires
        countCanSignRequires(
            SignerIds,
            Users,
            NumBoardMembers,
            NumProposers,
            UserIdToRole,
            Quorum,
            ActionState,
            Variables,
            Stack,
            ExternalCallEnv)
    ensures
        countCanSignEnsures(
            ?Count,
            Users,
            NumBoardMembers,
            NumProposers,
            UserIdToRole,
            Quorum,
            ActionState,
            ?Variables,
            Stack,
            ExternalCallEnv)
    [trusted]

endmodule

module PROOF-COUNT-CAN-SIGN
  imports EXECUTION

  claim <T> countCanSignLhs(
                SignerIds:ExpressionList,
                K:K,
                Users:UsersCell,
                NumBoardMembers:KItem,
                NumProposers:Usize,
                UserIdToRole:Map,
                Quorum:KItem,
                ActionState:ActionStateCell,
                Variables:Map,
                Stack:List,
                ExternalCallEnv:ExternalCallEnvCell)
        </T>
      => <T> countCanSignRhs(
                ?Count:Usize,
                K,
                Users,
                NumBoardMembers,
                NumProposers,
                UserIdToRole,
                Quorum,
                ActionState,
                ?Variables:Map,
                Stack,
                ExternalCallEnv)
        </T>
    requires
        countCanSignRequires(
            SignerIds,
            Users,
            NumBoardMembers,
            NumProposers,
            UserIdToRole,
            Quorum,
            ActionState,
            Variables,
            Stack,
            ExternalCallEnv)
    ensures
        countCanSignEnsures(
            ?Count,
            Users,
            NumBoardMembers,
            NumProposers,
            UserIdToRole,
            Quorum,
            ActionState,
            ?Variables,
            Stack,
            ExternalCallEnv)

endmodule
