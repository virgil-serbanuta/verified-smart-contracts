module PROOF
  imports PSEUDOCODE
  imports EXECUTION

  claim call(listLen(L:ExpressionList)) => u(pListLen(L))
    requires isKResult(L)
    [trusted]

  claim <T>
          <k>
            runInstruction(
                for ( i = u ( _:Int ) , address ) in Addresses:ExpressionList {
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
                <num-users>NumUsers:Usize</num-users>
                <user-id-to-address>UserIdToAddress:Map</user-id-to-address>
                <address-to-user-id>AddressToUserId:Map</address-to-user-id>
                <user-roles>UserRoles:Map</user-roles>
              </users>
              <board-state>
                <num-board-members>uninitialized</num-board-members>
                <num-proposers>u(0)</num-proposers>
                <user-roles>.Map</user-roles>
                <quorum>uninitialized</quorum>
              </board-state>
              ActionState:ActionStateCell
            </multisig-state>
            <pseudocode-state>
              <variables>Variables:Map</variables>
              <stack> Stack:List </stack>
            </pseudocode-state>
            ExternalCallEnv:ExternalCallEnvCell
          </state>
        </T>
      =>
        <T>
          <k> R ~> K </k>
          ?Initialized:StateCell
        </T>
    requires isKResult(Addresses) andBool noCommonAddress(InitialState, Addresses)
    ensures invariant(?Initialized)  // TODO: loop invariant

  claim <T>
          <k> runExternalCalls(
                  (   from _:Address run init(_Quorum:Usize, Addresses:ExpressionList);
                      EC:ExternalCommands
                  )
              )
          </k>
          initialState
        </T>
      =>
        <T>
          <k> runExternalCalls(EC) </k>
          ?Initialized:StateCell
        </T>
    requires isKResult(Addresses)
    ensures invariant(?Initialized)
endmodule
