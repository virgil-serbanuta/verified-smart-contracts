module TRUSTED-PERFORM-REMOVE-USER-4
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
            (UserId |-> UserRole:KItem _UserIdToRole:Map) #as UserIdToRole:Map,
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
            ?_NumUsers,
            ?_UserIdToAddress,
            ?_AddressToUserId,
            ?_NumBoardMembers,
            ?_NumProposers,
            ?_UserIdToRole,
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
        andBool notBool (NumBoardMembers +Int (NumProposers -Int 1) >Int 0)
    [trusted]
endmodule

module PROOF-PERFORM-REMOVE-USER-4
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
            (UserId |-> UserRole:KItem _UserIdToRole:Map) #as UserIdToRole:Map,
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
            ?_NumUsers,
            ?_UserIdToAddress,
            ?_AddressToUserId,
            ?_NumBoardMembers,
            ?_NumProposers,
            ?_UserIdToRole,
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
        andBool notBool (NumBoardMembers +Int (NumProposers -Int 1) >Int 0)

endmodule
