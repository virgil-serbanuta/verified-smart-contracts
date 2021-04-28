//@ proof
require "protocol-correctness/proof/functions/trusted-discard-action-has-signers.k"  //@ Bazel remove
require "protocol-correctness/proof/functions/trusted-discard-action-no-role-marker.k"  //@ Bazel remove
require "protocol-correctness/proof/functions/trusted-discard-action-no-signers.k"  //@ Bazel remove
require "protocol-correctness/proof/functions/trusted-discard-action-no-signers-no-action.k"  //@ Bazel remove
require "protocol-correctness/proof/functions/trusted-discard-action-no-user-marker.k"  //@ Bazel remove
require "protocol-correctness/proof/functions/trusted-discard-action-no-valid-signers.k"  //@ Bazel remove
require "protocol-correctness/proof/functions/trusted-discard-action-no-valid-signers-no-action.k"  //@ Bazel remove

module PROOF-DISCARD-ACTION
  imports TRUSTED-DISCARD-ACTION-HAS-SIGNERS
  imports TRUSTED-DISCARD-ACTION-NO-ROLE-MARKER
  imports TRUSTED-DISCARD-ACTION-NO-SIGNERS
  imports TRUSTED-DISCARD-ACTION-NO-SIGNERS-NO-ACTION
  imports TRUSTED-DISCARD-ACTION-NO-USER-MARKER
  imports TRUSTED-DISCARD-ACTION-NO-VALID-SIGNERS
  imports TRUSTED-DISCARD-ACTION-NO-VALID-SIGNERS-NO-ACTION
//@ trusted
// module TRUSTED-DISCARD-ACTION
//@ end
  imports MALICIOUS-USER-EXECUTE
  imports PSEUDOCODE

  claim <T><TT>
          <k> runExternalCall(from MaliciousAddress run discardAction(_ActionId:Usize);) ~> K:K </k>
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
              ?ActionData:Map,
              ?ActionSigners:Map,
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
            ?ActionData,
            ?ActionSigners,
            usesExpanded)
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
