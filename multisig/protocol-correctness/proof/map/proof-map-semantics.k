module TRUSTED-MAP-SEMANTICS
  imports MAP-SEMANTICS

  claim mapSelectProperty(M:Map, Property:MapElementProperty)
      => mapSelected(?Key:KItem, ?Value:KItem, ?M:Map)
    requires mapCount(M, Property) >Int 0
    ensures applyMapElementProperty(Property, ?Key, ?Value)
        andBool M ==K (?Key |-> ?Value ?M)
    [trusted]

  claim mapSelectProperty(M:Map, Property:MapElementProperty)
      => mapNotFound
    requires notBool (mapCount(M, Property) >Int 0)
    [trusted]
endmodule

module PROOF-MAP-SEMANTICS
  imports MAP-SEMANTICS

  claim mapSelectProperty(M:Map, Property:MapElementProperty)
      => mapSelected(?Key:KItem, ?Value:KItem, ?M:Map)
    requires mapCount(M, Property) >Int 0
    ensures applyMapElementProperty(Property, ?Key, ?Value)
        andBool M ==K (?Key |-> ?Value ?M)

  claim mapSelectProperty(M:Map, Property:MapElementProperty)
      => mapNotFound
    requires notBool (mapCount(M, Property) >Int 0)

  claim #mapSelectProperty(M:Map, Property:MapElementProperty, Processed:Map)
      => mapSelected(?Key:KItem, ?Value:KItem, ?M:Map)
    requires mapCount(M, Property) >Int 0
    ensures applyMapElementProperty(Property, ?Key, ?Value)
        andBool (?Key |-> ?Value ?M) ==K (M Processed)

  claim #mapSelectProperty(M:Map, Property:MapElementProperty, _Processed:Map)
      => mapNotFound
    requires notBool (mapCount(M, Property) >Int 0)

endmodule