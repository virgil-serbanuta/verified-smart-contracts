module TRUSTED-INIT-LOOP
  imports EXECUTION
  imports INIT-LOOP-PARTS
  imports PSEUDOCODE

  claim <T> initLoopLhs(
              PrevIndex:Usize,
              Addresses:ExpressionList,
              K:K,
              UserIdToAddress0:Map,
              AddressToUserId0:Map,
              UserIdToRole0:Map,
              Quorum:Usize,
              ActionState:ActionStateCell,
              Variables:Map,
              Stack:List,
              ExternalCallEnv:ExternalCallEnvCell,
              _Address0:Expression,
              _UserId0:Usize)
        </T>
      =>
        <T> initLoopRhs(
              K,
              ?_UserIdToAddress1:Map,
              ?_AddressToUserId1:Map,
              ?_UserRoles1,
              Quorum,
              ActionState,
              Variables,
              Stack,
              ExternalCallEnv,
              ?_Index1:Usize,
              ?_Address1:Expression,
              ?_UserId1:Usize)
        </T>
    requires
        initLoopRequires(
            PrevIndex,
            Addresses,
            UserIdToAddress0,
            AddressToUserId0,
            UserIdToRole0)
    [trusted]
endmodule

module PROOF-INIT-LOOP
  imports INIT-LOOP-PARTS

  claim <T> initLoopLhs(
              PrevIndex:Usize,
              Addresses:ExpressionList,
              K:K,
              UserIdToAddress0:Map,
              AddressToUserId0:Map,
              UserIdToRole0:Map,
              Quorum:Usize,
              ActionState:ActionStateCell,
              Variables:Map,
              Stack:List,
              ExternalCallEnv:ExternalCallEnvCell,
              _Address0:Expression,
              _UserId0:Usize)
        </T>
      =>
        <T> initLoopRhs(
              K,
              ?_UserIdToAddress1:Map,
              ?_AddressToUserId1:Map,
              ?_UserRoles1,
              Quorum,
              ActionState,
              Variables,
              Stack,
              ExternalCallEnv,
              ?_Index1:Usize,
              ?_Address1:Expression,
              ?_UserId1:Usize)
        </T>
    requires
        initLoopRequires(
            PrevIndex,
            Addresses,
            UserIdToAddress0,
            AddressToUserId0,
            UserIdToRole0)

endmodule
