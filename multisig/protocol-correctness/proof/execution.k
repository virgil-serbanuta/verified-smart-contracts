require "../pseudocode.k"
require "invariant.k"

require "perform-parts.k"

module EXECUTION-SYNTAX
  imports PSEUDOCODE-SYNTAX
endmodule

module EXECUTION-HELPERS
  imports MAP-SYMBOLIC
  imports SET

  imports PSEUDOCODE

  syntax Int ::= pListLen(ExpressionList)  [function, functional, smtlib(pListLen)]
  rule pListLen([.]) => 0
  rule pListLen([_:Expression, Es:ExpressionCSV]) => 1 +Int pListLen([Es])

  rule pListLen(_) >=Int 0 => true  [simplification, smt-lemma]

  syntax Bool ::= noCommonItem(Usize, Map, ExpressionList)  [function, functional]
  rule noCommonItem(_:Usize, _:Map, [.]) => true
  rule noCommonItem(U:Usize, M:Map, [E:Expression , Es:ExpressionCSV])
      =>  notBool (E in_keys(M))
          andBool noCommonItem(add(U, u(1)), (E |-> U) M, [Es])

  syntax Int ::= usizeToInt(Usize)  [function, functional]
  rule usizeToInt(u(V:Int)) => V

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

  syntax Int ::= countMapValues(Map, KItem)  [function, functional, smtlib(countMapValues)]

  rule 0 <=Int countMapValues(_, _) => true  [simplification, smt-lemma]
  rule countMapValues(_, _) >=Int 0 => true  [simplification]
  rule countMapValues(_, _) +Int 1 >=Int 0 => true  [simplification]
  rule countMapValues(_, _) +Int 1 +Int countMapValues(_, _) >Int 0 => true  [simplification]
  rule countMapValues(_, _) +Int countMapValues(_, _) +Int 1 >Int 0 => true  [simplification]

endmodule

module EXECUTION
  imports EXECUTION-HELPERS
  imports INVARIANT
  imports PERFORM-PARTS
endmodule