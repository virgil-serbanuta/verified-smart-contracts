module PROOF-PERFORM-REMOVE-USER-3
  imports EXECUTION

  claim
      <T>
        performLhs(
            RemoveUser(UserAddress:Address) #as Action:Action,
            K:K,
            NumUsers:Usize,
            UserIdToAddress:Map,
            (UserAddress |-> UserId:KItem _AddressToUserId:Map) #as AddressToUserId:Map,
            u(NumBoardMembers:Int),
            u(NumProposers:Int),
            (UserId |-> UserRole:KItem UserIdToRoleFinal:Map) #as UserIdToRole:Map,
            u(Quorum:Int),
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
            UserIdToRoleFinal,
            u(Quorum:Int),
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
            u(NumBoardMembers),
            u(NumProposers),
            UserIdToRole,
            u(Quorum))
        andBool notBool (UserRole ==K BoardMember)
        andBool Quorum <=Int NumBoardMembers
        andBool (NumBoardMembers +Int (NumProposers -Int 1) >Int 0)
    ensures performEnsures(
            ?NumUsersFinal,
            ?UserIdToAddressFinal,
            ?AddressToUserIdFinal,
            ?NumBoardMembersFinal,
            ?NumProposersFinal,
            UserIdToRoleFinal,
            u(Quorum))

endmodule
