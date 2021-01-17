module TRUSTED-PERFORM-REMOVE-USER-5
  imports EXECUTION

  claim
      <T>
        performLhs(
            RemoveUser(UserAddress:Address) #as Action:Action,
            K:K,
            NumUsers:Usize,
            UserIdToAddress:Map,
            (UserAddress |-> UserId:KItem _AddressToUserId:Map) #as AddressToUserId:Map,
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
            ?NumUsersFinal,
            ?UserIdToAddressFinal,
            ?AddressToUserIdFinal,
            ?NumBoardMembersFinal,
            ?NumProposersFinal,
            ?UserIdToRoleFinal,
            Quorum,
            ActionState,
            ?_Variables:Map,
            .List, // TODO: Stack:List,
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
        andBool notBool (UserId in_keys(UserIdToRole))
    ensures performEnsures(
            ?NumUsersFinal,
            ?UserIdToAddressFinal,
            ?AddressToUserIdFinal,
            ?NumBoardMembersFinal,
            ?NumProposersFinal,
            ?UserIdToRoleFinal,
            Quorum)
    [trusted]
endmodule

module PROOF-PERFORM-REMOVE-USER-5
  imports EXECUTION

  claim
      <T>
        performLhs(
            RemoveUser(UserAddress:Address) #as Action:Action,
            K:K,
            NumUsers:Usize,
            UserIdToAddress:Map,
            (UserAddress |-> UserId:KItem _AddressToUserId:Map) #as AddressToUserId:Map,
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
            ?NumUsersFinal,
            ?UserIdToAddressFinal,
            ?AddressToUserIdFinal,
            ?NumBoardMembersFinal,
            ?NumProposersFinal,
            ?UserIdToRoleFinal,
            Quorum,
            ActionState,
            ?_Variables:Map,
            .List, // TODO: Stack:List,
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
        andBool notBool (UserId in_keys(UserIdToRole))
    ensures performEnsures(
            ?NumUsersFinal,
            ?UserIdToAddressFinal,
            ?AddressToUserIdFinal,
            ?NumBoardMembersFinal,
            ?NumProposersFinal,
            ?UserIdToRoleFinal,
            Quorum)

endmodule
