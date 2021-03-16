require "../pseudocode.k"
require "invariant.k"

module EXECUTION-SYNTAX
  imports PSEUDOCODE-SYNTAX
endmodule

module EXECUTION-HELPERS
  imports MAP-SYMBOLIC
  imports SET

  imports PSEUDOCODE

  syntax Int ::= pListLen(ExpressionList)  [function, functional]
  rule pListLen([.]) => 0
  rule pListLen([_:Expression, Es:ExpressionCSV]) => 1 +Int pListLen([Es])

  syntax Bool ::= listElementsAreUsize(KItem)  [function, functional]
  rule listElementsAreUsize([.]) => true
  rule listElementsAreUsize([E:Expression, Es:ExpressionCSV])
      => isUsize(E) andBool listElementsAreUsize([Es])
  rule listElementsAreUsize(_:KItem) => false
    [owise]
  rule listElementsAreUsize([E:Expression, Es:ExpressionCSV])
      => isUsize(E) andBool listElementsAreUsize([Es])
    [simplification]

  syntax Bool ::= valuesAreExpressionListOfUsize(Map)  [function, functional]
  rule valuesAreExpressionListOfUsize(.Map) => true
  rule valuesAreExpressionListOfUsize(_ |-> V M:Map)
      =>  isExpressionList(V)
          andBool listElementsAreUsize(V)
          andBool valuesAreExpressionListOfUsize(M)
  rule valuesAreExpressionListOfUsize(_ |-> V M:Map)
      =>  isExpressionList(V)
          andBool listElementsAreUsize(V)
          andBool valuesAreExpressionListOfUsize(M)
    [simplification]

  syntax Bool ::= valuesAreKResult(Map)  [function, functional]
  rule valuesAreKResult(.Map) => true
  rule valuesAreKResult(_ |-> V M:Map)
      => isUsize(V) andBool valuesAreKResult(M)
  rule valuesAreKResult(_ |-> V M:Map)
      => isKResult(V) andBool valuesAreKResult(M)
    [simplification]

  syntax Bool ::= valuesAreOfType(Map, ReflectionType)  [function, functional]
  rule valuesAreOfType(.Map, _:ReflectionType) => true
  rule valuesAreOfType(_ |-> V M:Map, T:ReflectionType)
      => valueOfType(V, T) andBool valuesAreOfType(M, T)
  rule valuesAreOfType(_ |-> V M:Map, T:ReflectionType)
      => valueOfType(V, T) andBool valuesAreOfType(M, T)
    [simplification]

  rule X:Int -Int X:Int => 0  [simplification]
  // rule false andBool _:Bool => false  [simplification]
  // rule true andBool X:Bool => X  [simplification]
  // rule _:Bool andBool false => false  [simplification]
  // rule X:Bool andBool true => X  [simplification]

  // rule {((X:KItem |-> Vx:KItem Mx:Map) #as _:Map) #Equals ((Y:KItem |-> Vy:KItem My:Map) #as _:Map)}
  //       =>
  //           ({X #Equals Y} #And {Vx #Equals Vy} #And {Mx #Equals My})
  //           #Or (
  //                 (#Not ({X #Equals Y}))
  //                 #And ({My #Equals (X |-> Vx ?M)}
  //                         #And {Mx #Equals (Y |-> Vy ?M)}
  //                       )
  //               )
  //   [simplification]

  syntax KItem ::= "iCallGetUserId"

  syntax Bool ::= isCallGetUserId(KItem)  [function, functional]
  rule isCallGetUserId(call(getUserId(_))) => true
  rule isCallGetUserId(_) => false  [owise]

  rule  <k> call(getUserId(A:Address)) ... </k>
        <caller-address> A </caller-address>
        <last-instrumented> .K => iCallGetUserId </last-instrumented>
    [priority(10)]
  rule  <k> call(getUserId(A:Address)) ... </k>
        <caller-address> B:Address </caller-address>
        <last-instrumented> .K => iCallGetUserId </last-instrumented>
    requires notBool (A ==K B)
    [priority(10)]
  rule  <k> X:KItem ... </k>
        <last-instrumented> iCallGetUserId => .K </last-instrumented>
    requires notBool isCallGetUserId(X)
    [priority(10)]

endmodule

module EXECUTION
  imports EXECUTION-HELPERS
  imports INVARIANT
endmodule