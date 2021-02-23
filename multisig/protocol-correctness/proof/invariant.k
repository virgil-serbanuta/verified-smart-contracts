module INVARIANT
  imports EXECUTION-HELPERS
  imports PSEUDOCODE

  syntax StateCell ::= invariantState(
      numUsers:Usize,
      userIdToAddress:Map,
      addressToUserId:Map,
      numBoardMembers:Usize,
      numProposers:Usize,
      userIdToRole:Map,
      quorum:Usize,
      actionLastIndex:Usize,
      actionData:Map,
      actionSigners:Map)  [function, functional]

  rule invariantState(
      NumUsers:Usize,
      UserIdToAddress:Map,
      AddressToUserId:Map,
      NumBoardMembers:Usize,
      NumProposers:Usize,
      UserIdToRole:Map,
      Quorum:Usize,
      ActionLastIndex:Usize,
      ActionData:Map,
      ActionSigners:Map)
    =>
      <state>
        <multisig-state>
          <users>
            <num-users>NumUsers</num-users>
            <address-to-user-id>AddressToUserId</address-to-user-id>
          </users>
          <action-state>
            <actions>
              <action-data>ActionData</action-data>
            </actions>
          </action-state>
        </multisig-state>
        <pseudocode-state>
          <variables>.Map</variables>
          <stack> .List </stack>
        </pseudocode-state>
      </state>

endmodule
