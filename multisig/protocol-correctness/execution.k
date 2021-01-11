require "configuration.k"
require "pseudocode.k"

module EXECUTION-SYNTAX
  imports PSEUDOCODE-SYNTAX
endmodule

module EXECUTION
  imports EXECUTION-SYNTAX
  imports PSEUDOCODE

  configuration <T>
    <k color="green"> runPseudoCode($PGM:Instructions) </k>
  </T>
endmodule