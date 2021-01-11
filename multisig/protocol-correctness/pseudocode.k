module PSEUDOCODE-SYNTAX
  imports INT
  imports LIST
  imports STRING

  syntax CodeMetadata ::= "CodeMetadata::DEFAULT"     [function]
                      |   "CodeMetadata::UPGRADEABLE" [function]
                      |   "CodeMetadata::PAYABLE"     [function]
                      |   "CodeMetadata::READABLE"    [function]

  syntax Usize ::= Int  // TODO: int32
  syntax BigUint ::= Int  // Assumes no operations on this.
  syntax CodeMetadata ::= Int  // Assumes no operations on this.
  syntax UserRole ::= "None" | "Proposer" | "BoardMember"
  syntax BoxedBytes ::= bytes(String)
  syntax Address ::= address(Int)
  syntax Action ::= "Nothing"
                |   AddBoardMember(Address)
                |   AddProposer(Address)
                |   RemoveUser(Address)
                |   ChangeQuorum(Usize)
                |   SendEgld(to: Address, amount: BigUint, data: BoxedBytes)
                |   SCDeploy(
                        amount: BigUint,
                        code: BoxedBytes,
                        codeMetadata: CodeMetadata,
                        arguments: ExpressionList)  // list of BoxedBytes
                |   SCCall(
                        to: Address,
                        amount: BigUint,
                        function: BoxedBytes,
                        arguments: ExpressionList)  // list of BoxedBytes

  syntax Variable ::= r"[A-Za-z_][A-Za-z_0-9]*" [token]
  syntax Variable ::= "action"        [token]
                  |   "action_id"     [token]
                  |   "address"       [token]
                  |   "caller"        [token]
                  |   "caller_id"     [token]
                  |   "caller_role"   [token]
                  |   "code_metadata" [token]
                  |   "data"          [token]
                  |   "gas_left"      [token]
                  |   "i"             [token]
                  |   "new_address"   [token]
                  |   "quorum"        [token]
                  |   "user_id"       [token]
                  |   "result"        [token]

  syntax ExternalCommands ::= ExternalCommand
                          |   ExternalCommand ExternalCommands
  syntax ExternalCommand  ::= "from" Address "run" EndpointCall ";"

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
  syntax Value  ::= Usize
                |   "void"
                |   Bool
                |   UserRole
                |   Action
                |   Address
                |   BoxedBytes
                |   BigUint
                |   CodeMetadata
  syntax Expression ::= FunctionCall
                    |   Variable
                    |   ExpressionList
                    |   Value
                    |   Expression "+" Expression
                    |   Expression "-" Expression
                    |   Expression "|" Expression
                    >   Expression "==" Expression
                    |   Expression "<=" Expression
                    |   Expression ">" Expression
                    |   "!" Expression

  syntax ExpressionCSV  ::= Expression
                        |   Expression "," ExpressionCSV

  syntax ExpressionList ::= "[" "]"
                        |   "[" ExpressionCSV "]"

  syntax FunctionCall ::= FunctionTag "(" ")"
                      |   FunctionTag "(" ExpressionCSV ")"

  syntax FunctionTag  ::= "proposeAction"             // (action)
                      |   "setQuorum"                 // (quorum)
                      |   "setActionLastIndex"        // (index)
                      |   "setActionData"             // (action_id, action)
                      |   "setActionSignerIDs"        // (action_id, signer_list)
                      |   "setNumBoardMembers"        // (usize)
                      |   "setNumProposers"           // (usize)
                      |   "setNumUsers"               // (usize)
                      |   "setUserId"                 // (address, user_id)
                      |   "setUserAddress"            // (user_id, address)
                      |   "setUserIdToRole"           // (user_id, role)
                      |   "getActionData"             // (action_id)
                      |   "getActionSignerIds"        // (action_id)
                      |   "getActionValidSignerCount" // (action_id)
                      |   "getCaller"                 // ()
                      |   "getNumBoardMembers"        // ()
                      |   "getNumProposers"           // ()
                      |   "getNumUsers"               // ()
                      |   "getOrCreateUser"           // (address)
                      |   "getUserId"                 // (address)
                      |   "getUserIdToRole"           // (user_id)
                      |   "getActionLastIndex"        // ()
                      |   "getQuorum"                 // ()
                      |   "getGasLeft"                // ()
                      |   "deployContract"            // (gas_left, amount, code, code_metadata, arguments)
                      |   "userRoleCanPropose"        // (user_role)
                      |   "userRoleCanSign"           // (user_role)
                      |   "userRoleCanPerformAction"  // (user_role)
                      |   "userRoleCanDiscardAction"  // (user_role)
                      |   "listContains"              // ([list], Usize)
                      |   "listFind"                  // ([list], Usize)
                      |   "listLen"                   // ([list])
                      |   "listSwapRemove"            // ([list])
                      |   "isEmptyList"               // ([list])
                      |   "pushList"                  // ([list], Usize)
                      |   "isEmptyActionData"         // (action_id)
                      |   "canSign"                   // (user_id)
                      |   "performAction"             // (action_id)
                      |   "performActionFromId"       // (action_id)
                      |   "quorumReached"             // (action_id)
                      |   "clearAction"               // (action_id)
                      |   "changeUserRole"            // (user_id, user_role)
                      |   "countCanSign"              // ([list])
                      |   "sendTx"                    // (address, amount, data)
                      |   "asyncCall"                 // (address, amount, [data])
                      |   EndpointTag

  syntax EndpointCall ::= EndpointTag "(" ")"
                      |   EndpointTag "(" ExpressionCSV ")"

  syntax EndpointTag  ::= "init"                // (quorum, board)
                      |   "proposeAddBoardMember"  // (user_id)
                      |   "proposeAddProposer"  // (user_id)
                      |   "proposeRemoveUser"  // (user_id)
                      |   "proposeChangeQuorum"  // (quorum)
                      |   "proposeSendEgld"  // (address, amount, args)
                      |   "proposeSCDeploy"  // (amount, code, upgradeable, payable, readable, args)
                      |   "proposeSCCall"  // (to_address, amount, function, args)
                      |   "sign"  // (action_id)
                      |   "unsign"  // (action_id)
                      |   "performActionEndpoint"  // (action_id)
                      |   "discardAction"   // (action_id)

  syntax KItem ::= runExternalCalls(ExternalCommands)
  syntax KItem ::= runExternalCall(ExternalCommand)
  syntax KItem ::= runPseudoCode(Instructions)
  syntax KItem ::= runInstruction(Instruction)
  syntax KItem ::= evaluate(Expression)
  syntax KItem ::= evaluateL(ExpressionCSV)


