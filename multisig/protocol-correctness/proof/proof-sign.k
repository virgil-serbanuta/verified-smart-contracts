module PROOF-SIGN
  imports EXECUTION
  imports PSEUDOCODE

  claim <T><TT>
          <k> runPseudoCode(
                signer_ids = getActionSignerIds(ActionId:Usize);
                setActionSignerIDs(ActionId, signer_ids);
              )
          </k>
          <state>
            <multisig-state>
              <action-signers>ActionSigners0</action-signers>
            </multisig-state>
            <pseudocode-state>
              <variables>.Map</variables>
              <stack> .List </stack>
            </pseudocode-state>
          </state>
        </TT></T>
      =>
        <T><TT>
          <k> .K </k>
          <state>
            <multisig-state>
              <action-signers>?ActionSigners1</action-signers>
            </multisig-state>
            <pseudocode-state>
              <variables>.Map</variables>
              <stack> .List </stack>
            </pseudocode-state>
          </state>
        </TT></T>
    requires true
      andBool valuesAreExpressionListOfUsize(ActionSigners0)
      andBool valuesAreKResult(ActionSigners0)
endmodule
