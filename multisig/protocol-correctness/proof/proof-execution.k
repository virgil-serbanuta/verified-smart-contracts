require "../pseudocode.k"

module PROOF-EXECUTION-SYNTAX
  imports PSEUDOCODE-SYNTAX
endmodule

module PROOF-EXECUTION
  imports PSEUDOCODE

  syntax Bool ::= invariant(StateCell)  [function, functional]
  rule invariant(_) => true

  syntax Int ::= pListLen(ExpressionList)  [function, functional]
  rule pListLen([.]) => 0
  rule pListLen([_:Expression, Es:ExpressionCSV]) => 1 +Int pListLen([Es])

endmodule
