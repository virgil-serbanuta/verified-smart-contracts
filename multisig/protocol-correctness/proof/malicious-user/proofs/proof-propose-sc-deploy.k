//@ proof
require "../functions/trusted-propose-sc-deploy-BoardMember.k"  //@ Bazel remove
require "../functions/trusted-propose-sc-deploy-Proposer.k"  //@ Bazel remove
require "../functions/trusted-propose-sc-deploy-error-no-user.k"  //@ Bazel remove
require "../functions/trusted-propose-sc-deploy-error-no-role.k"  //@ Bazel remove

module PROOF-PROPOSE-SC-DEPLOY
  imports TRUSTED-PROPOSE-SC-DEPLOY-ERROR-NO-USER
  imports TRUSTED-PROPOSE-SC-DEPLOY-ERROR-NO-ROLE
  imports TRUSTED-PROPOSE-SC-DEPLOY-BOARDMEMBER
  imports TRUSTED-PROPOSE-SC-DEPLOY-PROPOSER
//@ trusted
// module TRUSTED-PROPOSE-SC-DEPLOY
//@ end
  imports MALICIOUS-USER-EXECUTE
  imports PSEUDOCODE

  claim <T><TT>
          <k> runExternalCall(from MaliciousAddress run proposeSCDeploy(
                  _Amount:BigUint,
                  _Code:BoxedBytes,
                  _Upgradeable:Bool,
                  _Payable:Bool,
                  _Readable:Bool,
                  Args:ExpressionList);)
              ~> K:K
          </k>
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
              ?UserIdToAddress:Map,
              ?AddressToUserId:Map,
              NumBoardMembers,
              NumProposers,
              UserRoles,
              Quorum,
              ?ActionLastIndex:Usize,
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
        andBool isKResult(Args)
    ensures true
        andBool maliciousInvariant(
            MaliciousAddress,
            NumUsers,
            ?UserIdToAddress,
            ?AddressToUserId,
            NumBoardMembers,
            NumProposers,
            UserRoles,
            Quorum,
            ?ActionLastIndex,
            ?ActionData,
            ?ActionSigners,
            usesExpanded)
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
