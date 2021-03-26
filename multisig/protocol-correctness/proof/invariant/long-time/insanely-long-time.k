require "../proof-perform-add-board-member.k"
require "../proof-perform-add-proposer-1.k"
require "../proof-perform-add-proposer-2.k"
require "../proof-perform-add-proposer-3.k"
require "../proof-perform-add-proposer-4.k"
require "../proof-perform-add-proposer-5.k"
require "../proof-perform-add-proposer-6.k"
require "../proof-perform-add-proposer-7.k"
require "../proof-perform-add-proposer-8.k"
require "../proof-perform-add-proposer-9.k"
require "../proof-perform-change-quorum.k"
require "../proof-perform-nothing.k"
require "../proof-perform-remove-user-1.k"
require "../proof-perform-remove-user-2.k"
require "../proof-perform-remove-user-3.k"
require "../proof-perform-remove-user-4.k"
require "../proof-perform-remove-user-5.k"
require "../proof-perform-remove-user-6.k"
require "../proof-perform-remove-user-7.k"
require "../proof-perform-remove-user-8.k"
require "../proof-perform-remove-user-9.k"
require "../proof-perform-remove-user-10.k"
require "../proof-perform-s-c-call.k"
require "../proof-perform-s-c-deploy.k"
require "../proof-perform-send-egld.k"

module INSANELY-LONG-TIME

  imports INVARIANT-EXECUTION

  imports TRUSTED-PERFORM-ADD-BOARD-MEMBER
  imports TRUSTED-PERFORM-ADD-PROPOSER-1
  imports TRUSTED-PERFORM-ADD-PROPOSER-2
  imports TRUSTED-PERFORM-ADD-PROPOSER-3
  imports TRUSTED-PERFORM-ADD-PROPOSER-4
  imports TRUSTED-PERFORM-ADD-PROPOSER-5
  imports TRUSTED-PERFORM-ADD-PROPOSER-6
  imports TRUSTED-PERFORM-ADD-PROPOSER-7
  imports TRUSTED-PERFORM-ADD-PROPOSER-8
  imports TRUSTED-PERFORM-ADD-PROPOSER-9
  imports TRUSTED-PERFORM-CHANGE-QUORUM
  imports TRUSTED-PERFORM-NOTHING

  imports TRUSTED-PERFORM-REMOVE-USER-1
  imports TRUSTED-PERFORM-REMOVE-USER-2
  imports TRUSTED-PERFORM-REMOVE-USER-3
  imports TRUSTED-PERFORM-REMOVE-USER-4
  imports TRUSTED-PERFORM-REMOVE-USER-5
  imports TRUSTED-PERFORM-REMOVE-USER-6
  imports TRUSTED-PERFORM-REMOVE-USER-7
  imports TRUSTED-PERFORM-REMOVE-USER-8
  imports TRUSTED-PERFORM-REMOVE-USER-9
  imports TRUSTED-PERFORM-REMOVE-USER-10

  imports TRUSTED-PERFORM-S-C-CALL
  imports TRUSTED-PERFORM-S-C-DEPLOY
  imports TRUSTED-PERFORM-SEND-EGLD

