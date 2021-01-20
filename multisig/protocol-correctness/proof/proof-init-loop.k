module PROOF-INIT-LOOP
  imports PSEUDOCODE
  imports EXECUTION

  rule forall-v-greater-or-equal-than-u-v-not-in-m(_:Usize, .Map, _:ExpressionList)
      => true  [simplification]

  claim <T>
          <k>
            runInstruction(
                for (i = add(PrevIndex, u(1)), address ) in Addresses:ExpressionList {
                    user_id = i + u(1);
                    setUserId(address, user_id);
                    setUserAddress(user_id, address);
                    setUserIdToRole(user_id, BoardMember);
                }
            )
            ~> runPseudoCode(_:Instructions) #as R:KItem
            ~> K:K
          </k>
          <state>
            <multisig-state>
              <users>
                <num-users>uninitialized</num-users>
                <user-id-to-address>UserIdToAddress0:Map</user-id-to-address>
                <address-to-user-id>AddressToUserId0:Map</address-to-user-id>
              </users>
              <board-state>
                <num-board-members>uninitialized</num-board-members>
                <num-proposers>u(0)</num-proposers>
                <user-roles>UserIdToRole0</user-roles>
                <quorum>uninitialized</quorum>
              </board-state>
              ActionState:ActionStateCell
            </multisig-state>
            <pseudocode-state>
              <variables>
                i |-> PrevIndex:Usize
                address |-> _:Expression
                user_id |-> _:Usize
                _Variables0:Map
              </variables>
              <stack> Stack:List </stack>
            </pseudocode-state>
            ExternalCallEnv:ExternalCallEnvCell
          </state>
        </T>
      =>
        <T>
          <k> R ~> K </k>
          <state>
            <multisig-state>
              <users>
                <num-users>uninitialized</num-users>
                <user-id-to-address>?_UserIdToAddress1:Map</user-id-to-address>
                <address-to-user-id>?_AddressToUserId1:Map</address-to-user-id>
              </users>
              <board-state>
                <num-board-members>uninitialized</num-board-members>
                <num-proposers>u(0)</num-proposers>
                <user-roles>?_UserRoles1</user-roles>
                <quorum>uninitialized</quorum>
              </board-state>
              ActionState:ActionStateCell
            </multisig-state>
            <pseudocode-state>
              <variables>?_Variables1:Map</variables>
              <stack> Stack:List </stack>
            </pseudocode-state>
            ExternalCallEnv:ExternalCallEnvCell
          </state>
        </T>
    requires    isKResult(Addresses)
        andBool noCommonItem(add(PrevIndex, u(2)), AddressToUserId0, Addresses)
        andBool noReusedIndexAddress(add(PrevIndex, u(2)), UserIdToAddress0, Addresses)
        andBool noReusedIndexRole(add(PrevIndex, u(2)), UserIdToRole0, Addresses)
        andBool allItemsAreAddresses(Addresses)

endmodule
