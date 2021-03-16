require "../map/proof-map-semantics.k"

module PROOF-CAN-PROPOSE-AND-EXECUTE
  imports MAP-SEMANTICS
  imports PROPOSE-EXECUTE
  imports PSEUDOCODE

  imports TRUSTED-MAP-SEMANTICS

  claim <T><TT>
          <k> boardMembersSignFor(ActionIndex:Usize, PartialUserRoles:Map)
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
              (ActionIndex |-> _Action:KItem _ActionData:Map) #as ActionData:Map,
              ActionIndex |-> Signatures:ExpressionList ActionSigners:Map)
        </TT></T>
      =>
        <T><TT>
          <k> K:K </k>
          invariantState(
              NumUsers,
              UserIdToAddress,
              AddressToUserId,
              NumBoardMembers,
              NumProposers,
              UserRoles,
              Quorum,
              ActionLastIndex,
              ActionData,
              ActionIndex |-> ?Signatures ActionSigners):StateCell
        </TT></T>
    requires invariant(
            NumUsers,
            UserIdToAddress,
            AddressToUserId,
            NumBoardMembers,
            NumProposers,
            UserRoles,
            Quorum,
            ActionLastIndex,
            ActionData,
            ActionIndex |-> Signatures ActionSigners,
            expand(expanded))
        andBool newUserIdToRoleInvariant(PartialUserRoles, UserIdToAddress)
        // andBool valuesAreOfType(PartialUserRoles, rUserRole)
        // andBool valuesAreKResult(PartialUserRoles)
        // andBool keysAreOfType(PartialUserRoles, rUsize)
        // andBool keysAreKResult(PartialUserRoles)
        // andBool valuesAreNotEmpty(PartialUserRoles, rUserRole)
        // andBool allKeysBecomeKeys(PartialUserRoles, UserIdToAddress)

        andBool userIdToAddressInvariant(UserIdToAddress, AddressToUserId)
        // andBool valuesAreOfType(UserIdToAddress, rAddress)
        // andBool valuesAreKResult(UserIdToAddress)
        // andBool valuesAreNotEmpty(UserIdToAddress, rAddress)
        // andBool mapsAreReverse(UserIdToAddress, AddressToUserId)

        andBool mapsAreReverse(AddressToUserId, UserIdToAddress)

        andBool mapIncluded(PartialUserRoles, UserRoles)

        andBool valuesAreNotEmpty(ActionData, rAction)
        andBool noMapKeyInList(PartialUserRoles, Signatures)
    ensures invariant(
        NumUsers,
        UserIdToAddress,
        AddressToUserId,
        NumBoardMembers,
        NumProposers,
        UserRoles,
        Quorum,
        ActionLastIndex,
        ActionData,
        ActionIndex |-> ?Signatures ActionSigners,
        usesExpanded)
/*
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
*/
endmodule