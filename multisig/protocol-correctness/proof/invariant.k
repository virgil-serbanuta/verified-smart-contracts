module INVARIANT
  imports EXECUTION-HELPERS
  imports PSEUDOCODE

  syntax StateCell ::= invariantState(actionSigners:Map)  [function, functional]

  rule invariantState(ActionSigners:Map)
    =>
      <state>
        <multisig-state>
          <action-signers>ActionSigners</action-signers>
        </multisig-state>
        <pseudocode-state>
          <variables>.Map</variables>
          <stack> .List </stack>
        </pseudocode-state>
      </state>

  syntax Bool ::= invariant(actionSigners:Map)  [function, functional]

  rule invariant(ActionSigners:Map)
    => true
      andBool valuesAreExpressionListOfUsize(ActionSigners)
      andBool valuesAreKResult(ActionSigners)

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

  rule A:Int +Int K:Int >Int B:Int => true
    requires K >Int 0 andBool A >=Int B
    [simplification]

endmodule