claim
  <T>
    <TT>
      <k>
        call ( performAction ( RemoveUser ( address ( Var0 ) ) ) ) ~> popContext ~> evaluateReturnValue ~> popContext ~> evaluateReturnValue ~> popContext ~> evaluateReturnValue ~> clearExternalCallEnv ~> runExternalCalls ( EC ) ~> .K
      </k>
      <state>
        <multisig-state>
          <users>
            <num-users>
              u ( NumUsers0 )
            </num-users>
            <user-id-to-address>
              UserIdToAddress
            </user-id-to-address>
            <address-to-user-id>
              VarUndsAddressToUserIdRemainder
              address ( Var0 ) |-> U:Usize
            </address-to-user-id>
          </users>
          <board-state>
            <num-board-members>
              u ( countMapValues ( UserRoles , BoardMember ) )
            </num-board-members>
            <num-proposers>
              u ( countMapValues ( UserRoles , Proposer ) )
            </num-proposers>
            <user-roles>
              UserRoles
            </user-roles>
            <quorum>
              u ( Quorum0 )
            </quorum>
          </board-state>
          <action-state>
            <action-last-index>
              u ( ActionLastIndex1 )
            </action-last-index>
            <actions>
              <action-data>
                ActionData0
              </action-data>
              <action-signers>
                ActionSigners0
              </action-signers>
            </actions>
          </action-state>
        </multisig-state>
        <pseudocode-state>
          <variables>
            .Map
          </variables>
          <stack>
            ListItem ( stackEntry ( <multisig-state>
              <users>
                <num-users>
                  u ( Var4 )
                </num-users>
                <user-id-to-address>
                  Var5
                </user-id-to-address>
                <address-to-user-id>
                  Var6
                </address-to-user-id>
              </users>
              <board-state>
                <num-board-members>
                  u ( Var7 )
                </num-board-members>
                <num-proposers>
                  u ( Var8 )
                </num-proposers>
                <user-roles>
                  Var9
                </user-roles>
                <quorum>
                  u ( Var10 )
                </quorum>
              </board-state>
              <action-state>
                <action-last-index>
                  u ( Var11 )
                </action-last-index>
                <actions>
                  <action-data>
                    Var12
                  </action-data>
                  <action-signers>
                    Var13
                  </action-signers>
                </actions>
              </action-state>
            </multisig-state> , Var1 ) )
            ListItem ( stackEntry ( <multisig-state>
              <users>
                <num-users>
                  u ( Var14 )
                </num-users>
                <user-id-to-address>
                  Var15
                </user-id-to-address>
                <address-to-user-id>
                  Var16
                </address-to-user-id>
              </users>
              <board-state>
                <num-board-members>
                  u ( Var17 )
                </num-board-members>
                <num-proposers>
                  u ( Var18 )
                </num-proposers>
                <user-roles>
                  Var19
                </user-roles>
                <quorum>
                  u ( Var20 )
                </quorum>
              </board-state>
              <action-state>
                <action-last-index>
                  u ( Var21 )
                </action-last-index>
                <actions>
                  <action-data>
                    Var22
                  </action-data>
                  <action-signers>
                    Var23
                  </action-signers>
                </actions>
              </action-state>
            </multisig-state> , Var3 ) )
            ListItem ( stackEntry ( <multisig-state>
              <users>
                <num-users>
                  u ( NumUsersS0 )
                </num-users>
                <user-id-to-address>
                  UserIdToAddressS
                </user-id-to-address>
                <address-to-user-id>
                  AddressToUserIdS
                </address-to-user-id>
              </users>
              <board-state>
                <num-board-members>
                  u ( countMapValues ( UserRolesS , BoardMember ) )
                </num-board-members>
                <num-proposers>
                  u ( countMapValues ( UserRolesS , Proposer ) )
                </num-proposers>
                <user-roles>
                  UserRolesS
                </user-roles>
                <quorum>
                  u ( QuorumS0 )
                </quorum>
              </board-state>
              <action-state>
                <action-last-index>
                  u ( ActionLastIndexS0 )
                </action-last-index>
                <actions>
                  <action-data>
                    ActionDataS
                  </action-data>
                  <action-signers>
                    ActionSignersS
                  </action-signers>
                </actions>
              </action-state>
            </multisig-state> , .Map ) )
          </stack>
        </pseudocode-state>
        <external-call-env>
          <caller-address>
            address ( CallerAddress0 )
          </caller-address>
        </external-call-env>
        <proof-state>
          <last-instrumented>
            .K
          </last-instrumented>
        </proof-state>
      </state>
    </TT>
  </T>
  =>
    <T><TT>
      <k> runExternalCalls(EC) </k>
      invariantStateStack(
          ?_NumUsers1:Usize,
          ?_UserIdToAddress1:Map,
          ?_AddressToUserId1:Map,
          ?_NumBoardMembers1:Usize,
          ?_NumProposers1:Usize,
          ?_UserRoles1:Map,
          ?_Quorum1:Usize,
          ?_ActionLastIndex1:Usize,
          ?_ActionData1:Map,
          ?_ActionSigners1:Map,
          ?_CallerAddress:Address,
          .List):StateCell
    </TT></T>
  requires true
    andBool notBool ( U ==K u ( 0 ) )
    andBool notBool ( U ==K u ( NumUsers0 +Int 1 ) )
    andBool notBool ( U ==K u ( NumUsers0 +Int 2 ) )
    andBool notBool ( Var0 ==K CallerAddress0 )

    andBool VarUndsUserId ==K U:Usize
    andBool A ==K RemoveUser ( address ( Var0 ) )
    andBool AddressToUserId ==K VarUndsAddressToUserIdRemainder address ( Var0 ) |-> U:Usize
    andBool notBool U:Usize in_keys ( UserRoles )
    andBool notBool address ( Var0 ) in_keys ( VarUndsAddressToUserIdRemainder )
    andBool notBool u ( 0 ) in_keys ( UserIdToAddress )
    andBool notBool u ( 0 ) in_keys ( UserIdToAddressS )
    andBool notBool u ( 0 ) in_keys ( UserRoles )
    andBool notBool u ( 0 ) in_keys ( UserRolesS )
    andBool notBool u ( ActionLastIndex1 +Int 1 ) in_keys ( ActionData0 )
    andBool notBool u ( ActionLastIndex1 +Int 1 ) in_keys ( ActionSigners0 )
    andBool notBool u ( NumUsers0 +Int 1 ) in_keys ( UserRoles )
    andBool #allValuesBecomeKeys ( VarUndsAddressToUserIdRemainder , keysMap ( UserIdToAddress ) )
    andBool #allValuesBecomeKeys ( AddressToUserIdS , keysMap ( UserIdToAddressS ) )
    andBool #allValuesBecomeKeys ( UserIdToAddress , address ( Var0 ) |-> 0 keysMap ( VarUndsAddressToUserIdRemainder ) )
    andBool #allValuesBecomeKeys ( UserIdToAddressS , keysMap ( AddressToUserIdS ) )
    andBool #noReusedIndexValue ( NumUsers0 +Int 2 , VarUndsAddressToUserIdRemainder , expanded )
    andBool #noReusedIndexValue ( NumUsersS0 +Int 1 , AddressToUserIdS , expanded )
    andBool NumUsers0 +Int 1 >Int usizeToInt ( U )
    andBool NumUsers0 >=Int 0
    andBool NumUsersS0 >=Int 0
    andBool Quorum0 <=Int countMapValues ( UserRoles , BoardMember )
    andBool QuorumS0 <=Int countMapValues ( UserRolesS , BoardMember )
    andBool U:Usize in_keys ( UserIdToAddress )
    andBool actionDataInvariant ( ActionData0 )
    andBool actionDataInvariant ( ActionDataS )
    andBool actionSignersInvariant ( ActionSigners0 )
    andBool actionSignersInvariant ( ActionSignersS )
    andBool addressToUserIdInvariant ( VarUndsAddressToUserIdRemainder )
    andBool addressToUserIdInvariant ( AddressToUserIdS )
    andBool countMapValues ( UserRoles , BoardMember ) +Int countMapValues ( UserRoles , Proposer ) >Int 0
    andBool countMapValues ( UserRolesS , BoardMember ) +Int countMapValues ( UserRolesS , Proposer ) >Int 0
    andBool maxMapKey ( u ( ActionLastIndex1 ) , keysMap ( ActionData0 ) )
    andBool maxMapKey ( u ( ActionLastIndex1 ) , keysMap ( ActionSigners0 ) )
    andBool maxMapKey ( u ( ActionLastIndexS0 ) , keysMap ( ActionDataS ) )
    andBool maxMapKey ( u ( ActionLastIndexS0 ) , keysMap ( ActionSignersS ) )
    andBool unusedIdsInMapKeys ( ActionLastIndex1 +Int 2 , keysMap ( ActionData0 ) , expanded )
    andBool unusedIdsInMapKeys ( ActionLastIndex1 +Int 2 , keysMap ( ActionSigners0 ) , expanded )
    andBool unusedIdsInMapKeys ( ActionLastIndexS0 +Int 1 , keysMap ( ActionDataS ) , expanded )
    andBool unusedIdsInMapKeys ( ActionLastIndexS0 +Int 1 , keysMap ( ActionSignersS ) , expanded )
    andBool unusedIdsInMapKeys ( NumUsers0 +Int 2 , keysMap ( UserRoles ) , expanded )
    andBool unusedIdsInMapKeys ( NumUsersS0 +Int 1 , keysMap ( UserRolesS ) , expanded )
    andBool unusedIdsInMapValues ( NumUsers0 +Int 1 , VarUndsAddressToUserIdRemainder , expanded )
    andBool unusedIdsInMapValues ( NumUsersS0 +Int 1 , AddressToUserIdS , expanded )
    andBool userIdToRoleInvariant ( UserRoles )
    andBool userIdToRoleInvariant ( UserRolesS )
    andBool valueNotInMapValues ( U:Usize , VarUndsAddressToUserIdRemainder )
    andBool valueNotInMapValues ( u ( NumUsers0 +Int 1 ) , VarUndsAddressToUserIdRemainder )
    andBool valueNotInMapValues ( u ( NumUsers0 +Int 2 ) , VarUndsAddressToUserIdRemainder )
    andBool valueNotInMapValues ( u ( NumUsersS0 +Int 1 ) , AddressToUserIdS )


endmodule