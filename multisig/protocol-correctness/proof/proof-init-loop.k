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
              .Map,  // TODO: Variables:Map,
              Stack:List,
              ExternalCallEnv:ExternalCallEnvCell,
              _Address0:Expression,
              _UserId0:Usize)
        </T>
      =>
        <T> initLoopRhs(
              K,
              ?UserIdToAddress1:Map,
              ?AddressToUserId1:Map,
              ?UserIdToRole1,
              Quorum,
              ActionState,
              .Map,  // TODO: Variables,
              Stack,
              ExternalCallEnv,
              add(PrevIndex, u(pListLen(Addresses))),
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
    ensures
        initLoopEnsures(
            add(add(PrevIndex, u(pListLen(Addresses))), u(1)),
            Addresses,
            ?UserIdToAddress1,
            ?AddressToUserId1,
            UserIdToRole0,
            ?UserIdToRole1)
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
              .Map,  // TODO: Variables:Map,
              Stack:List,
              ExternalCallEnv:ExternalCallEnvCell,
              _Address0:Expression,
              _UserId0:Usize)
        </T>
      =>
        <T> initLoopRhs(
              K,
              ?UserIdToAddress1:Map,
              ?AddressToUserId1:Map,
              ?UserIdToRole1,
              Quorum,
              ActionState,
              .Map,  // TODO: Variables,
              Stack,
              ExternalCallEnv,
              add(PrevIndex, u(pListLen(Addresses))),
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
    ensures
        initLoopEnsures(
            add(add(PrevIndex, u(pListLen(Addresses))), u(1)),
            Addresses,
            ?UserIdToAddress1,
            ?AddressToUserId1,
            UserIdToRole0,
            ?UserIdToRole1)

endmodule
