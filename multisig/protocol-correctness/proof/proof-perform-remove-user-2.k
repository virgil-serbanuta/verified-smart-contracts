module PROOF-PERFORM-REMOVE-USER-2
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
            (UserId |-> BoardMember) #as UserIdToRole:Map,
            u(Quorum:Int),
            ActionState:ActionStateCell,
            .List, // TODO: Stack:List,
            ExternalCallEnv:ExternalCallEnvCell)
      </T>
      =>
      <T>
        performRhs(
            error,
            K,
            ?NumUsersFinal,
            ?UserIdToAddressFinal,
            ?AddressToUserIdFinal,
            ?NumBoardMembersFinal,
            ?NumProposersFinal,
            ?UserIdToRoleFinal,
            u(Quorum),
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
        andBool notBool
            ((Quorum <=Int NumBoardMembers -Int 1)
            andBool (NumBoardMembers -Int 1 +Int NumProposers >Int 0)
            )
    ensures performEnsures(
            ?NumUsersFinal,
            ?UserIdToAddressFinal,
            ?AddressToUserIdFinal,
            ?NumBoardMembersFinal,
            ?NumProposersFinal,
            ?UserIdToRoleFinal,
            u(Quorum))
endmodule
