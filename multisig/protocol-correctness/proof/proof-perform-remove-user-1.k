module PROOF-PERFORM-REMOVE-USER-1
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
            evaluate(void),
            K,
            ?_NumUsers,
            ?_UserIdToAddress,
            ?_AddressToUserId,
            ?_NumBoardMembers,
            ?_NumProposers,
            ?_UserIdToRole,
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
        andBool Quorum <=Int NumBoardMembers -Int 1
        andBool (NumBoardMembers -Int 1 +Int NumProposers >Int 0)

endmodule
