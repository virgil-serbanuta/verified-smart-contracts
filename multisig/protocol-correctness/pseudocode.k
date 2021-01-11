module PSEUDOCODE-SYNTAX
  imports CONFIGURATION-SYNTAX

  syntax Variable ::= r"[A-Za-z_][A-Za-z_0-9]*" [token]

  syntax Block ::= "{" Instructions "}"
  syntax Instructions ::= Instruction
                      |   Instruction Instructions
  syntax Instruction  ::= "require" "(" Expression ")" ";"
                      |   Variable "=" Expression ";"
                      |   "if" "(" Expression ")" Block               [avoid]
                      |   "if" "(" Expression ")" Block "else" Block  [prefer]
                      |   "for" "(" index:Variable "," value:Variable ")" "in" Expression Block
                      |   Expression ";"
                      |   "ok" "(" Expression ")" ";"
  syntax Value  ::= "[" "]"
                |   "[" ValueList "]"
                |   Usize
                |   "void"
                |   Bool
                |   UserRole
                |   Action
  syntax Expression ::= Expression "+" Expression
                    |   Expression "<=" Expression
                    |   "!" Expression
                    |   FunctionCall
                    |   Variable
                    |   "[" ExpressionList "]"
                    |   Value
  syntax ValueList  ::= Value
                    |   Value "," ValueList  [klabel(exps)]
  syntax ExpressionList ::= Expression
                        |   Expression "," ExpressionList  [klabel(exps)]
                        |   ValueList

  syntax FunctionCall ::= FunctionTag "(" ")"
                      |   FunctionTag "(" ExpressionList ")"

  syntax FunctionTag  ::= "proposeAction"       // (action)
                      |   "init"                // (quorum, board)
                      |   "setQuorum"           // (quorum)
                      |   "setActionLastIndex"  // (index)
                      |   "setActionData"       // (action_id, action)
                      |   "setActionSignerIDs"  // (action_id, signer_list)
                      |   "setUserId"           // (address, user_id)
                      |   "setUserAddress"      // (user_id, address)
                      |   "setUserIdToRole"     // (user_id, role)
                      |   "getUserId"           // (address)
                      |   "getUserIdToRole"     // (user_id)
                      |   "getActionLastIndex"  // ()
                      |   "userRoleCanPropose"  // (user_role)
                      |   "userRoleCanSign"     // (user_role)
                      |   "listLen"             // ([list])
                      |   "getCaller"           // ()
                      |   "getUserId"           // (address)
                      |   "getUserIdToRole"     // (user_id)

  syntax KItem ::= runPseudoCode(Instructions)
  syntax KItem ::= runInstruction(Instruction)
  syntax KItem ::= evaluate(Expression)
  syntax KItem ::= evaluateL(ExpressionList)

  syntax Bool ::= isEmptyList(ExpressionList)
  syntax Usize ::= listLen(ExpressionList)

endmodule

module PSEUDOCODE
  imports PSEUDOCODE-INSTRUCTIONS
  imports PSEUDOCODE-DETAILS
endmodule

module PSEUDOCODE-INSTRUCTIONS
  imports PSEUDOCODE-SYNTAX

  rule runPseudoCode(I:Instruction) => runInstruction(I)
  rule runPseudoCode(I:Instruction Is:Instructions)
      => runInstruction(I) ~> runPseudoCode(Is)

  rule runInstruction(Expression;) => evaluate(Expression)
endmodule

module PSEUDOCODE-DETAILS
  imports BOOL

  imports CONFIGURATION
  imports PSEUDOCODE-SYNTAX

  configuration <T>
    <pseudocode-state>
      <variables>.Map</variables>
      <stack> .List </stack>
    </pseudocode-state>
  </T>

  syntax KResult ::= Value | ValueList

  syntax KItem ::= "pushContext" | "popContext" | "evaluateReturnValue"
  syntax KItem ::= call(FunctionCall)

  syntax Value ::= UserRole

  syntax Stack ::= stackEntry(MultisigState, Map)

  /*
  context evaluate(
      _:FunctionTag(
          HOLE => evaluateL(HOLE)
      )
  )

  context evaluateL((HOLE:Expression => evaluate(HOLE)))
  context evaluateL(HOLE:Expression => evaluate(HOLE) , _:ExpressionList)
  context evaluateL(E:Expression , HOLE:ExpressionList => evaluateL(HOLE)) requires isKResult(E)
  */

  rule isKResult((E:Expression):ExpressionList) => isKResult(E)
  rule isKResult(E:Expression , Es:ExpressionList) => isKResult(E) andBool isKResult(Es)

  rule  <k> evaluate(_:FunctionTag(Args:ExpressionList) #as FunctionCall)
            => (pushContext ~> call(FunctionCall) ~> popContext ~> evaluateReturnValue)
        ...</k>
    requires isKResult(Args)

  rule  <k> pushContext => .K ... </k>
        <state> S:MultisigState </state>
        <variables> V:Map </variables>
        <stack> (.List => ListItem(stackEntry(S, V))) ... </stack>

  rule  <k> _:Value ~> (popContext => .K) </k>
        <variables> _ => V </variables>
        <stack> (ListItem(stackEntry(_, V:Map)) => .List) ... </stack>

  rule  <k> error ~> (popContext => .K) </k>
        <state> _ => S </state>
        <variables> _ => V </variables>
        <stack> (ListItem(stackEntry(S:MultisigState, V:Map)) => .List) ... </stack>

  rule <k> error ~> (evaluateReturnValue => .K) ... </k>

  rule evaluate(init(Quorum:Usize, [Board:ExpressionList])) =>
      runPseudoCode(
        require(!isEmptyList(Board));
        require(Quorum <= listLen([Board]));
        setQuorum(Quorum);
        for (i, address) in [Board] {
            user_id = i + 1;
            setUserId(address, user_id);
            setUserAddress(user_id, address);
            setUserIdToRole(user_id, BoardMember);
        }
        setNumUsers(listLen(Board));
        ok(void);
      )
    requires isKResult(Board)

  rule evaluate(proposeAction(A:Action))
      => runPseudoCode(
            caller = getCaller();
            caller_id = getUserId(caller);
            caller_role = getUserIdToRole(caller_id);
            require(userRoleCanPropose(caller_role));
            action_id = getActionLastIndex() + 1;
            setActionLastIndex(action_id);
            setActionData(action_id, A);
            if (userRoleCanSign(caller_role)) {
              setActionSignerIDs(action_id, [caller_id]);  // TODO
            }
            ok(ActionId);
        )

  rule  evaluate(userRoleCanPropose(None) => false)
  rule  evaluate(userRoleCanPropose(Proposer) => true)
  rule  evaluate(userRoleCanPropose(BoardMember) => true)

  rule  evaluate(userRoleCanSign(None) => false)
  rule  evaluate(userRoleCanSign(Proposer) => false)
  rule  evaluate(userRoleCanSign(BoardMember) => true)

endmodule