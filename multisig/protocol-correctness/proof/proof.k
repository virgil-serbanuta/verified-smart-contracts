module PROOF
  imports PSEUDOCODE
  imports PROOF-EXECUTION

  /*claim evaluate(listLen([])) => evaluate(0)
  claim evaluate(listLen([E:Expression])) => evaluate(1)
    requires isKResult(E)
  claim evaluate(listLen([E:Expression , Es:ExpressionCSV])) => evaluate(1 + pListLen([Es]))
    requires isKResult(E) andBool isKResult(Es)
  claim evaluate(listLen(L:ExpressionList)) => evaluate(pListLen(L))
    requires isKResult(L)*/

  claim call(listLen([.])) => 0
  claim call(listLen([E:Expression , Es:ExpressionCSV])) => 1 +Int pListLen([Es])
    requires isKResult(E) andBool isKResult(Es)
  claim call(listLen(L:ExpressionList)) => pListLen(L)
    requires isKResult(L)

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