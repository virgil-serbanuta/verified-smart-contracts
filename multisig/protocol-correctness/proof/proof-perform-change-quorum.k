module PROOF-PERFORM-CHANGE-QUORUM
  imports EXECUTION

  claim 
      <T>
        performLhs(
            ChangeQuorum(u(NewQuorum:Int)),
            K:K,
            NumUsers:Usize,
            UserIdToAddress:Map,
            AddressToUserId:Map,
            u(NumBoardMembers:Int),
            NumProposers:Usize,
            UserIdToRole:Map,
            _OldQuorum:Usize,
            ActionState:ActionStateCell,
            .List, // TODO: Stack:List,
            ExternalCallEnv:ExternalCallEnvCell)
      </T>
      =>
      <T>
        performRhs(
            evaluate(void),
            K,
            NumUsers,
            UserIdToAddress,
            AddressToUserId,
            u(NumBoardMembers),
            NumProposers,
            UserIdToRole,
            u(NewQuorum),
            ActionState,
            ?_Variables:Map,
            .List, // TODO: Stack:List,
            ExternalCallEnv)
      </T>
    requires performRequires(
            NumUsers,
            UserIdToAddress,
            AddressToUserId,
            UserIdToRole)
        andBool NewQuorum <=Int NumBoardMembers

  claim 
      <T>
        performLhs(
            ChangeQuorum(u(NewQuorum:Int)),
            K:K,
            NumUsers:Usize,
            UserIdToAddress:Map,
            AddressToUserId:Map,
            u(NumBoardMembers:Int),
            NumProposers:Usize,
            UserIdToRole:Map,
            OldQuorum:Usize,
            ActionState:ActionStateCell,
            .List, // TODO: Stack:List,
            ExternalCallEnv:ExternalCallEnvCell)
      </T>
      =>
      <T>
        performRhs(
            error,
            K,
            NumUsers,
            UserIdToAddress,
            AddressToUserId,
            u(NumBoardMembers),
            NumProposers,
            UserIdToRole,
            OldQuorum,
            ActionState,
            ?_Variables:Map,
            .List, // TODO: Stack:List,
            ExternalCallEnv)
      </T>
    requires performRequires(
            NumUsers,
            UserIdToAddress,
            AddressToUserId,
            u(NumBoardMembers),
            NumProposers,
            UserIdToRole,
            OldQuorum)
        andBool NewQuorum >Int NumBoardMembers
endmodule
