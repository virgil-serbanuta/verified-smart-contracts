module PROOF-SIGN
  imports EXECUTION
  imports PSEUDOCODE

  claim <T><TT>
          <k> runPseudoCode(
                signer_ids = getActionSignerIds(ActionId:Usize);
                setActionSignerIDs(ActionId, signer_ids);
              )
          </k>
          invariantState(ActionSigners0:Map)
        </TT></T>
      =>
        <T><TT>
          <k> .K </k>
          invariantState(?ActionSigners1:Map):StateCell
        </TT></T>
    requires invariant(ActionSigners0:Map)
endmodule
