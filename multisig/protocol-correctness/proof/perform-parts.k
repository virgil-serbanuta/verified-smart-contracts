module PERFORM-PARTS

  imports EXECUTION-HELPERS
  imports PSEUDOCODE

  syntax Bool ::= performRequires(
      action:Action,
      numUsers:Usize,
      userIdToAddress:Map,
      addressToUserId:Map,
      numBoardMembers:Usize,
      numProposers:Usize,
      userIdToRole:Map,
      quorum:Usize)
    [function, functional]
  syntax Bool ::= performEnsures(
      numUsers:Usize,
      userIdToAddress:Map,
      addressToUserId:Map,
      numBoardMembers:Usize,
      numProposers:Usize,
      userIdToRole:Map,
      quorum:Usize)
    [function, functional]
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
      stack:List,
      ExternalCallEnvCell)
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
          stack:List,
          ExternalCallEnvCell)
      [function, functional]

  rule performRequires(
          Action:Action,
          u(NumUsers:Int) #as UNumUsers:Usize,
          UserIdToAddress:Map,
          AddressToUserId:Map,
          u(NumBoardMembers:Int),
          u(NumProposers:Int),
          UserIdToRole:Map,
          u(Quorum:Int))
    => true
      andBool isKResult(Action)

      andBool valuesAreOfType(AddressToUserId, rUsize)
      andBool valuesAreKResult(AddressToUserId)
      andBool valuesAreNotEmpty(AddressToUserId, rUsize)

      andBool valuesAreOfType(UserIdToRole, rUserRole)
      andBool valuesAreKResult(UserIdToRole)
      andBool valuesAreNotEmpty(UserIdToRole, rUserRole)
      andBool unusedIdsInMap(add(UNumUsers, u(1)), keysMap(UserIdToRole), u(1))

      andBool allValuesBecomeKeys(AddressToUserId, UserIdToAddress)
      andBool allValuesBecomeKeys(UserIdToAddress, AddressToUserId)

      andBool NumUsers >=Int 0 // TODO: Strict >?
      andBool NumBoardMembers >=Int 0
      andBool NumProposers >=Int 0

      andBool Quorum <=Int NumBoardMembers
      andBool (NumBoardMembers +Int NumProposers >Int 0)

  rule performEnsures(
          u(NumUsers:Int) #as UNumUsers:Usize,
          UserIdToAddress:Map,
          AddressToUserId:Map,
          u(NumBoardMembers:Int),
          u(NumProposers:Int),
          UserIdToRole:Map,
          u(Quorum:Int))
    => true
      andBool valuesAreOfType(AddressToUserId, rUsize)
      andBool valuesAreKResult(AddressToUserId)
      andBool valuesAreNotEmpty(AddressToUserId, rUsize)

      andBool valuesAreOfType(UserIdToRole, rUserRole)
      andBool valuesAreKResult(UserIdToRole)
      andBool valuesAreNotEmpty(UserIdToRole, rUserRole)
      andBool unusedIdsInMap(add(UNumUsers, u(1)), keysMap(UserIdToRole), u(-1))

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
          Stack:List,
          ExternalCallEnv:ExternalCallEnvCell)
        =>
        <TT>
          <k> call(performAction(Action)) ~> K </k>
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
              ActionState
            </multisig-state>
            <pseudocode-state>
              <variables>
                .Map
              </variables>
              <stack> Stack </stack>
            </pseudocode-state>
            ExternalCallEnv
            <proof-state>
              <last-instrumented> .K </last-instrumented>
            </proof-state>
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
          Stack:List,
          ExternalCallEnv:ExternalCallEnvCell)
        =>
        <TT>
          <k> Result ~> K </k>
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
              ActionState
            </multisig-state>
            <pseudocode-state>
              <variables>
                Variables
              </variables>
              <stack> Stack </stack>
            </pseudocode-state>
            ExternalCallEnv
            <proof-state>
              <last-instrumented> .K </last-instrumented>
            </proof-state>
          </state>
        </TT>

endmodule