endmodule

module PSEUDOCODE
  imports PSEUDOCODE-CONFIGURATION
  imports PSEUDOCODE-DETAILS
  imports PSEUDOCODE-EXPRESSION
  imports PSEUDOCODE-EXTERNAL
  imports PSEUDOCODE-FOR
  imports PSEUDOCODE-FUNCTIONS
  imports PSEUDOCODE-IF
  imports PSEUDOCODE-INSTRUCTIONS
  imports PSEUDOCODE-MEMORY
  imports PSEUDOCODE-SYNTAX
endmodule

module PSEUDOCODE-INSTRUCTIONS
  imports PSEUDOCODE-COMMON
  imports PSEUDOCODE-CONFIGURATION
  imports PSEUDOCODE-SYNTAX

  rule runPseudoCode(I:Instruction) => runInstruction(I)
  rule runPseudoCode(I:Instruction Is:Instructions)
      => runInstruction(I) ~> runPseudoCode(Is)

  rule  <k> error ~> (runPseudoCode(_) => .K) ...</k>
        <stack> ListItem(_) ... </stack>
  rule  <k> error ~> (runPseudoCode(_) => .K) ...</k>
        <stack> .List </stack>
  rule  <k> error => .K </k>
        <stack> .List </stack>

  rule runInstruction(E:Expression;) => evaluate(E)
  rule (evaluate(E:Expression) => .K) ~> runInstruction(_)
    requires isKResult(E)
  rule (evaluate(E:Expression) => .K) ~> runPseudoCode(_)
    requires isKResult(E)

  context runInstruction(require({HOLE:Expression => evaluate(HOLE)}:>Expression);)
  rule runInstruction(require(true);) => evaluate(void)
  rule runInstruction(require(false);) => error
endmodule

module PSEUDOCODE-EXTERNAL
  imports PSEUDOCODE-COMMON
  imports PSEUDOCODE-CONFIGURATION
  imports PSEUDOCODE-SYNTAX

  rule runExternalCalls(C:ExternalCommand) => runExternalCall(C)
  rule runExternalCalls(C:ExternalCommand Cs:ExternalCommands)
      => runExternalCall(C) ~> runExternalCalls(Cs)

  syntax KItem ::= "clearExternalCallEnv"
  rule  <k> clearExternalCallEnv => .K ... </k>
        <caller-address> _ => uninitialized </caller-address>

  rule (evaluate(E:Expression) => .K) ~> clearExternalCallEnv
    requires isKResult(E)


  syntax KItem ::= endpointToInstruction(EndpointCall)
  rule endpointToInstruction(Tag:EndpointTag()) => runInstruction(Tag();)
  rule endpointToInstruction(Tag:EndpointTag(Es:ExpressionCSV)) => runInstruction(Tag(Es);)

  rule  <k>
            runExternalCall(from A:Address run Call:EndpointCall;)
            => endpointToInstruction(Call) ~> clearExternalCallEnv
        ...</k>
        <caller-address> uninitialized => A </caller-address>

endmodule

