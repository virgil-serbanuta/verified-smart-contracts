module MAP-SEMANTICS
  imports MAP
  imports INT

  syntax MapElementProperty ::= "MEP.AlwaysFalse"
                              | "MEP.AlwaysTrue"
                              | "MEP.AnyProperty"
                              | "MEP.IsValue" "(" KItem ")"
  syntax Bool ::= applyMapElementProperty(
          MapElementProperty,
          key:KItem,
          value:KItem
      )  [function, functional]
  syntax Bool ::= uninterpretedElementProperty(key:KItem, value:KItem)
      [function, functional, no-evaluators]

  rule applyMapElementProperty(MEP.AlwaysFalse, _:KItem, _:KItem) => false
  rule applyMapElementProperty(MEP.AlwaysTrue, _:KItem, _:KItem) => true
  rule applyMapElementProperty(MEP.AnyProperty, Key:KItem, Value:KItem)
      => uninterpretedElementProperty(Key, Value)
  rule applyMapElementProperty(MEP.IsValue(V:KItem), _Key:KItem, Value:KItem)
      => V ==K Value

  syntax Int ::= countMapElementProperty(
          MapElementProperty,
          key:KItem,
          value:KItem
      )  [function, functional]

  rule countMapElementProperty(Property:MapElementProperty, Key:KItem, Value:KItem)
      => 0
    requires notBool applyMapElementProperty(Property, Key, Value)
  rule countMapElementProperty(Property:MapElementProperty, Key:KItem, Value:KItem)
      => 1
    requires applyMapElementProperty(Property, Key, Value)

  syntax Int ::= mapCount(Map, MapElementProperty)  [function, functional, smtlib(mapCount)]

  // TODO: Use this everywhere
  rule mapCount(.Map, _:MapElementProperty) => 0
  rule mapCount(K:KItem |-> V:KItem M:Map, Property:MapElementProperty)
      => countMapElementProperty(Property, K, V) +Int mapCount(M, Property)
    [simplification]

  rule mapCount(_:Map, _:MapElementProperty) >=Int 0 => true
    [simplification, smt-lemma]

  rule mapCount(M:Map, MEP.AlwaysTrue) >Int 0 => notBool (M ==K .Map)
    [simplification]

  syntax KItem ::= mapSelectProperty(Map, MapElementProperty)
  syntax KItem ::= #mapSelectProperty(
                      toProcess:Map, MapElementProperty, processed:Map)
  syntax KItem ::= #mapSelectedProperty(
                      key:KItem, value:KItem,
                      toProcess:Map, MapElementProperty, processed:Map)

  syntax KItem ::= mapSelected(key:KItem, value:KItem, Map)
  syntax KItem ::= "mapNotFound"

  rule mapSelectProperty(M:Map, Property:MapElementProperty)
      => #mapSelectProperty(M, Property, .Map)

  rule #mapSelectProperty(.Map, _:MapElementProperty, _:Map)
      => mapNotFound
  rule #mapSelectProperty(
          M:Map,
          Property:MapElementProperty,
          Processed:Map)
      => #mapSelectedProperty(?Key, ?Value, ?M, Property, Processed)
    requires notBool (M ==K .Map)
    ensures (M ==K (?Key:KItem |-> ?Value:KItem ?M:Map))

  rule #mapSelectedProperty(
          Key:KItem,
          Value:KItem,
          M:Map,
          Property:MapElementProperty,
          Processed:Map)
      => mapSelected(Key, Value, M Processed)
    requires applyMapElementProperty(Property, Key, Value)
  rule #mapSelectedProperty(
          Key:KItem,
          Value:KItem,
          M:Map,
          Property:MapElementProperty,
          Processed:Map)
      => #mapSelectProperty(M, Property, Key |-> Value Processed)
    requires notBool applyMapElementProperty(Property, Key, Value)

endmodule
