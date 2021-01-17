module PROOF-PERFORM-ADD-BOARD-MEMBER
  imports EXECUTION

  claim 
      <T>
        performLhs(
            AddBoardMember(_BoardMemberAddress:Address),
            K:K,
            NumUsers:Usize,
            UserIdToAddress:Map,
            AddressToUserId:Map,
            NumBoardMembers:Usize,
            NumProposers:Usize,
            UserIdToRole:Map,
            Quorum:Usize,
            ActionState:ActionStateCell,
            .List, // TODO: Stack:List,
            ExternalCallEnv:ExternalCallEnvCell)
      </T>
      =>
      <T>
        performRhs(
            evaluate(void),
            K,
            ?_NumUsers,
            ?_UserIdToAddress,
            ?_AddressToUserId,
            ?_NumBoardMembers,
            ?_NumProposers,
            ?_UserIdToRole,
            Quorum,
            ActionState,
            ?_Variables:Map,
            .List, // TODO: Stack:List,
            ExternalCallEnv)
      </T>
    requires performRequires(
            NumUsers,
            UserIdToAddress,
            AddressToUserId,
            NumBoardMembers,
            NumProposers,
            UserIdToRole,
            Quorum)
endmodule
