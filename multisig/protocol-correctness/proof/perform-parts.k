module PERFORM-PARTS

  imports EXECUTION-HELPERS
  imports PSEUDOCODE

  syntax TTCell ::= performLhs(
      action:Action,
      K,
      numUsers:Usize,
      userIdToAddress:Map,
      addressToUserId:Map,
      numBoardMembers:Usize,
      numProposers:Usize,
      userIdToRole:Map,
      quorum:Usize,
      ActionStateCell,
      stack:List)
    [function, functional]
  syntax TTCell ::= performRhs(
          result:KItem,
          K,
          numUsers:Usize,
          userIdToAddress:Map,
          addressToUserId:Map,
          numBoardMembers:Usize,
          numProposers:Usize,
          userIdToRole:Map,
          quorum:Usize,
          ActionStateCell,
          variables:Map,
          stack:List)
      [function, functional]

  rule performLhs(
          Action:Action,
          K:K,
          NumUsers:Usize,
          UserIdToAddress:Map,
          AddressToUserId:Map,
          NumBoardMembers:Usize,
          NumProposers:Usize,
          UserIdToRole:Map,
          Quorum:Usize,
          ActionState:ActionStateCell,
          Stack:List)
        =>
        <TT>
          <k> call(performAction(Action)) ~> K </k>
          <state>
            <multisig-state>
              <users>
                <num-users>NumUsers</num-users>
                <address-to-user-id>AddressToUserId</address-to-user-id>
              </users>
              ActionState
            </multisig-state>
            <pseudocode-state>
              <variables>
                .Map
              </variables>
              <stack> Stack </stack>
            </pseudocode-state>
          </state>
        </TT>

  rule performRhs(
          Result:KItem,
          K:K,
          NumUsers:Usize,
          UserIdToAddress:Map,
          AddressToUserId:Map,
          NumBoardMembers:Usize,
          NumProposers:Usize,
          UserIdToRole:Map,
          Quorum:Usize,
          ActionState:ActionStateCell,
          Variables:Map,
          Stack:List)
        =>
        <TT>
          <k> Result ~> K </k>
          <state>
            <multisig-state>
              <users>
                <num-users>NumUsers</num-users>
                <address-to-user-id>AddressToUserId</address-to-user-id>
              </users>
              ActionState
            </multisig-state>
            <pseudocode-state>
              <variables>
                Variables
              </variables>
              <stack> Stack </stack>
            </pseudocode-state>
          </state>
        </TT>

endmodule
