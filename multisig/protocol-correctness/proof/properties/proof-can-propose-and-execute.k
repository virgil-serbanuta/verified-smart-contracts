require "../map/proof-map-semantics.k"
require "proof-board-members-sign-for.k"

module PROOF-CAN-PROPOSE-AND-EXECUTE
  imports MAP-SEMANTICS
  imports PROPOSE-EXECUTE
  imports PSEUDOCODE
  imports TRUSTED-BOARD-MEMBERS-SIGN-FOR

  imports TRUSTED-MAP-SEMANTICS

  claim <T><TT>
          <k> pickBoardMemberOrProposer(UserIdToRole)
              ~> withPickedUserCall(proposeChangeQuorum(u(0)))
              ~> allBoardMembersSignFor(add(ActionLastIndex, u(1)))
              ~> pickBoardMemberOrProposer(UserIdToRole)
              ~> withPickedUserCall(performActionEndpoint(add(ActionLastIndex, u(1))))
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
              ActionSigners:Map)
        </TT></T>
      =>
        <T><TT>
          <k> .K </k>
          invariantState(
              NumUsers:Usize,
              UserIdToAddress:Map,
              AddressToUserId:Map,
              NumBoardMembers:Usize,
              NumProposers:Usize,
              UserRoles:Map,
              Quorum:Usize,
              add(ActionLastIndex, u(1)),
              ActionData:Map,
              ActionSigners:Map):StateCell
        </TT></T>
    requires invariant(
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
          expand(expanded))
      // TODO: Move everything below to the invariant.
      andBool valuesAreOfType(UserIdToAddress, rAddress)
      andBool valuesAreKResult(UserIdToAddress)

      andBool newUserIdToRoleInvariant(UserRoles, UserIdToAddress)
      andBool userIdToAddressInvariant(UserIdToAddress, AddressToUserId)
      andBool mapsAreReverse(AddressToUserId, UserIdToAddress)

      andBool valuesAreNotEmpty(ActionData, rAction)

    ensures invariant(  // TODO: I don't actually need the `ensures`
        NumUsers:Usize,
        UserIdToAddress:Map,
        AddressToUserId:Map,
        NumBoardMembers:Usize,
        NumProposers:Usize,
        UserRoles:Map,
        Quorum:Usize,
        add(ActionLastIndex, u(1)),
        ActionData:Map,
        ActionSigners:Map,
        usesExpanded)

endmodule