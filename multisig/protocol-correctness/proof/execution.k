require "../pseudocode.k"
require "invariant.k"

require "count-can-sign-parts.k"
require "init-loop-parts.k"
require "perform-parts.k"

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

  syntax Bool ::= noCommonItem(Usize, Map, ExpressionList)  [function, functional]
  rule noCommonItem(_:Usize, _:Map, [.]) => true
  rule noCommonItem(U:Usize, M:Map, [E:Expression , Es:ExpressionCSV])
      =>  notBool (E in_keys(M))
          andBool noCommonItem(add(U, u(1)), (E |-> U) M, [Es])

  syntax Bool ::= noReusedIndexAddress(Usize, Map, ExpressionList)  [function, functional]
  rule noReusedIndexAddress(U:Usize, M:Map, [.]) => forall-v-greater-or-equal-than-u-v-not-in-m(U, M, [.])
  rule noReusedIndexAddress(U:Usize, M:Map, [E:Expression , Es:ExpressionCSV] #as L)
      =>  forall-v-greater-or-equal-than-u-v-not-in-m(U, M, L)
          andBool noReusedIndexAddress(add(U, u(1)), (U |-> E) M, [Es])

  syntax Bool ::= noReusedIndexRole(Usize, Map, ExpressionList)  [function, functional]
  rule noReusedIndexRole(U:Usize, M:Map, [.]) => forall-v-greater-or-equal-than-u-v-not-in-m(U, M, [.])
  rule noReusedIndexRole(U:Usize, M:Map, [_:Expression , Es:ExpressionCSV] #as L)
      =>  forall-v-greater-or-equal-than-u-v-not-in-m(U, M, L)
          andBool noReusedIndexRole(add(U, u(1)), (U |-> BoardMember) M, [Es])

  syntax Bool ::= "forall-v-greater-or-equal-than-u-v-not-in-m" "(" Usize "," Map "," ExpressionList ")"   [function, functional]
  rule forall-v-greater-or-equal-than-u-v-not-in-m(U, M, [.])
      =>  notBool U in_keys(M)
  rule forall-v-greater-or-equal-than-u-v-not-in-m(U, M, [_:Expression , Es:ExpressionCSV])
      =>  notBool U in_keys(M)
          andBool forall-v-greater-or-equal-than-u-v-not-in-m(add(U, u(1)), M, [Es])

  syntax Usize ::= usizeWithDefault(KItem, Usize)  [function, functional]
  rule usizeWithDefault(uninitialized, Default:Usize) => Default
  rule usizeWithDefault(V:Usize, _:Usize) => V

  syntax Int ::= usizeToInt(Usize)  [function, functional]
  rule usizeToInt(u(V:Int)) => V

  syntax Bool ::= listElementsAreAddresses(ExpressionList)  [function, functional]
  rule listElementsAreAddresses([.]) => true
  rule listElementsAreAddresses([E:Expression , Es:ExpressionCSV])
      => isAddress(E) andBool listElementsAreAddresses([Es])

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
      => isKResult(V) andBool valuesAreKResult(M)
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

  syntax Bool ::= valuesAreNotEmpty(Map, ReflectionType)  [function, functional]
  rule valuesAreNotEmpty(.Map, _:ReflectionType) => true
  rule valuesAreNotEmpty(_ |-> V M:Map, T:ReflectionType)
      => valuesAreNotEmpty(M, T) andBool notBool (V ==K defaultValue(T))
  rule valuesAreNotEmpty(_ |-> V M:Map, T:ReflectionType)
      => valuesAreNotEmpty(M, T) andBool notBool (V ==K defaultValue(T))
    [simplification]
  
  syntax Bool ::= allValuesBecomeKeys(Map, Map)  [function, functional]
  syntax Bool ::= #allValuesBecomeKeys(Map, Map)  [function, functional]

  rule allValuesBecomeKeys(M:Map, N:Map) => #allValuesBecomeKeys(M, keysMap(N))

  rule #allValuesBecomeKeys(_ |-> V M:Map, N:Map)
      => V in_keys(N) andBool #allValuesBecomeKeys(M, N)
    [simplification]
  rule #allValuesBecomeKeys(M:Map, _ |-> _ N:Map) => true
    requires #allValuesBecomeKeys(M, N)
    [simplification]

  rule #allValuesBecomeKeys(M:Map, _ |-> _ N:Map) => true
    requires #allValuesBecomeKeys(M, N)
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

  /*
  syntax KItem ::= "iCallGetUserId"

  syntax Bool ::= isCallGetUserId(KItem)  [function, functional]
  rule isCallGetUserId(call(getUserId(_))) => true
  rule isCallGetUserId(_) => false  [owise]

  // Does not split properly, leaves a remainder
  rule  <k> call(getUserId(A:Address)) ... </k>
        <caller-address> B:Address </caller-address>
        <last-instrumented> .K => iCallGetUserId </last-instrumented>
    requires A ==K B
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
  */

  // expand is a stupid trick used to control symbolic function application.
  syntax Bool ::= unusedIdsInMapKeys(lastIndex:Usize, Map, expand:Usize)  [function, functional]

  rule unusedIdsInMapKeys(LastIndex:Usize, M:Map, u(Expand:Int))
      => #unusedIdsInMapKeys(LastIndex, M, Expand)
  /*
  rule unusedIdsInMapKeys(_, _, _)
      => true
    //[simplification]
  */

  syntax Bool ::= #unusedIdsInMapKeys(lastIndex:Usize, Map, expand:Int)  [function, functional]

  /*
  rule #unusedIdsInMapKeys(_LastIndex:Usize, .Set, _Expand:Int) => true
  rule #unusedIdsInMapKeys(u(LastIndex:Int), SetItem(u(K:Int)) S:Set, Expand:Int)
    => LastIndex >Int K
        andBool #unusedIdsInMapKeys(u(LastIndex), S, Expand)
  */

  rule #unusedIdsInMapKeys(u(LastIndex:Int), U:Usize |-> _:KItem M:Map, Expand:Int)
    => #unusedIdsInMapKeys(u(LastIndex), M, Expand) 
      andBool LastIndex >Int usizeToInt(U)
    [simplification(30), label(xyzzya)]

  rule #unusedIdsInMapKeys(LastIndex:Usize, M:Map, Expand:Int)
    => notBool LastIndex in_keys(M)
      andBool #unusedIdsInMapKeys(add(LastIndex, u(1)), M, Expand -Int 1)
    requires Expand >Int 0
    [simplification, label(xyzzyb)]

  rule #unusedIdsInMapKeys(LastIndex:Usize, M:Map, -1)
    => true
    requires #unusedIdsInMapKeys(LastIndex, M, 0)
    [simplification, label(xyzzyc)]

  rule #unusedIdsInMapKeys(LastIndex:Usize, M:Map, -1)
    => true
    requires notBool LastIndex in_keys(M)
      andBool #unusedIdsInMapKeys(add(LastIndex, u(1)), M, 0)
    [simplification, label(xyzzyd)]

  rule #unusedIdsInMapKeys(LastIndex:Usize, M:Map, -1)
    => true
    requires notBool LastIndex in_keys(M)
      andBool notBool add(LastIndex, u(1)) in_keys(M)
      andBool #unusedIdsInMapKeys(add(LastIndex, u(2)), M, 0)
    [simplification, label(xyzzye)]


  syntax Bool ::= unusedIdsInMapValues(lastIndex:Usize, Map)  [function, functional]
  rule unusedIdsInMapValues(_, .Map) => true
  rule unusedIdsInMapValues(u(LastIndex), K:KItem |-> Value M:Map)
      => unusedIdsInMapValues(u(LastIndex), M)
      andBool LastIndex >Int usizeToInt(Value)
    [simplification]


  syntax Map ::= keysMap(Map)  [function, functional]
  rule keysMap(K:KItem |-> _:KItem M:Map) => K |-> 0 keysMap(M)
    [simplification]
  rule X:KItem in_keys(keysMap(M:Map)) => X in_keys(M)
    [simplification]

endmodule

module INSTRUMENTATION
  imports MAP

  imports PSEUDOCODE
  /*
  syntax KItem ::= "iCallGetUserId"

  syntax Bool ::= isCallGetUserId(KItem)  [function, functional]
  rule isCallGetUserId(call(getUserId(_))) => true
  rule isCallGetUserId(_) => false  [owise]

  // Does not split properly, leaves a remainder
  rule  <k> call(getUserId(A:Address)) ... </k>
        <caller-address> B:Address </caller-address>
        <last-instrumented> .K => iCallGetUserId </last-instrumented>
    requires A ==K B
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
  */

  /*
  syntax KItem ::= "concretizing"

  syntax KItem ::= concretize(Usize)
  rule concretize(u(_)) => .K

  syntax KItem ::= "concretizeEnd"
  rule concretizeEnd => .K

  syntax K ::= concretizeKeys(Map)  [function, functional]
  rule concretizeKeys(K:Usize |-> _:KItem M:Map)
      => concretize(K) ~> concretizeKeys(M)
    [simplification]
  rule concretizeKeys(M:Map) => concretizeEnd
  */

  syntax Singleton ::= "singleton"
  syntax KItem ::= "concretizing"

  syntax IntVarList ::= vars(Int, IntVarList)
                    |   ".IntVarList"
  
  rule  <k> (.K => concretized(concretizeKeys(UserIdToAddress, vars(?_, vars(?_, .IntVarList))))
                ~> concretized(concretizeKeys(UserIdToRole, vars(?_, vars(?_, .IntVarList))))
            )
            ~> void ~> evaluateReturnValue
        ...</k>
        <user-id-to-address> UserIdToAddress:Map </user-id-to-address>
        <user-roles> UserIdToRole:Map </user-roles>
        <last-instrumented> .K => (concretizing ~> .K) </last-instrumented>
    [priority(20)]
  rule  <k> K:KItem ... </k>
        <last-instrumented> (concretizing ~> .K) => .K </last-instrumented>
    requires true
        andBool notBool (K ==K concretized(singleton))
        andBool notBool (K ==K void)
    [priority(20)]

  syntax Singleton ::= concretizeKeys(Map, IntVarList)  [function, functional]
  rule concretizeKeys(K:Usize |-> _:KItem M:Map, vars(U:Int, Vars:IntVarList))
      => concretizeKeys(M, Vars)
    ensures K ==K u(U:Int)
      // => concretizeKeys(M, Vars) #And #Ceil(K #And u(U:Int))
    [simplification(40)]
  rule concretizeKeys(_:Map, _:IntVarList) => singleton
    [simplification(50)]

  syntax KItem ::= concretized(Singleton)
  rule concretized(singleton) => .K

endmodule

module EXECUTION
  imports EXECUTION-HELPERS
  imports INSTRUMENTATION
  imports INVARIANT
  imports INIT-LOOP-PARTS
  imports COUNT-CAN-SIGN-PARTS
  imports PERFORM-PARTS
endmodule