module PSEUDOCODE-MEMORY
  imports PSEUDOCODE-COMMON
  imports PSEUDOCODE-CONFIGURATION
  imports PSEUDOCODE-SYNTAX

  context runInstruction(_:Variable = {HOLE => evaluate(HOLE)}:>Expression;)
  
  rule  <k> runInstruction(V:Variable = E:Expression;) => .K ...</k>
        <variables> (.Map => V |-> E) M:Map </variables>
    requires isKResult(E) andBool notBool V in_keys(M)
  rule  <k> runInstruction(V:Variable = E:Expression;) => .K ...</k>
        <variables> V |-> (_ => E) ... </variables>
    requires isKResult(E)

  rule  <k> evaluate(V:Variable => E) ... </k>
        <variables> V |-> E:Expression ... </variables>
endmodule

module PSEUDOCODE-FOR
  imports PSEUDOCODE-COMMON
  imports PSEUDOCODE-SYNTAX

  syntax Instruction ::= "for" "(" indexVar:Variable "=" value:Int "," valueVar:Variable ")" "in" ExpressionList Block

  context runInstruction(for(_:Variable, _:Variable) in {HOLE:Expression => evaluate(HOLE)}:>Expression _:Block)
  rule runInstruction(for(_:Variable, _:Variable) in [] _:Block) => .K
  rule runInstruction(for(Index:Variable, Value:Variable) in ([_] #as L:ExpressionList) B:Block)
        => runInstruction(for(Index = 0, Value) in L B)
    requires isKResult(L)
  
  rule runInstruction(for(IndexVar:Variable = Index:Int, ValueVar:Variable) in [E:Expression] {B:Instructions})
        => runPseudoCode(IndexVar = Index; ValueVar = E; B)
    requires isKResult(E)
  rule runInstruction(for(IndexVar:Variable = Index:Int, ValueVar:Variable) in [E:Expression, Es:ExpressionCSV] {B:Instructions})
        => runPseudoCode(IndexVar = Index; ValueVar = E; B)
            ~> runInstruction(for(IndexVar = Index +Int 1, ValueVar) in [Es:ExpressionCSV] {B})
    requires isKResult(E)
endmodule

module PSEUDOCODE-IF
  imports PSEUDOCODE-COMMON
  imports PSEUDOCODE-SYNTAX

  context runInstruction(if({HOLE:Expression => evaluate(HOLE)}:>Expression) _:Block)
  context runInstruction(if({HOLE:Expression => evaluate(HOLE)}:>Expression) _:Block else _:Block)

  rule runInstruction(if(true) {Is:Instructions}) => runPseudoCode(Is)
  rule runInstruction(if(false) _:Block) => evaluate(void)

  rule runInstruction(if(true) {Is:Instructions} else _:Block) => runPseudoCode(Is)
  rule runInstruction(if(false) _:Block else {Is:Instructions}) => runPseudoCode(Is)
endmodule

module PSEUDOCODE-EXPRESSION
  imports PSEUDOCODE-COMMON
  imports PSEUDOCODE-SYNTAX

  context evaluate(! {HOLE:Expression => evaluate(HOLE)}:>Expression)
  rule evaluate((! false) => true)
  rule evaluate((! true) => false)

  context evaluate({HOLE:Expression => evaluate(HOLE)}:>Expression <= _:Expression)
  context evaluate(A:Expression <= {HOLE:Expression => evaluate(HOLE)}:>Expression) requires isKResult(A)
  rule evaluate((A:Int <= B:Int) => (A <=Int B))

  context evaluate({HOLE:Expression => evaluate(HOLE)}:>Expression > _:Expression)
  context evaluate(A:Expression > {HOLE:Expression => evaluate(HOLE)}:>Expression) requires isKResult(A)
  rule evaluate((A:Int > B:Int) => (A >Int B))

  context evaluate({HOLE:Expression => evaluate(HOLE)}:>Expression == _:Expression)
  context evaluate(A:Expression == {HOLE:Expression => evaluate(HOLE)}:>Expression) requires isKResult(A)
  rule evaluate((A:Expression == B:Expression) => (A ==K B))
    requires isKResult(A) andBool isKResult(B)

  context evaluate({HOLE:Expression => evaluate(HOLE)}:>Expression + _:Expression)
  context evaluate(A:Expression + {HOLE:Expression => evaluate(HOLE)}:>Expression) requires isKResult(A)
  rule evaluate((A:Int + B:Int) => (A +Int B))

  context evaluate({HOLE:Expression => evaluate(HOLE)}:>Expression - _:Expression)
  context evaluate(A:Expression - {HOLE:Expression => evaluate(HOLE)}:>Expression) requires isKResult(A)
  rule evaluate((A:Int - B:Int) => (A -Int B))

  context evaluate({HOLE:Expression => evaluate(HOLE)}:>Expression | _:Expression)
  context evaluate(A:Expression | {HOLE:Expression => evaluate(HOLE)}:>Expression) requires isKResult(A)
  rule evaluate((A:Int | B:Int) => (A |Int B))

  context evaluate([{HOLE:ExpressionCSV => evaluateL(HOLE)}:>ExpressionCSV])
endmodule

module PSEUDOCODE-COMMON
  imports PSEUDOCODE-SYNTAX

  syntax KResult ::= Value

  rule CodeMetadata::DEFAULT      => 0
  rule CodeMetadata::UPGRADEABLE  => 1 <<Int 8
  rule CodeMetadata::PAYABLE      => 1 <<Int 1
  rule CodeMetadata::READABLE     => 1 <<Int 10

  syntax KItem ::= "error"
endmodule

module PSEUDOCODE-DETAILS
  imports PSEUDOCODE-COMMON
  imports PSEUDOCODE-SYNTAX

  context evaluateL({HOLE:Expression => evaluate(HOLE)}:>ExpressionCSV)
  context evaluateL({HOLE:Expression => evaluate(HOLE)}:>Expression , _:ExpressionCSV)
  context evaluateL(E:Expression , {HOLE:ExpressionCSV => evaluateL(HOLE)}:>ExpressionCSV)
    requires isKResult(E)

  rule isKResult(E:Expression , Es:ExpressionCSV) => isKResult(E) andBool isKResult(Es)

  rule isKResult([]) => true
  rule isKResult([Es:ExpressionCSV]) => isKResult(Es)
endmodule

module PSEUDOCODE-FUNCTIONS
  imports BOOL
  imports MAP

  imports PSEUDOCODE-COMMON
  imports PSEUDOCODE-CONFIGURATION
  imports PSEUDOCODE-SYNTAX

  syntax KResult

  syntax KItem ::= "pushContext" | "popContext" | "evaluateReturnValue"
  syntax KItem ::= call(Expression)
  syntax KItem ::= Expression

  syntax Stack ::= stackEntry(MultisigStateCell, Map)

  context evaluate(_:FunctionTag(
          {HOLE => evaluateL(HOLE)}:>ExpressionCSV
      ))

  rule  <k> evaluate(_:FunctionTag(Args:ExpressionCSV) #as FunctionCall)
            => (pushContext ~> call(FunctionCall) ~> popContext ~> evaluateReturnValue)
        ...</k>
    requires isKResult(Args)
  rule  <k> evaluate(_:FunctionTag() #as FunctionCall)
            => (pushContext ~> call(FunctionCall) ~> popContext ~> evaluateReturnValue)
        ...</k>

  rule  <k> pushContext => .K ... </k>
        <state>
          S:MultisigStateCell
          <pseudocode-state>
            <variables> V:Map </variables>
            <stack> (.List => ListItem(stackEntry(S, V))) ... </stack>
          </pseudocode-state>
          _:ExternalCallEnvCell
        </state>

  rule  <k> (evaluate(E:Expression) => E) ~> popContext ... </k>
    requires isKResult(E)

  rule  <k> E:Expression ~> (popContext => .K) ... </k>
        <variables> _ => V </variables>
        <stack> (ListItem(stackEntry(_, V:Map)) => .List) ... </stack>
    requires isKResult(E)

  rule  <k> (E:Expression ~> evaluateReturnValue) => evaluate(E) ... </k>
    requires isKResult(E)

  rule  <k> error ~> (popContext => .K) ...</k>
        <state> 
          (_ => S)
          <pseudocode-state>
            <variables> _ => V </variables>
            <stack> (ListItem(stackEntry(S:MultisigStateCell, V:Map)) => .List) ... </stack>
          </pseudocode-state>
          _:ExternalCallEnvCell
        </state>

  rule <k> error ~> (evaluateReturnValue => .K) ... </k>

  context runInstruction(ok({HOLE:Expression => evaluate(HOLE)}:>Expression);)
  rule runInstruction(ok(E:Expression);) => E requires isKResult(E)

  rule call(init(Quorum:Usize, Board:ExpressionList)) =>
      runPseudoCode(
        require(!isEmptyList(Board));
        require(Quorum <= listLen(Board));
        setQuorum(Quorum);
        for (i, address) in Board {
            user_id = i + 1;
            setUserId(address, user_id);
            setUserAddress(user_id, address);
            setUserIdToRole(user_id, BoardMember);
        }
        setNumUsers(listLen(Board));
        setNumBoardMembers(listLen(Board));
        ok(void);
      )

  rule call(proposeAddBoardMember(Member:Address)) =>
      runPseudoCode(
        proposeAction(AddBoardMember(Member));
      )

  rule call(proposeAddProposer(Member:Address)) =>
      runPseudoCode(
        proposeAction(AddProposer(Member));
      )

  rule call(proposeRemoveUser(Member:Address)) =>
      runPseudoCode(
        proposeAction(RemoveUser(Member));
      )

  rule call(proposeChangeQuorum(Quorum:Usize)) =>
      runPseudoCode(
        proposeAction(ChangeQuorum(Quorum));
      )

  rule call(proposeSendEgld(To:Address, Amount:BigUint)) =>
      runPseudoCode(
        proposeAction(SendEgld(To, Amount, bytes("")));
      )

  rule call(proposeSendEgld(To:Address, Amount:BigUint, Data:BoxedBytes)) =>
      runPseudoCode(
        proposeAction(SendEgld(To, Amount, Data));
      )

  rule call(proposeSCDeploy(
          Amount:BigUint,
          Code:BoxedBytes,
          Upgradeable:Bool,
          Payable:Bool,
          Readable:Bool,
          Args:ExpressionList)) =>
      runPseudoCode(
          code_metadata = CodeMetadata::DEFAULT;
          if (Upgradeable) {
            code_metadata = code_metadata | CodeMetadata::UPGRADEABLE;
          }
          if (Payable) {
            code_metadata = code_metadata | CodeMetadata::PAYABLE;
          }
          if (Readable) {
            code_metadata = code_metadata | CodeMetadata::READABLE;
          }
          proposeActionSCDeploy(Amount, Code, code_metadata, Args);
      )

  syntax FunctionTag ::= "proposeActionSCDeploy"
  rule  call(proposeActionSCDeploy(Amount:BigUint, Code:BoxedBytes, CodeMetadata:CodeMetadata, Args:ExpressionList))
        => runPseudoCode(proposeAction(SCDeploy(Amount, Code, CodeMetadata, Args));)

  rule call(proposeSCCall(To:Address, Amount:BigUint, Function:BoxedBytes, Args:ExpressionList)) =>
      runPseudoCode(
        proposeAction(SCCall(To, Amount, Function, Args));
      )

  rule call(sign(ActionId:Usize)) =>
      runPseudoCode(
        require(!isEmptyActionData(ActionId));
        caller_address = getCaller();
        caller_id = getUserId(caller_address);
        caller_role = getUserIdToRole(caller_id);
        require(canSign(caller_role));

        signer_ids = getActionSignerIds(ActionId);
        if (!listContains(signer_ids, caller_id)) {
          signer_ids = pushList(signer_ids, caller_id);
          setActionSignerIDs(ActionId, signer_ids);
        }

        ok(void);
      )

  rule call(unsign(ActionId:Usize)) =>
      runPseudoCode(
        require(!isEmptyActionData(ActionId));

        caller_address = getCaller();
        caller_id = getUserId(caller_address);
        caller_role = getUserIdToRole(caller_id);
        require(canSign(caller_role));

        signer_ids = getActionSignerIds(ActionId);
        signer_pos = listFind(signer_ids, caller_id);
        if (0 <= signer_pos) {
          signer_ids = listSwapRemove(signer_ids, signer_pos);
          setActionSignerIDs(ActionId, signer_ids);
        }

        ok(void);
      )

  rule call(proposeAction(A:Action))
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
            ok(action_id);
        )

  rule call(performActionEndpoint(ActionId:Usize))
      => runPseudoCode(
            caller_address = getCaller();
            caller_id = getUserId(caller_address);
            caller_role = getUserIdToRole(caller_id);
            require(userRoleCanPerformAction(caller_role));
            require(quorumReached(ActionId));
            performActionFromId(ActionId);
      )

  rule call(discardAction(ActionId:Usize))
        => runPseudoCode(
              caller_address = getCaller();
              caller_id = getUserId(caller_address);
              caller_role = getUserIdToRole(caller_id);
              require(userRoleCanDiscardAction(caller_role));
              require(getActionValidSignerCount(ActionId) == 0);
              clearAction(ActionId);
              ok(void);
        )

  rule  call(userRoleCanPropose(None)) => false
  rule  call(userRoleCanPropose(Proposer)) => true
  rule  call(userRoleCanPropose(BoardMember)) => true

  rule  call(userRoleCanSign(None)) => false
  rule  call(userRoleCanSign(Proposer)) => false
  rule  call(userRoleCanSign(BoardMember)) => true

  rule  call(userRoleCanPerformAction(R:UserRole) => userRoleCanPropose(R))

  rule  call(userRoleCanDiscardAction(R:UserRole) => userRoleCanPropose(R))

  rule  call(isEmptyList([])) => true
  rule  call(isEmptyList([_:ExpressionCSV])) => false

  syntax KItem ::= "plusOne"
  rule  call(listLen([])) => 0
  rule  call(listLen([_:Expression])) => 1
  rule  call(listLen([_:Expression , Es:ExpressionCSV]))
        => call(listLen([Es])) ~> plusOne
  rule  (I:Int ~> plusOne) => I +Int 1

  rule  <k> call(setQuorum(Quorum:Usize)) => void ... </k>
        <quorum>_ => Quorum</quorum>

  rule  <k> call(setNumUsers(Users:Usize)) => void ... </k>
        <num-users>_ => Users</num-users>

  rule  <k> call(setNumBoardMembers(Members:Usize)) => void ... </k>
        <num-board-members>_ => Members</num-board-members>

  rule  <k> call(setNumProposers(Proposers:Usize)) => void ... </k>
        <num-proposers>_ => Proposers</num-proposers>

  rule  <k> call(setUserId(A:Address, I:Usize)) => void ... </k>
        <address-to-user-id>(.Map => A |-> I) M:Map </address-to-user-id>
    requires notBool A in_keys(M)

  rule  <k> call(setUserAddress(I:Usize, A:Address)) => void ... </k>
        <user-id-to-address>(.Map => I |-> A) M:Map </user-id-to-address>
    requires notBool I in_keys(M)

  rule  <k> call(setUserIdToRole(I:Usize, R:UserRole)) => void ... </k>
        <user-roles>(.Map => I |-> R) M:Map </user-roles>
    requires notBool I in_keys(M)
  rule  <k> call(setUserIdToRole(I:Usize, R:UserRole)) => void ... </k>
        <user-roles> I |-> (_ => R) ... </user-roles>

  rule  <k> call(getCaller()) => A ... </k>
        <caller-address> A:Address </caller-address>

  rule  <k> call(getQuorum()) => Quorum ... </k>
        <quorum> Quorum:Usize </quorum>

  rule  <k> call(getUserId(A:Address)) => I ... </k>
        <address-to-user-id> A |-> I:Usize ...</address-to-user-id>

  rule  <k> call(getUserId(A:Address)) => 0 ... </k>
        <address-to-user-id> M:Map </address-to-user-id>
    requires notBool A in_keys(M)

  rule  <k> call(getUserIdToRole(I:Usize)) => R ... </k>
        <user-roles> I |-> R:UserRole ...</user-roles>
  rule  <k> call(getUserIdToRole(I:Usize)) => None ... </k>
        <user-roles> M </user-roles>
    requires notBool I in_keys(M)

  rule  <k> call(getActionLastIndex()) => Index ... </k>
        <action-last-index> Index:Usize </action-last-index>

  rule  <k> call(setActionLastIndex(Index:Usize)) => void ... </k>
        <action-last-index> _ => Index </action-last-index>

  rule  <k> call(getNumUsers()) => Users ... </k>
        <num-users> Users:Usize </num-users>

  rule  <k> call(getNumBoardMembers()) => Members ... </k>
        <num-board-members> Members:Usize </num-board-members>

  rule  <k> call(getNumProposers()) => Proposers ... </k>
        <num-proposers> Proposers:Usize </num-proposers>

  rule  <k> call(setActionData(ActionId:Usize, A:Action)) => void ... </k>
        <action-data> (.Map => ActionId |-> A) M:Map </action-data>
    requires notBool ActionId in_keys(M)

  rule  <k> call(setActionData(ActionId:Usize, A:Action)) => void ... </k>
        <action-data> ActionId |-> (_ => A) ... </action-data>

  rule  <k> call(getActionData(ActionId:Usize)) => A ... </k>
        <action-data> ActionId |-> A:Action ...</action-data>

  rule  <k> call(setActionSignerIDs(ActionId:Usize, Signers:ExpressionList)) => void ... </k>
        <action-signers> (.Map => ActionId |-> Signers) M:Map </action-signers>
    requires notBool ActionId in_keys(M) andBool isKResult(Signers)

  rule  <k> call(setActionSignerIDs(ActionId:Usize, Signers:ExpressionList)) => void ... </k>
        <action-signers> ActionId |-> (_ => Signers) ... </action-signers>

  rule  <k> call(isEmptyActionData(ActionId:Usize)) => false ... </k>
        <action-data> ActionId |-> _ ... </action-data>
  rule  <k> call(isEmptyActionData(ActionId:Usize)) => true ... </k>
        <action-data> M:Map </action-data>
    requires notBool ActionId in_keys(M)
  rule  <k> call(isEmptyActionData(ActionId:Usize)) => notBool ActionId in_keys(M) ... </k>
        <action-data> M:Map </action-data>

  rule  call(canSign(BoardMember)) => true
  rule  call(canSign(_)) => false  [owise]

  rule  <k> call(getActionSignerIds(ActionId:Usize)) => Signers ... </k>
        <action-signers> ActionId |-> Signers:ExpressionList ... </action-signers>

  rule  call(listContains([], _)) => false
  rule  call(listContains([E:Int], X:Int)) => X ==Int E
  rule  call(listContains([X:Usize, _:ExpressionCSV], X)) => true
  rule  call(listContains([_:Usize, Es:ExpressionCSV], X:Usize) => listContains([Es], X))  [owise]

  rule  call(listFind([], _)) => -1
  rule  call(listFind([X:Usize], X)) => 0
  rule  call(listFind([_:Usize], _:Usize)) => -1  [owise]
  rule  call(listFind([X:Usize, _:ExpressionCSV], X)) => 0
  rule  call(listFind([_:Usize, Es:ExpressionCSV], X:Usize)) => call(listFind([Es], X)) ~> plusOne  [owise]

  rule  call(listSwapRemove([_:Expression], 0:Usize)) => []
  rule  call(listSwapRemove([_:Expression , L:ExpressionCSV], 0:Usize)) => lastToStart(L)
  rule  call(listSwapRemove([E:Expression , L:ExpressionCSV], Index:Int))
        => call(listSwapRemove([L], Index -Int 1)) ~> pushListFreezer(E)
    requires Index >Int 0

  syntax KItem ::= pushListFreezer(Expression)
  rule  [L:ExpressionCSV] ~> pushListFreezer(E:Expression) => [E , L]

  syntax KItem ::= lastToStart(ExpressionCSV)
  syntax KItem ::= #lastToStart(ExpressionCSV, ExpressionCSV)
  syntax KItem ::= reverseExpressionCsv(ExpressionCSV, ExpressionCSV)

  rule lastToStart(E:Expression) => E
  rule lastToStart(E:Expression , L:ExpressionCSV) => #lastToStart(E, L)

  rule #lastToStart(L1:ExpressionCSV, (E:Expression , L2:ExpressionCSV)) => #lastToStart((E , L1), L2)
  rule #lastToStart(E1:Expression, E:Expression) => E , E1
  rule #lastToStart((E1:Expression , L1:ExpressionCSV):ExpressionCSV, E:Expression)
        => reverseExpressionCsv(L1, E1) ~> pushListFreezer(E)

  rule reverseExpressionCsv((E1:Expression):ExpressionCSV, L2:ExpressionCSV) => E1 , L2
  rule reverseExpressionCsv((E:Expression , Es:ExpressionCSV), L2:ExpressionCSV) => reverseExpressionCsv(Es, (E , L2))

  rule call(performActionFromId(ActionId:Usize))
        => runPseudoCode(
              action = getActionData(ActionId);
              clearAction(ActionId);
              performAction(action);

        )

  rule call(performAction(Nothing)) => evaluate(void)

  rule call(performAction(AddBoardMember(BoardMemberAddress:Address)))
        => runPseudoCode(
              changeUserRole(BoardMemberAddress, BoardMember);
        )

  rule call(performAction(AddProposer(ProposerAddress:Address)))
        => runPseudoCode(
              changeUserRole(ProposerAddress, Proposer);
        )

  rule call(performAction(RemoveUser(UserAddress:Address)))
        => runPseudoCode(
              changeUserRole(UserAddress, None);
              num_board_members = getNumBoardMembers();
              num_proposers = getNumProposers();
              require(num_board_members + num_proposers > 0);
              require(getQuorum() <= num_board_members);
        )

  rule call(performAction(ChangeQuorum(NewQuorum)))
        => runPseudoCode(
              require(NewQuorum <= getNumBoardMembers());
              setQuorum(NewQuorum);
        )

  rule call(performAction(SendEgld(To:Address, Amount:BigUint, Data:BoxedBytes)))
        => runPseudoCode(
              sendTx(To, Amount, Data);
        )

  rule call(performAction(SCDeploy(
            Amount:BigUint,
            Code:BoxedBytes,
            CodeMetadata:CodeMetadata,
            Arguments:ExpressionList)))
        => runPseudoCode(
              gas_left = getGasLeft();
              new_address = deployContract(gas_left, Amount, Code, CodeMetadata, Arguments);
              [new_address];
        )

  rule call(performAction(SCCall(To:Address, Amount:BigUint, Function:BoxedBytes, [])))
        => runPseudoCode(
              asyncCall(To, Amount, [Function]);
        )

  rule call(performAction(SCCall(To:Address, Amount:BigUint, Function:BoxedBytes, [Arguments:ExpressionCSV])))
        => runPseudoCode(
              asyncCall(To, Amount, [Function , Arguments]);
        )

  rule call(clearAction(ActionId:Usize))
        => runPseudoCode(
              setActionData(ActionId, Nothing);
              setActionSignerIDs(ActionId, []);
        )

  rule call(quorumReached(ActionId:Usize))
        => runPseudoCode(
              quorum = getQuorum();
              valid_signers_count = getActionValidSignerCount(ActionId);
              quorum <= valid_signers_count;
        )

  rule call(getActionValidSignerCount(ActionId:Usize))
        => runPseudoCode(
              signer_ids = getActionSignerIds(ActionId);
              countCanSign(signer_ids);
        )

  rule call(countCanSign([])) => 0
  rule call(countCanSign([SignerId:Usize]))
        => runPseudoCode(
              result = 0;
              user_role = getUserIdToRole(SignerId);
              if (userRoleCanSign(user_role)) {
                result = 1;
              }
              result;
        )
  rule call(countCanSign([SignerId:Usize , SignerIds:ExpressionCSV]))
        => runPseudoCode(
              result = 0;
              user_role = getUserIdToRole(SignerId);
              if (userRoleCanSign(user_role)) {
                result = 1;
              }
              result + countCanSign([SignerIds]);
        )

  rule call(changeUserRole(UserAddress:Address, NewRole:UserRole))
        => runPseudoCode(
          user_id = getOrCreateUser(UserAddress);
          old_role = None;
          if (!(user_id == 0)) {
            old_role = getUserIdToRole(user_id);
          }
          setUserIdToRole(user_id, NewRole);

          if (old_role == BoardMember) {
            if (!(NewRole == BoardMember)) {
              setNumBoardMembers(getNumBoardMembers() - 1);
            }
          } else {
            if (NewRole == BoardMember) {
              setNumBoardMembers(getNumBoardMembers() + 1);
            }
          }

          if (old_role == Proposer) {
            if (!(NewRole == Proposer)) {
              setNumProposers(getNumProposers() - 1);
            }
          } else {
            if (NewRole == Proposer) {
              setNumProposers(getNumProposers() + 1);
            }
          }
        )

  rule call(getOrCreateUser(Address:Address))
        => runPseudoCode(
              user_id = getUserId(Address);
              if (user_id == 0) {
                num_users = getNumUsers();
                num_users = num_users + 1;
                setNumUsers(num_users);
                user_id = num_users;
                setUserId(Address, user_id);
                setUserAddress(user_id, Address);
              }
              user_id;
        )

  rule call(pushList([], E:Expression))
        => evaluate([E])
  rule call(pushList([E1:Expression], E2:Expression))
        => evaluate([E1 , E2])
  rule call(pushList([E:Expression , Es:ExpressionCSV], E2:Expression))
        => call(pushList([Es], E2)) ~> prepend(E)
  
  syntax KItem ::= prepend(Expression)
  rule (evaluate([]) ~> prepend(E:Expression)) => evaluate([E])
  rule (evaluate([Es:ExpressionCSV]) ~> prepend(E:Expression)) => evaluate([E , Es])

  rule call(sendTx(_To:Address, _Amount:BigUint, _Data:BoxedBytes))
        => evaluate(void)

  rule call(getGasLeft()) => evaluate(-1)

  rule call(deployContract(
            _GasLeft:Int,
            _Amount:BigUint,
            _Code:BoxedBytes,
            _:CodeMetadata,
            Arguments:ExpressionList))
        => evaluate(void)
    requires isKResult(Arguments)

  rule call(asyncCall(
            _:Address,
            _Amount:BigUint,
            Arguments:ExpressionList))
        => evaluate(void)
    requires isKResult(Arguments)

endmodule

module PSEUDOCODE-CONFIGURATION
  imports MAP

  imports PSEUDOCODE-SYNTAX

  syntax KItem ::= "uninitialized"

  configuration
    <T>
      <k color="green"> runExternalCalls($PGM:ExternalCommands) </k>
  
      <state>
        <multisig-state>
          <users>
            <num-users>uninitialized</num-users>
            <user-id-to-address>.Map</user-id-to-address>
            <address-to-user-id>.Map</address-to-user-id>
          </users>
          <board-state>
            <num-board-members>uninitialized</num-board-members>
            <quorum>uninitialized</quorum>
            <num-proposers>0:Usize</num-proposers>
            <user-roles>.Map</user-roles>
          </board-state>
          <action-state>
            <action-last-index>0:Usize</action-last-index>
            <actions>
              <action-data>.Map</action-data>
              <action-signers>.Map</action-signers>
            </actions>
          </action-state>
        </multisig-state>
        <pseudocode-state>
          <variables>.Map</variables>
          <stack> .List </stack>
        </pseudocode-state>
        <external-call-env>
          <caller-address>uninitialized</caller-address>
        </external-call-env>
      </state>
  </T>

  syntax StateCell ::= "initialState"   [function]
  rule initialState =>
      <state>
        <multisig-state>
          <users>
            <num-users>uninitialized</num-users>
            <user-id-to-address>.Map</user-id-to-address>
            <address-to-user-id>.Map</address-to-user-id>
          </users>
          <board-state>
            <num-board-members>uninitialized</num-board-members>
            <quorum>uninitialized</quorum>
            <num-proposers>0:Usize</num-proposers>
            <user-roles>.Map</user-roles>
          </board-state>
          <action-state>
            <action-last-index>0:Usize</action-last-index>
            <actions>
              <action-data>.Map</action-data>
              <action-signers>.Map</action-signers>
            </actions>
          </action-state>
        </multisig-state>
        <pseudocode-state>
          <variables>.Map</variables>
          <stack> .List </stack>
        </pseudocode-state>
        <external-call-env>
          <caller-address>uninitialized</caller-address>
        </external-call-env>
      </state>
endmodule