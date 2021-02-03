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
      _NumUsers:Usize,
      UserIdToAddress:Map,
      AddressToUserId:Map,
      u(_NumBoardMembers:Int),
      u(_NumProposers:Int),
      UserIdToRole:Map,
      u(_Quorum:Int),
      ActionLastIndex:Usize,
      ActionData:Map,
      ActionSigners:Map,
      ExpandActionLastIndex:Usize)
    => notBool u(0) in_keys(UserIdToAddress)
      andBool notBool u(0) in_keys(UserIdToRole)
      andBool allValuesBecomeKeys(AddressToUserId, UserIdToAddress)
      andBool unusedIdsInMap(add(ActionLastIndex, u(1)), keysMap(ActionData), ExpandActionLastIndex)
      andBool unusedIdsInMap(add(ActionLastIndex, u(1)), keysMap(ActionSigners), ExpandActionLastIndex)
      andBool maxMapKey(ActionLastIndex, keysMap(ActionData))
      andBool maxMapKey(ActionLastIndex, keysMap(ActionSigners))

      andBool valuesAreExpressionListOfUsize(ActionSigners)
      andBool valuesAreKResult(ActionSigners)

      andBool valuesAreOfType(AddressToUserId, rUsize)
      andBool valuesAreKResult(AddressToUserId)

      andBool valuesAreOfType(UserIdToRole, rUserRole)
      andBool valuesAreKResult(UserIdToRole)

      andBool valuesAreOfType(ActionData, rAction)
      andBool valuesAreKResult(ActionData)

      //andBool 0 <=Int NumBoardMembers
      //andBool 0 <Int NumBoardMembers +Int NumProposers
      //andBool Quorum <=Int NumBoardMembers +Int NumProposers


  syntax Bool ::= invariantDebug(
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

  rule invariantDebug(
      _NumUsers:Usize,
      UserIdToAddress:Map,
      AddressToUserId:Map,
      u(_NumBoardMembers:Int),
      u(_NumProposers:Int),
      UserIdToRole:Map,
      u(_Quorum:Int),
      ActionLastIndex:Usize,
      ActionData:Map,
      ActionSigners:Map,
      ExpandActionLastIndex:Usize)
    => notBool u(0) in_keys(UserIdToAddress)
      andBool notBool u(0) in_keys(UserIdToRole)  // +
      andBool allValuesBecomeKeys(AddressToUserId, UserIdToAddress)  // +
      andBool unusedIdsInMap(add(ActionLastIndex, u(1)), keysMap(ActionData), ExpandActionLastIndex)
      // andBool unusedIdsInMap(add(ActionLastIndex, u(1)), keysMap(ActionSigners), ExpandActionLastIndex)
      //-
      // andBool maxMapKey(ActionLastIndex, keysMap(ActionData))
      // andBool maxMapKey(ActionLastIndex, keysMap(ActionSigners))

      //-

      // andBool valuesAreExpressionListOfUsize(ActionSigners)
      // andBool valuesAreKResult(ActionSigners)

      // andBool valuesAreOfType(AddressToUserId, rUsize)
      // andBool valuesAreKResult(AddressToUserId)

      // andBool valuesAreOfType(UserIdToRole, rUserRole)
      // andBool valuesAreKResult(UserIdToRole)

      // andBool valuesAreOfType(ActionData, rAction)
      // andBool valuesAreKResult(ActionData)

      //-

      //andBool 0 <=Int NumBoardMembers
      //andBool 0 <Int NumBoardMembers +Int NumProposers
      //andBool Quorum <=Int NumBoardMembers +Int NumProposers

  syntax Bool ::= invariantDebug1(
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

  rule invariantDebug1(
      _NumUsers:Usize,
      UserIdToAddress:Map,
      AddressToUserId:Map,
      u(_NumBoardMembers:Int),
      u(_NumProposers:Int),
      UserIdToRole:Map,
      u(_Quorum:Int),
      ActionLastIndex:Usize,
      ActionData:Map,
      ActionSigners:Map,
      ExpandActionLastIndex:Usize)
    => notBool u(0) in_keys(UserIdToAddress)
      andBool notBool u(0) in_keys(UserIdToRole)
      andBool allValuesBecomeKeys(AddressToUserId, UserIdToAddress)
      andBool allValuesBecomeKeys(AddressToUserId, UserIdToRole)
      andBool unusedIdsInMap(add(ActionLastIndex, u(1)), keysMap(ActionData), ExpandActionLastIndex)
      andBool unusedIdsInMap(add(ActionLastIndex, u(1)), keysMap(ActionSigners), ExpandActionLastIndex)
      andBool maxMapKey(ActionLastIndex, keysMap(ActionData))
      andBool maxMapKey(ActionLastIndex, keysMap(ActionSigners))
      // andBool subset(keysMap(ActionSigners), keysMap(ActionData))

      andBool valuesAreExpressionListOfUsize(ActionSigners)
      andBool valuesAreKResult(ActionSigners)

      andBool valuesAreOfType(AddressToUserId, rUsize)
      andBool valuesAreKResult(AddressToUserId)

      andBool valuesAreOfType(UserIdToRole, rUserRole)
      andBool valuesAreKResult(UserIdToRole)

      andBool valuesAreOfType(ActionData, rAction)
      andBool valuesAreKResult(ActionData)

      //andBool 0 <=Int NumBoardMembers
      //andBool 0 <Int NumBoardMembers +Int NumProposers
      //andBool Quorum <=Int NumBoardMembers +Int NumProposers

  syntax Bool ::= allValuesBecomeKeys(Map, Map)  [function, functional]
  rule allValuesBecomeKeys(_ |-> V M:Map, N:Map)
      => V in_keys(N) andBool allValuesBecomeKeys(M, N)
    [simplification]

  syntax Bool ::= subset(Map, Map)  [function, functional]
  rule subset(K:KItem |-> _:KItem M:Map, N:Map)
      => K in_keys(N) andBool subset(M, N)
    [simplification]
  rule subset(M:Map, _:KItem |-> _:KItem N:Map)
      => true
    requires subset(M, N)
    [simplification]

  syntax Map ::= keysMap(Map)  [function, functional]
  rule keysMap(K:KItem |-> _:KItem M:Map) => K |-> 0 keysMap(M)
    [simplification]

  syntax Bool ::= maxMapKey(lastIndex:Usize, Map)  [function, functional]
  //rule maxMapKey(_:Usize, .Set) => true
  rule maxMapKey(u(V:Int), u(K:Int) |-> _:KItem M:Map)
      => (K <=Int V) andBool maxMapKey(u(V), M)
  rule maxMapKey(u(V:Int), u(K:Int) |-> _:KItem M:Map)
      => (K <=Int V) andBool maxMapKey(u(V), M)
    [simplification]
  rule maxMapKey(u(V:Int +Int 1), M:Map)
      => true
    requires maxMapKey(u(V:Int), M:Map)
    [simplification]

  // expand is a stupid trick used to control symbolic function application.
  syntax Bool ::= unusedIdsInMap(lastIndex:Usize, Map, expand:Usize)  [function, functional]

  rule unusedIdsInMap(LastIndex:Usize, M:Map, u(Expand:Int))
      => #unusedIdsInMap(LastIndex, M, Expand)

  syntax Bool ::= #unusedIdsInMap(lastIndex:Usize, Map, expand:Int)  [function, functional]

  /*
  rule #unusedIdsInMap(_LastIndex:Usize, .Set, _Expand:Int) => true
  rule #unusedIdsInMap(u(LastIndex:Int), SetItem(u(K:Int)) S:Set, Expand:Int)
    => LastIndex >Int K
        andBool #unusedIdsInMap(u(LastIndex), S, Expand)
  */

  rule #unusedIdsInMap(u(LastIndex:Int), u(K:Int) |-> _:KItem M:Map, Expand:Int)
    => #unusedIdsInMap(u(LastIndex), M, Expand) andBool LastIndex >Int K
    [simplification]

  rule #unusedIdsInMap(u(LastIndex:Int), u(K:Int) |-> _:KItem M:Map, -1)
    => #unusedIdsInMap(u(LastIndex), M, -1)
    requires LastIndex >Int K
    [simplification]

  rule #unusedIdsInMap(LastIndex:Usize, M:Map, Expand:Int)
    => notBool LastIndex in_keys(M)
      andBool #unusedIdsInMap(add(LastIndex, u(1)), M, Expand -Int 1)
    requires Expand >Int 0
    [simplification]

  rule #unusedIdsInMap(LastIndex:Usize, M:Map, -1)
    => true
    requires #unusedIdsInMap(LastIndex, M, 0)
    [simplification]

  rule #unusedIdsInMap(LastIndex:Usize, M:Map, -1)
    => true
    requires notBool LastIndex in_keys(M)
      andBool #unusedIdsInMap(add(LastIndex, u(1)), M, 0)
    [simplification]

  rule #unusedIdsInMap(LastIndex:Usize, M:Map, -1)
    => true
    requires notBool LastIndex in_keys(M)
      andBool notBool add(LastIndex, u(1)) in_keys(M)
      andBool #unusedIdsInMap(add(LastIndex, u(2)), M, 0)
    [simplification]

  rule isKResult(#pushList(Es:ExpressionCSV, E:Expression))
    => isKResult(Es) andBool isKResult(E)
    [simplification]

  rule listElementsAreUsize([#pushList(Es:ExpressionCSV, E:Expression)])
    => listElementsAreUsize([Es]) andBool isUsize(E)
    [simplification]

  rule isKResult(#listSwapRemove(Es:ExpressionCSV, _:Int))
    => isKResult(Es)
    [simplification]

  rule listElementsAreUsize([#listSwapRemove(Es:ExpressionCSV, _:Int)])
    => listElementsAreUsize([Es])
    [simplification]

endmodule
