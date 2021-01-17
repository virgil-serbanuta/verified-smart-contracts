require "proof-count-can-sign.k"

module PROOF-DISCARD-ACTION
  imports EXECUTION
  imports PSEUDOCODE
  imports TRUSTED-COUNT-CAN-SIGN

  claim <T><TT>
          <k> runExternalCalls(
                  (   from _:Address run discardAction(ActionId:Usize);
                      EC:ExternalCommands
                  )
              )
          </k>
          invariantState(
              NumUsers:Usize,
              UserIdToAddress:Map,
              AddressToUserId:Map,
              NumBoardMembers:Usize,
              NumProposers:Usize,
              UserRoles:Map,
              Quorum:Usize,
              ActionLastIndex0:Usize,
              ActionData0:Map,
              ActionSigners0:Map)
        </TT></T>
      =>
        <T><TT>
          <k> runExternalCalls(EC) </k>
          invariantState(
              NumUsers,
              UserIdToAddress,
              AddressToUserId,
              NumBoardMembers,
              NumProposers,
              UserRoles,
              Quorum,
              ?ActionLastIndex1:Usize,
              ?ActionData1:Map,
              ?ActionSigners1:Map):StateCell
        </TT></T>
    requires invariant(
        NumUsers,
        UserIdToAddress,
        AddressToUserId,
        NumBoardMembers,
        NumProposers,
        UserRoles,
        Quorum,
        ActionLastIndex0,
        ActionData0,
        ActionSigners0,
        u(1))
    ensures invariantDebug(
        NumUsers,
        UserIdToAddress,
        AddressToUserId,
        NumBoardMembers,
        NumProposers,
        UserRoles,
        Quorum,
        ?ActionLastIndex1:Usize,
        ?ActionData1:Map,
        ?ActionSigners1:Map,
        u(-1))  // TODO: Unsigned, should use other convention.
endmodule
