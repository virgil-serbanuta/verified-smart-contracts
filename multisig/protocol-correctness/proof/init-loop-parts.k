module INIT-LOOP-PARTS
  imports PSEUDOCODE
  imports EXECUTION-HELPERS

  syntax TTCell ::= initLoopLhs(
            prevIndex:Usize,
            addresses:ExpressionList,
            K,
            userIdToAddress:Map,
            addressToUserId:Map,
            userIdToRole:Map,
            quorum:Usize,
            ActionStateCell,
            variables:Map,
            stack:List,
            ExternalCallEnvCell,
            address:Expression,
            userId:Usize)
      [function, functional]
  rule initLoopLhs(
            PrevIndex:Usize,
            Addresses:ExpressionList,
            K:K,
            UserIdToAddress0:Map,
            AddressToUserId0:Map,
            UserIdToRole0:Map,
            Quorum:Usize,
            ActionState:ActionStateCell,
            Variables:Map,
            Stack:List,
            ExternalCallEnv:ExternalCallEnvCell,
            Address:Expression,
            UserId:Usize)
      => <TT>
          <k>
            runInstruction(
                for (i = add(PrevIndex, u(1)), address ) in Addresses {
                    user_id = i + u(1);
                    require(getUserId(address) == u(0));
                    setUserId(address, user_id);
                    setUserAddress(user_id, address);
                    setUserIdToRole(user_id, BoardMember);
                }
            )
            ~> K
          </k>
          <state>
            <multisig-state>
              <users>
                <num-users>u(0)</num-users>
                <user-id-to-address>UserIdToAddress0</user-id-to-address>
                <address-to-user-id>AddressToUserId0</address-to-user-id>
              </users>
              <board-state>
                <num-board-members>u(0)</num-board-members>
                <num-proposers>u(0)</num-proposers>
                <user-roles>UserIdToRole0</user-roles>
                <quorum>Quorum</quorum>
              </board-state>
              ActionState
            </multisig-state>
            <pseudocode-state>
              <variables>
                i |-> PrevIndex
                address |-> Address
                user_id |-> UserId
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

  syntax TTCell ::= initLoopRhs(
            K,
            userIdToAddress:Map,
            addressToUserId:Map,
            userIdToRole:Map,
            quorum:Usize,
            ActionStateCell,
            variables:Map,
            stack:List,
            ExternalCallEnvCell,
            index:Usize,
            address:Expression,
            userId:Usize)
      [function, functional]
  rule initLoopRhs(
            K:K,
            UserIdToAddress1:Map,
            AddressToUserId1:Map,
            UserIdToRole1:Map,
            Quorum:Usize,
            ActionState:ActionStateCell,
            Variables:Map,
            Stack:List,
            ExternalCallEnv:ExternalCallEnvCell,
            Index:Usize,
            Address:Expression,
            UserId:Usize)
      => 
        <TT>
          <k> evaluate(void) ~> K </k>
          <state>
            <multisig-state>
              <users>
                <num-users>u(0)</num-users>
                <user-id-to-address>UserIdToAddress1</user-id-to-address>
                <address-to-user-id>AddressToUserId1:Map</address-to-user-id>
              </users>
              <board-state>
                <num-board-members>u(0)</num-board-members>
                <num-proposers>u(0)</num-proposers>
                <user-roles>UserIdToRole1</user-roles>
                <quorum>Quorum</quorum>
              </board-state>
              ActionState
            </multisig-state>
            <pseudocode-state>
              <variables>
                (i |-> Index)
                (address |-> Address)
                (user_id |-> UserId)
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

  syntax Bool ::= initLoopRequires(
            prevIndex:Usize,
            addresses:ExpressionList,
            userIdToAddress:Map,
            addressToUserId:Map,
            userIdToRole:Map)
      [function, functional]
  rule initLoopRequires(
            u(PrevIndex:Int),
            Addresses:ExpressionList,
            UserIdToAddress0:Map,
            AddressToUserId0:Map,
            UserIdToRole0:Map)
      => true
            andBool PrevIndex >=Int 0
            andBool isKResult(Addresses)

            andBool noCommonItem(add(u(PrevIndex), u(2)), AddressToUserId0, Addresses)
            andBool noReusedIndexAddress(add(u(PrevIndex), u(2)), UserIdToAddress0, Addresses)
            andBool noReusedIndexRole(add(u(PrevIndex), u(2)), UserIdToRole0, Addresses)
            andBool listElementsAreAddresses(Addresses)

            andBool initLoopInvariant(
                        add(u(PrevIndex), u(1)),
                        UserIdToAddress0,
                        AddressToUserId0,
                        UserIdToRole0,
                        1)

  syntax Bool ::= initLoopEnsures(
      numUsers:Usize,
      addresses:ExpressionList,
      userIdToAddress:Map,
      addressToUserId:Map,
      userIdToRole0:Map,
      userIdToRole:Map)  [function, functional]

  rule initLoopEnsures(
      NumUsers:Usize,
      Addresses:ExpressionList,
      UserIdToAddress:Map,
      AddressToUserId:Map,
      UserIdToRole0:Map,
      UserIdToRole:Map)
    => true
      andBool initLoopInvariant(
                  NumUsers,
                  UserIdToAddress,
                  AddressToUserId,
                  UserIdToRole,
                  -1)
      andBool pListLen(Addresses)
                  +Int countMapValues(UserIdToRole0, BoardMember)
              ==Int countMapValues(UserIdToRole, BoardMember)

  syntax Bool ::= initLoopInvariant(
      numUsers:Usize,
      userIdToAddress:Map,
      addressToUserId:Map,
      userIdToRole:Map,
      expand:Int)  [function, functional]

  rule initLoopInvariant(
      NumUsers:Usize,
      UserIdToAddress:Map,
      AddressToUserId:Map,
      UserIdToRole:Map,
      Expand:Int)
    => true
      andBool notBool u(0) in_keys(UserIdToAddress)
      andBool notBool u(0) in_keys(UserIdToRole)

      andBool allValuesBecomeKeys(AddressToUserId, UserIdToAddress)
      andBool allValuesBecomeKeys(UserIdToAddress, AddressToUserId)

      andBool valuesAreOfType(AddressToUserId, rUsize)
      andBool valuesAreKResult(AddressToUserId)
      andBool valuesAreNotEmpty(AddressToUserId, rUsize)
      andBool unusedIdsInMapValues(add(NumUsers, u(1)), AddressToUserId, Expand)

      andBool valuesAreOfType(UserIdToRole, rUserRole)
      andBool valuesAreKResult(UserIdToRole)
      andBool valuesAreNotEmpty(UserIdToRole, rUserRole)
      andBool unusedIdsInMapKeys(add(NumUsers, u(1)), keysMap(UserIdToRole), u(Expand))

      andBool 0 ==Int countMapValues(UserIdToRole, Proposer)
endmodule