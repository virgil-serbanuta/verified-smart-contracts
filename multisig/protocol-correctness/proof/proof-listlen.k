module PROOF-LISTLEN
  imports PSEUDOCODE
  imports EXECUTION

  claim call(listLen([.])) => u(0)
  claim call(listLen([E:Expression , Es:ExpressionCSV])) => u(1 +Int pListLen([Es]))
    requires isKResult(E) andBool isKResult(Es)
  claim call(listLen(L:ExpressionList)) => u(pListLen(L))
    requires isKResult(L)

endmodule
