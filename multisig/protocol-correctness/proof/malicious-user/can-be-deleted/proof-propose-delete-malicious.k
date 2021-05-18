//@ proof

require "../../functions/trusted-propose-action-BoardMember.k"  //@ Bazel remove

module PROOF-PROPOSE-DELETE-MALICIOUS
  imports TRUSTED-PROPOSE-ACTION-BOARDMEMBER
//@ trusted
// module TRUSTED-PROPOSE-DELETE-MALICIOUS
//@ end
  imports CAN-BE-DELETED-EXECUTE-SYNTAX
  imports PSEUDOCODE-CONFIGURATION

  claim <T><TT>
          <k> pickOtherBoardMember(UserIdToRole, AddressToUserId, MaliciousAddress)
              ~> withPickedUserCall(proposeRemoveUser(MaliciousAddress))
              ~> K:K
          </k>
          invariantState(
              NumUsers:Usize,
              UserIdToAddress:Map,
              (MaliciousAddress |-> MaliciousId:Usize _AddressToUserId:Map) #as AddressToUserId:Map,
              NumBoardMembers:Usize,
              NumProposers:Usize,
              (MaliciousId |-> _Role:UserRole UserIdToRoleFinal:Map) #as UserIdToRole:Map,
              u(Quorum:Int),
              u(ActionLastIndex:Int),
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
              UserIdToRole,
              u(Quorum),
              u(ActionLastIndex +Int 1),
              u(ActionLastIndex +Int 1) |-> RemoveUser(MaliciousAddress) ActionData,
              (u(ActionLastIndex +Int 1) |-> [?SomeId:Usize, .]) ActionSigners,
              PerformedActions:List):StateCell
        </TT></T>
    requires true
        andBool maliciousDeleteInvariant(
            MaliciousAddress,
            NumUsers,
            UserIdToAddress,
            AddressToUserId,
            NumBoardMembers,
            NumProposers,
            UserIdToRole,
            u(Quorum),
            u(ActionLastIndex),
            ActionData,
            ActionSigners,
            expand(expanded))
    ensures true
        andBool maliciousDeleteInvariant(
            MaliciousAddress,
            NumUsers,
            UserIdToAddress,
            AddressToUserId,
            NumBoardMembers,
            NumProposers,
            UserIdToRoleFinal,
            u(Quorum),
            u(ActionLastIndex +Int 1),
            u(ActionLastIndex +Int 1) |-> RemoveUser(MaliciousAddress) ActionData,
            (u(ActionLastIndex +Int 1) |-> [?SomeId:Usize, .]) ActionSigners,
            usesExpanded)
        andBool notBool ?SomeId ==K MaliciousId
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
