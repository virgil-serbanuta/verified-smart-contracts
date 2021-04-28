//@ proof
require "../invariant/trusted-perform-parts-New.k"  //@ Bazel remove
require "../invariant/trusted-perform-parts-no-quorum.k"  //@ Bazel remove
require "../invariant/trusted-perform-parts-None.k"  //@ Bazel remove
require "../invariant/trusted-perform-parts-nothing.k"  //@ Bazel remove

module PROOF-PERFORM-ACTION
  imports INVARIANT-EXECUTION

  imports TRUSTED-PERFORM-PARTS-NEW
  imports TRUSTED-PERFORM-PARTS-NO-QUORUM
  imports TRUSTED-PERFORM-PARTS-NONE
  imports TRUSTED-PERFORM-PARTS-NOTHING
//@ trusted
// module TRUSTED-PERFORM-ACTION
//@ end
  imports MALICIOUS-USER-EXECUTE
  imports PSEUDOCODE-SYNTAX

    claim <T><TT>
        <k> runExternalCall(from MaliciousAddress run performActionEndpoint(_ActionId:Usize);) ~> K:K </k>
          invariantState(
              NumUsers:Usize,
              UserIdToAddress:Map,
              AddressToUserId:Map,
              NumBoardMembers:Usize,
              NumProposers:Usize,
              UserRoles:Map,
              Quorum:Usize,
              ActionLastIndex:Usize,
              ActionData:Map,
              ActionSigners:Map,
              PerformedActions:List)
        </TT></T>
      =>
        <T><TT>
          <k> K </k>
          invariantState(
              NumUsers,
              UserIdToAddress:Map,
              AddressToUserId:Map,
              NumBoardMembers,
              NumProposers,
              UserRoles,
              Quorum,
              ActionLastIndex:Usize,
              ActionData:Map,
              ActionSigners:Map,
              PerformedActions:List):StateCell
        </TT></T>
    requires true
        andBool maliciousInvariant(
            MaliciousAddress,
            NumUsers,
            UserIdToAddress,
            AddressToUserId,
            NumBoardMembers,
            NumProposers,
            UserRoles,
            Quorum,
            ActionLastIndex,
            ActionData,
            ActionSigners,
            expand(expanded))
    ensures true
        andBool maliciousInvariant(
            MaliciousAddress,
            NumUsers,
            UserIdToAddress,
            AddressToUserId,
            NumBoardMembers,
            NumProposers,
            UserRoles,
            Quorum,
            ActionLastIndex,
            ActionData,
            ActionSigners,
            usesExpanded)
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
