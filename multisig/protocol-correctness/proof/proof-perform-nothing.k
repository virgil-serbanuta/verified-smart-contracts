module PROOF-PERFORM-NOTHING
  imports EXECUTION

  claim 
      <T>
        performLhs(
            Nothing,
            K:K,
            NumUsers:Usize,
            UserIdToAddress:Map,
            AddressToUserId:Map,
            NumBoardMembers:Usize,
            NumProposers:Usize,
            UserIdToRole:Map,
            Quorum:Usize,
            ActionState:ActionStateCell,
            Stack:List,
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
            NumBoardMembers,
            NumProposers,
            UserIdToRole,
            Quorum,
            ActionState,
            ?_Variables:Map,
            Stack,
            ExternalCallEnv)
      </T>
    requires performRequires(
            NumUsers,
            UserIdToAddress,
            AddressToUserId,
            UserIdToRole)
endmodule
