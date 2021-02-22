require "proof-perform-add-board-member.k"
require "proof-perform-add-proposer.k"
require "proof-perform-change-quorum.k"
require "proof-perform-nothing.k"
require "proof-perform-remove-user-1.k"
require "proof-perform-remove-user-2.k"
require "proof-perform-remove-user-3.k"
require "proof-perform-remove-user-4.k"
require "proof-perform-remove-user-5.k"
require "proof-perform-remove-user-6.k"
require "proof-perform-s-c-call.k"
require "proof-perform-s-c-deploy.k"
require "proof-perform-send-egld.k"

module PROOF-PERFORM-ACTION-ENDPOINT
  imports EXECUTION
  imports PSEUDOCODE

  imports TRUSTED-PERFORM-ADD-PROPOSER  // +
  imports TRUSTED-PERFORM-CHANGE-QUORUM
  imports TRUSTED-PERFORM-NOTHING
  imports TRUSTED-PERFORM-REMOVE-USER-5
  imports TRUSTED-PERFORM-REMOVE-USER-6

  claim <T><TT>
          <k> runInstruction(performActionFromId(ActionId:Usize);) ~> K:K
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
          <k> K </k>
          invariantState(
              ?NumUsers1:Usize,
              ?UserIdToAddress1:Map,
              ?AddressToUserId1:Map,
              ?NumBoardMembers1:Usize,
              ?NumProposers1:Usize,
              ?UserRoles1:Map,
              ?Quorum1:Usize,
              ?ActionLastIndex1:Usize,
              ?ActionData1:Map,
              ?ActionSigners1:Map):StateCell
        </TT></T>
    requires invariant(
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
        u(1))
    ensures invariantDebug(
        ?NumUsers1:Usize,
        ?UserIdToAddress1:Map,
        ?AddressToUserId1:Map,
        ?NumBoardMembers1:Usize,
        ?NumProposers1:Usize,
        ?UserRoles1:Map,
        ?Quorum1:Usize,
        ?ActionLastIndex1:Usize,
        ?ActionData1:Map,
        ?ActionSigners1:Map,
        u(-1))  // TODO: Unsigned, should use other convention.
endmodule
