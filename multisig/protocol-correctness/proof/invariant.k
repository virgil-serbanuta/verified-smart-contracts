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
            <user-id-to-address>UserIdToAddress</user-id-to-address>
            <address-to-user-id>AddressToUserId</address-to-user-id>
          </users>
          <board-state>
            <num-board-members>NumBoardMembers</num-board-members>
            <num-proposers>NumProposers</num-proposers>
            <user-roles>UserIdToRole</user-roles>
            <quorum>Quorum</quorum>
          </board-state>
          <action-state>
            <action-last-index>ActionLastIndex</action-last-index>
            <actions>
              <action-data>ActionData</action-data>
              <action-signers>ActionSigners</action-signers>
            </actions>
          </action-state>
        </multisig-state>
        <pseudocode-state>
          <variables>.Map</variables>
          <stack> .List </stack>
        </pseudocode-state>
        <external-call-env>
          <caller-address>uninitialized</caller-address>
        </external-call-env>
        <proof-state>
          <last-instrumented> .K </last-instrumented>
        </proof-state>
      </state>

  syntax Bool ::= invariant(
      numUsers:Usize,
      userIdToAddress:Map,
      addressToUserId:Map,
      numBoardMembers:Usize,
      numProposers:Usize,
      userIdToRole:Map,
      quorum:Usize,
      actionLastIndex:Usize,
      actionData:Map,
      actionSigners:Map,
      expandActionLastIndex:Usize)  [function, functional]

  rule invariant(
      u(NumUsers:Int),
      UserIdToAddress:Map,
      AddressToUserId:Map,
      u(NumBoardMembers:Int),
      u(NumProposers:Int),
      UserIdToRole:Map,
      u(Quorum:Int),
      ActionLastIndex:Usize,
      ActionData:Map,
      ActionSigners:Map,
      u(ExpandActionLastIndex):Usize)
    => true
      andBool unusedIdsInMapKeys(add(ActionLastIndex, u(1)), keysMap(ActionData), u(ExpandActionLastIndex))
      andBool unusedIdsInMapKeys(add(ActionLastIndex, u(1)), keysMap(ActionSigners), u(ExpandActionLastIndex))
      andBool maxMapKey(ActionLastIndex, keysMap(ActionData))
      andBool maxMapKey(ActionLastIndex, keysMap(ActionSigners))

      andBool valuesAreExpressionListOfUsize(ActionSigners)
      andBool valuesAreKResult(ActionSigners)

      andBool valuesAreOfType(ActionData, rAction)
      andBool valuesAreKResult(ActionData)

  syntax Bool ::= subset(Map, Map)  [function, functional]
  rule subset(K:KItem |-> _:KItem M:Map, N:Map)
      => K in_keys(N) andBool subset(M, N)
    [simplification]
  rule subset(M:Map, _:KItem |-> _:KItem N:Map)
      => true
    requires subset(M, N)
    [simplification]

  syntax Bool ::= maxMapKey(lastIndex:Usize, Map)  [function, functional]
  rule maxMapKey(_:Usize, .Map) => true
  rule maxMapKey(u(V:Int), u(K:Int) |-> _:KItem M:Map)
      => (K <=Int V) andBool maxMapKey(u(V), M)
  rule maxMapKey(u(V:Int), u(K:Int) |-> _:KItem M:Map)
      => (K <=Int V) andBool maxMapKey(u(V), M)
    [simplification]
  rule maxMapKey(u(V:Int +Int 1), M:Map)
      => true
    requires maxMapKey(u(V:Int), M:Map)
    [simplification]

endmodule
