require "trusted-discard-action-3.k"  //@ Bazel remove
require "../functions/trusted-discard-action-no-role-marker.k"  //@ Bazel remove
require "../functions/trusted-discard-action-no-user-marker.k"  //@ Bazel remove

module PROOF-DISCARD-ACTION
  imports INVARIANT-EXECUTION
  imports PSEUDOCODE

  imports TRUSTED-DISCARD-ACTION-3
  imports TRUSTED-DISCARD-ACTION-NO-ROLE-MARKER
  imports TRUSTED-DISCARD-ACTION-NO-USER-MARKER

  claim <T><TT>
          <k> runExternalCalls(
                  (   from _:Address run discardAction(_ActionId:Usize);
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
              ActionSigners0:Map,
              PerformedActions:List)
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
              ?ActionSigners1:Map,
              PerformedActions:List):StateCell
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
        expand(expanded))
    ensures invariant(
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
        usesExpanded)
endmodule
