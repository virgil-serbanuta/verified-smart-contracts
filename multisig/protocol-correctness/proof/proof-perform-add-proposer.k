module TRUSTED-PERFORM-ADD-PROPOSER
  imports EXECUTION

  claim 
      <T>
        performLhs(
            AddProposer(_ProposerAddress:Address) #as Action:Action,
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
            ?NumUsersFinal,
            ?UserIdToAddressFinal,
            ?AddressToUserIdFinal,
            ?NumBoardMembersFinal,
            ?NumProposersFinal,
            ?UserIdToRoleFinal,
            Quorum,
            ActionState,
            ?_Variables:Map,
            Stack:List,
            ExternalCallEnv)
      </T>
    requires performRequires(
            Action,
            NumUsers,
            UserIdToAddress,
            AddressToUserId,
            NumBoardMembers,
            NumProposers,
            UserIdToRole,
            Quorum)
    [trusted]
endmodule
