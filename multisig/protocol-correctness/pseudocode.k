module PSEUDOCODE-SYNTAX
  imports INT
  imports LIST
  imports STRING

  syntax CodeMetadata ::= "CodeMetadata::DEFAULT"     [function]
                      |   "CodeMetadata::UPGRADEABLE" [function]
                      |   "CodeMetadata::PAYABLE"     [function]
                      |   "CodeMetadata::READABLE"    [function]

  syntax Usize ::= u(Int)  // TODO: int32
  syntax BigUint ::= big(Int)  // Assumes no operations on this.
  syntax CodeMetadata ::= meta(Int)  // Assumes no operations on this.
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
                |   Address
                |   BoxedBytes
                |   BigUint
                |   CodeMetadata
  syntax Expression ::= FunctionCall
                    |   Variable
                    |   ExpressionList
                    |   Action
                    |   Value
                    |   Expression "+" Expression
                    |   Expression "-" Expression
                    |   Expression "|" Expression
                    >   Expression "==" Expression
                    |   Expression "<=" Expression
                    |   Expression ">" Expression
                    |   "!" Expression

  syntax ExpressionCSV  ::= "."
                        |   Expression "," ExpressionCSV

  syntax ArgumentCSV  ::= Expression
                      |   Expression "," ArgumentCSV

  syntax ExpressionList ::= "[" ExpressionCSV "]"

  syntax FunctionCall ::= FunctionTag "(" ")"
                      |   FunctionTag "(" ArgumentCSV ")"

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
                      |   EndpointTag "(" ArgumentCSV ")"

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
  syntax KItem ::= evaluateEc(ExpressionCSV)
  syntax KItem ::= evaluateAc(ArgumentCSV)

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

module PSEUDOCODE-TYPE-REFLECTION
  imports MAYBE
  imports PSEUDOCODE-COMMON
  imports PSEUDOCODE-SYNTAX

  syntax ReflectionType ::= "rUsize"
                        | "rUserRole"
                        | "rExpressionList"
                        | "rBool"
                        | "rAction"
                        | "rAddress"
                        | "rBoxedBytes"
                        | "rBigUint"
                        | "rCodeMetadata"

  syntax KItem ::= cast(KItem, ReflectionType)  [strict(1)]

  syntax KResult ::= Maybe

  /*
  rule cast(nothing, _:ReflectionType) => nothing
  rule cast(just(K:KItem) => K, _:ReflectionType)
  */

  rule cast(value(K:KItem) => K, _:ReflectionType)

  rule cast(U:Usize, rUsize) => U
  rule (.K => stuck) ~> cast(V:KItem, rUsize)
    ensures notBool isUsize(V)
    [owise]

  rule cast(U:UserRole, rUserRole) => U
  rule (.K => stuck) ~> cast(V:KItem, rUserRole)
    ensures notBool isUserRole(V)
    [owise]

  rule cast(V:ExpressionList, rExpressionList) => V
  rule (.K => stuck) ~> cast(V:KItem, rExpressionList)
    ensures notBool isExpressionList(V)
    [owise]

  rule cast(A:Action, rAction) => A
  rule (.K => stuck) ~> cast(V:KItem, rAction)
    ensures notBool isAction(V)
    [owise]

  rule cast(A:Address, rAddress) => A
  rule (.K => stuck) ~> cast(V:KItem, rAddress)
    ensures notBool isAddress(V)
    [owise]

  syntax KItem ::= defaultValue(ReflectionType)  [function, functional]
  rule defaultValue(rUsize) => u(0)
  rule defaultValue(rUserRole) => None
  rule defaultValue(rExpressionList) => [.]
  rule defaultValue(rBool) => false
  rule defaultValue(rAction) => Nothing
  rule defaultValue(rAddress) => address(0)
  rule defaultValue(rBoxedBytes) => bytes("")
  rule defaultValue(rBigUint) => big(0)
  rule defaultValue(rCodeMetadata) => CodeMetadata::DEFAULT

  syntax Bool ::= valueOfType(KItem, ReflectionType)  [function, functional]
  rule valueOfType(V:KItem, rUsize) => isUsize(V)
  rule valueOfType(V:KItem, rUserRole) => isUserRole(V)
  rule valueOfType(V:KItem, rExpressionList) => isExpressionList(V)
  rule valueOfType(V:KItem, rBool) => isBool(V)
  rule valueOfType(V:KItem, rAction) => isAction(V)
  rule valueOfType(V:KItem, rAddress) => isAddress(V)
  rule valueOfType(V:KItem, rBoxedBytes) => isBoxedBytes(V)
  rule valueOfType(V:KItem, rBigUint) => isBigUint(V)
  rule valueOfType(V:KItem, rCodeMetadata) => isCodeMetadata(V)
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

  rule (E:Expression => .K) ~> clearExternalCallEnv
    requires isKResult(E)

  rule  <k> (error => .K) ~> clearExternalCallEnv ...</k>

  syntax KItem ::= endpointToInstruction(EndpointCall)
  rule endpointToInstruction(Tag:EndpointTag()) => runInstruction(Tag();)
  rule endpointToInstruction(Tag:EndpointTag(Es:ArgumentCSV)) => runInstruction(Tag(Es);)

  rule  <k>
            runExternalCall(from A:Address run Call:EndpointCall;)
            => endpointToInstruction(Call) ~> clearExternalCallEnv
        ...</k>
        <caller-address> uninitialized => A </caller-address>

endmodule

module PSEUDOCODE-MEMORY
  imports MAP-UTILS
  imports PSEUDOCODE-COMMON
  imports PSEUDOCODE-CONFIGURATION
  imports PSEUDOCODE-SYNTAX

  context runInstruction(_:Variable = {HOLE => evaluate(HOLE)}:>Expression;)

  rule  <k> (.K => mapSet(V, E, M)) ~> runInstruction(V:Variable = E:Expression;) ...</k>
        <variables> M:Map </variables>
    requires isKResult(E)
  rule <k> (M:Map ~> runInstruction(_ = _;)) => evaluate(void) ... </k>
        <variables> _:Map => M </variables>

  rule  <k> evaluate(V:Variable => E) ... </k>
        <variables> V |-> E:Expression ... </variables>
endmodule

module PSEUDOCODE-FOR
  imports PSEUDOCODE-COMMON
  imports PSEUDOCODE-SYNTAX

  syntax Instruction ::= "for" "(" indexVar:Variable "=" value:Usize "," valueVar:Variable ")" "in" ExpressionList Block

  context runInstruction(for(_:Variable, _:Variable) in {HOLE:Expression => evaluate(HOLE)}:>Expression _:Block)
  rule runInstruction(for(Index:Variable, Value:Variable) in (L:ExpressionList) B:Block)
        => runInstruction(for(Index = u(0), Value) in L B)
    requires isKResult(L)

  rule runInstruction(for(_:Variable = _:Usize, _:Variable) in [.] _:Block)
        => evaluate(void)
  rule runInstruction(
          for (IndexVar:Variable = u(Index:Int), ValueVar:Variable)
              in [E:Expression, Es:ExpressionCSV]
              {B:Instructions}
        )
        =>  runPseudoCode(IndexVar = u(Index); ValueVar = E; B)
            ~> runInstruction(for(IndexVar = u(Index +Int 1), ValueVar) in [Es:ExpressionCSV] {B})
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

  rule add(u(A:Int), u(B:Int)) => u(A +Int B)  // TODO: The other functions
  rule sub(u(A:Int), u(B:Int)) => u(A -Int B)

  context evaluate(! {HOLE:Expression => evaluate(HOLE)}:>Expression)
  rule evaluate((! false) => true)
  rule evaluate((! true) => false)

  context evaluate({HOLE:Expression => evaluate(HOLE)}:>Expression <= _:Expression)
  context evaluate(A:Expression <= {HOLE:Expression => evaluate(HOLE)}:>Expression) requires isKResult(A)
  rule evaluate((u(A:Int) <= u(B:Int)) => (A <=Int B))

  context evaluate({HOLE:Expression => evaluate(HOLE)}:>Expression > _:Expression)
  context evaluate(A:Expression > {HOLE:Expression => evaluate(HOLE)}:>Expression) requires isKResult(A)
  rule evaluate((u(A:Int) > u(B:Int)) => (A >Int B))

  context evaluate({HOLE:Expression => evaluate(HOLE)}:>Expression == _:Expression)
  context evaluate(A:Expression == {HOLE:Expression => evaluate(HOLE)}:>Expression) requires isKResult(A)
  rule evaluate((A:Expression == B:Expression) => (A ==K B))
    requires isKResult(A) andBool isKResult(B)

  context evaluate({HOLE:Expression => evaluate(HOLE)}:>Expression + _:Expression)
  context evaluate(A:Expression + {HOLE:Expression => evaluate(HOLE)}:>Expression) requires isKResult(A)
  rule evaluate(A:Usize + B:Usize => add(A, B))

  context evaluate({HOLE:Expression => evaluate(HOLE)}:>Expression - _:Expression)
  context evaluate(A:Expression - {HOLE:Expression => evaluate(HOLE)}:>Expression) requires isKResult(A)
  rule evaluate(A:Usize - B:Usize => sub(A, B))

  context evaluate({HOLE:Expression => evaluate(HOLE)}:>Expression | _:Expression)
  context evaluate(A:Expression | {HOLE:Expression => evaluate(HOLE)}:>Expression) requires isKResult(A)
  rule evaluate((u(A:Int) | u(B:Int)) => u(A |Int B))
  rule evaluate((meta(A:Int) | meta(B:Int)) => meta(A |Int B))

  context evaluate([{HOLE:ExpressionCSV => evaluateEc(HOLE)}:>ExpressionCSV])
endmodule

module PSEUDOCODE-COMMON
  imports PSEUDOCODE-SYNTAX

  syntax KResult ::= Value

  rule CodeMetadata::DEFAULT      => meta(0)
  rule CodeMetadata::UPGRADEABLE  => meta(1 <<Int 8)
  rule CodeMetadata::PAYABLE      => meta(1 <<Int 1)
  rule CodeMetadata::READABLE     => meta(1 <<Int 10)

  syntax KItem ::= "error"
  syntax KItem ::= "stuck"
  syntax Usize ::= add(Usize, Usize)  [function, functional]
  syntax Usize ::= sub(Usize, Usize)  [function, functional]

  syntax KItem ::= "removeValue"
  rule (E:Expression ~> removeValue) => .K
    requires isKResult(E)
endmodule

module PSEUDOCODE-DETAILS
  imports PSEUDOCODE-COMMON
  imports PSEUDOCODE-SYNTAX

  context evaluateAc({HOLE:Expression => evaluate(HOLE)}:>ArgumentCSV)
  context evaluateAc({HOLE:Expression => evaluate(HOLE)}:>Expression , _:ArgumentCSV)
  context evaluateAc(E:Expression , {HOLE:ArgumentCSV => evaluateAc(HOLE)}:>ArgumentCSV)
    requires isKResult(E)

  context evaluateEc({HOLE:Expression => evaluate(HOLE)}:>Expression , _:ExpressionCSV)
  context evaluateEc(E:Expression , {HOLE:ExpressionCSV => evaluateEc(HOLE)}:>ExpressionCSV)
    requires isKResult(E)

  rule isKResult(E:Expression , Es:ArgumentCSV) => isKResult(E) andBool isKResult(Es)

  rule isKResult(.:ExpressionCSV) => true
  rule isKResult(E:Expression , Es:ExpressionCSV) => isKResult(E) andBool isKResult(Es)

  rule isKResult([Es:ExpressionCSV]) => isKResult(Es)

  rule isKResult(Nothing) => true
  rule isKResult(AddBoardMember(A:Address)) => isKResult(A)
  rule isKResult(AddProposer(A:Address)) => isKResult(A)
  rule isKResult(RemoveUser(A:Address)) => isKResult(A)
  rule isKResult(ChangeQuorum(U:Usize)) => isKResult(U)
  rule  isKResult(SendEgld(To:Address, Amount:BigUint, Data:BoxedBytes))
        => isKResult(To) andBool isKResult(Amount) andBool isKResult(Data)
  rule  isKResult(SCDeploy(
                        Amount:BigUint,
                        Code:BoxedBytes,
                        CodeMetadata:CodeMetadata,
                        Arguments:ExpressionList))
        => isKResult(Amount)
            andBool isKResult(Code)
            andBool isKResult(CodeMetadata)
            andBool isKResult(Arguments)
  rule isKResult(SCCall(
                        To:Address,
                        Amount:BigUint,
                        Function:BoxedBytes,
                        Arguments:ExpressionList))
        => isKResult(To)
            andBool isKResult(Amount)
            andBool isKResult(Function)
            andBool isKResult(Arguments)
endmodule

module PSEUDOCODE-FUNCTIONS
  imports BOOL
  imports MAP

  imports MAP-UTILS
  imports PSEUDOCODE-COMMON
  imports PSEUDOCODE-CONFIGURATION
  imports PSEUDOCODE-MAP-UTILS
  imports PSEUDOCODE-SYNTAX
  imports PSEUDOCODE-TYPE-REFLECTION

  syntax KResult

  syntax KItem ::= "pushContext" | "popContext" | "evaluateReturnValue"
  syntax KItem ::= stuck(KItem)
  syntax KItem ::= call(Expression)
  syntax KItem ::= Expression

  syntax Stack ::= stackEntry(MultisigStateCell, Map)

  context evaluate(_:FunctionTag(
          {HOLE => evaluateAc(HOLE)}:>ArgumentCSV
      ))

  rule  <k> evaluate(_:FunctionTag(Args:ArgumentCSV) #as FunctionCall)
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
            <variables> V:Map => .Map </variables>
            <stack> (.List => ListItem(stackEntry(S, V))) ... </stack>
          </pseudocode-state>
          _:ExternalCallEnvCell
          _:ProofStateCell
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
          _:ProofStateCell
        </state>

  rule <k> error ~> (evaluateReturnValue => .K) ... </k>

  context runInstruction(ok({HOLE:Expression => evaluate(HOLE)}:>Expression);)
  rule runInstruction(ok(E:Expression);) => E requires isKResult(E)

  rule  call(userRoleCanPropose(None)) => false
  rule  call(userRoleCanPropose(Proposer)) => true
  rule  call(userRoleCanPropose(BoardMember)) => true

  rule  call(userRoleCanSign(None)) => false
  rule  call(userRoleCanSign(Proposer)) => false
  rule  call(userRoleCanSign(BoardMember)) => true

  rule  call(userRoleCanPerformAction(R:UserRole) => userRoleCanPropose(R))

  rule  call(userRoleCanDiscardAction(R:UserRole) => userRoleCanPropose(R))

  rule  call(isEmptyList([.])) => true
  rule  call(isEmptyList(_:ExpressionList)) => false [owise]

  rule  call(listLen([.])) => u(0)
  rule  call(listLen([_:Expression , Es:ExpressionCSV]))
        => call(listLen([Es])) ~> plusOne

  syntax KItem ::= "plusOne"
  rule  (I:Usize ~> plusOne) => add(I, u(1))

  rule  <k> call(setQuorum(Quorum:Usize)) => void ... </k>
        <quorum>_ => Quorum</quorum>

  rule  <k> call(setNumUsers(Users:Usize)) => void ... </k>
        <num-users>_ => Users</num-users>

  rule  <k> call(setNumBoardMembers(Members:Usize)) => void ... </k>
        <num-board-members>_ => Members</num-board-members>

  rule  <k> call(setNumProposers(Proposers:Usize)) => void ... </k>
        <num-proposers>_ => Proposers</num-proposers>

  rule  <k> (.K => nullableMapSet(E, I, M, rUsize)) ~> call(setUserId(E:Expression, I:Usize)) ...</k>
        <address-to-user-id> M:Map </address-to-user-id>
  rule  <k> (M:Map ~> call(setUserId(_:Expression, _:Usize))) => void ... </k>
        <address-to-user-id> _:Map => M </address-to-user-id>

  rule  <k> (.K => mapSet(I, E, M)) ~> call(setUserAddress(I:Usize, E:Expression)) ...</k>
        <user-id-to-address> M:Map </user-id-to-address>
  rule  <k> (M:Map ~> call(setUserAddress(_:Usize, _:Expression))) => void ... </k>
        <user-id-to-address> _:Map => M </user-id-to-address>

  rule  <k> (.K => nullableMapSet(I, R, M, rUserRole)) ~> call(setUserIdToRole(I:Usize, R:UserRole)) ... </k>
        <user-roles> M:Map </user-roles>
  rule  <k> (M:Map ~> call(setUserIdToRole(_:Usize, _:UserRole))) => void ... </k>
        <user-roles> _:Map => M </user-roles>

  rule  <k> call(getCaller()) => A ... </k>
        <caller-address> A:Address </caller-address>

  rule  <k> call(getQuorum()) => Quorum ... </k>
        <quorum> Quorum:Usize </quorum>

  rule  <k> call(getUserId(A:Expression))
            =>  cast(A, rAddress)
                ~> removeValue
                ~> nullableMapLookup(A, M, rUsize)
        ... </k>
        <address-to-user-id> M:Map </address-to-user-id>

  rule  <k> call(getUserIdToRole(I:Usize)) => nullableMapLookup(I, M, rUserRole) ... </k>
        <user-roles> M:Map </user-roles>

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

  rule  <k> (.K => nullableMapSet(ActionId, A, M, rAction)) ~> call(setActionData(ActionId:Usize, A:Action)) ... </k>
        <action-data> M:Map </action-data>
  rule  <k> (M:Map ~> call(setActionData(_:Usize, _:Action))) => void ... </k>
        <action-data> _:Map => M </action-data>

  rule  <k> call(getActionData(ActionId:Usize)) => nullableMapLookup(ActionId, M, rAction) ... </k>
        <action-data> M:Map </action-data>

  rule  <k> (.K => nullableMapSet(ActionId, Signers, M, rExpressionList))
            ~> call(setActionSignerIDs(ActionId:Usize, Signers:ExpressionList))
        ...</k>
        <action-signers> M:Map </action-signers>

  rule  <k> (M:Map ~> call(setActionSignerIDs(_:Usize, _:ExpressionList))) => void ... </k>
        <action-signers> _:Map => M </action-signers>

  rule  <k> (.K => call(getActionData(ActionId))) ~> call(isEmptyActionData(ActionId:Usize)) ... </k>
  rule  Action:Action ~> call(isEmptyActionData(_:Usize)) => Action ==K Nothing

  rule  call(canSign(BoardMember)) => true
  rule  call(canSign(_)) => false  [owise]

  rule  <k> call(getActionSignerIds(ActionId:Usize))
            => nullableMapLookup(ActionId, M:Map, rExpressionList)
        ... </k>
        <action-signers> M:Map </action-signers>

  rule call(listContains(Es:ExpressionList, E:Expression)) => #listContains(Es, E)

  syntax Bool ::= #listContains(ExpressionList, Expression)  [function, functional]

  rule  #listContains([.], _) => false
  rule  #listContains([E:Expression, _:ExpressionCSV], E) => true
  rule  #listContains([_:Expression, Es:ExpressionCSV], X:Expression)
          => #listContains([Es], X)  [owise]

  rule call(listFind(Es:ExpressionList, E:Expression)) => #listFind(Es, E)

  syntax Usize ::= #listFind(ExpressionList, Expression)  [function, functional]

  rule  #listFind([.], _) => u(-1)
  rule  #listFind([X:Usize, _:ExpressionCSV], X) => u(0)
  rule  #listFind([_:Usize, Es:ExpressionCSV], X:Usize) => add(#listFind([Es], X), u(1))  [owise]

  syntax ExpressionCSV ::= #listSwapRemove(ExpressionCSV, Int)  [function, functional]
  rule  #listSwapRemove(_:Expression , Es:ExpressionCSV, 0)
        => lastToStart(., Es)
  rule  #listSwapRemove(E:Expression , Es:ExpressionCSV, I:Int)
        => E , #listSwapRemove(Es, I -Int 1)
    requires I >Int 0
  rule  #listSwapRemove(Es:ExpressionCSV, I:Int)
        => Es
    requires I <Int 0

  syntax ExpressionCSV ::= lastToStart(ExpressionCSV, ExpressionCSV)  [function, functional]
  rule lastToStart(., .) => .:ExpressionCSV
  rule lastToStart(L1:ExpressionCSV, (E:Expression, .))
        => E , reverseExpressionCsv(L1, .)
  rule lastToStart(L1:ExpressionCSV, (E:Expression , L2:ExpressionCSV))
        => lastToStart((E , L1), L2)

  syntax ExpressionCSV ::= reverseExpressionCsv(ExpressionCSV, ExpressionCSV)  [function, functional]
  rule reverseExpressionCsv(., L2:ExpressionCSV) => L2
  rule reverseExpressionCsv((E:Expression , Es:ExpressionCSV), L2:ExpressionCSV) => reverseExpressionCsv(Es, (E , L2))

  rule call(performActionFromId(ActionId:Usize))
        => runPseudoCode(
              action = getActionData(ActionId);
              performAction(action);
        )

  rule call(clearAction(ActionId:Usize))
        => runPseudoCode(
              setActionData(ActionId, Nothing);
              setActionSignerIDs(ActionId, [.]);
        )

  rule call(pushList([Es:ExpressionCSV], E:Expression))
        => [#pushList(Es, E)]

  syntax ExpressionCSV ::= #pushList(ExpressionCSV, Expression)  [function, functional]

  rule #pushList(., E:Expression)
        => E, .
  rule #pushList(E:Expression , Es:ExpressionCSV, E2:Expression)
        => prepend(#pushList(Es, E2), E)

  syntax ExpressionCSV ::= prepend(ExpressionCSV, Expression)  [function, functional]
  rule prepend(Es:ExpressionCSV, E:Expression) => E , Es

  rule call(sendTx(_To:Address, _Amount:BigUint, _Data:BoxedBytes))
        => evaluate(void)

  rule call(getGasLeft()) => evaluate(u(-1))

  rule call(deployContract(
            _GasLeft:Usize,
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

module MAYBE
  syntax Maybe ::= just(KItem) | "nothing"
  syntax KItem ::= Maybe

  syntax KItem ::= value(KItem)
  rule isKResult(value(K:KItem) => K)

  syntax KResult ::= Maybe

  syntax KItem ::= orElse(KItem, KItem)  [strict(1)]
  rule orElse(nothing, K:KItem) => value(K)
  rule orElse(just(K:KItem), _:KItem) => value(K)
endmodule

module MAP-UTILS
  imports BOOL
  imports K-EQUAL
  imports MAP
  imports MAYBE

  // TODO: Not a real function, but the Haskell backend does not
  // allow us to use the function with the same name in the comments below.
  syntax KItem ::= splitMap(key:KItem, Map)  [function, functional]
  syntax KItem ::= #splitMap(key:KItem, Map) | "endSplitMap"

  rule  splitMap(K:KItem, (K |-> _:KItem _:Map) #as _:Map)
        => endSplitMap
    [simplification]
  rule  splitMap(K:KItem, (K1 |-> _ M:Map) #as _:Map)
        => splitMap(K, M)
    requires notBool (K ==K K1)
    [simplification]
  rule  splitMap(K:KItem, M:Map) => #splitMap(K, M)

  rule  #splitMap(K:KItem, (K |-> _:KItem _:Map) #as M:Map) => .K
    ensures K in_keys(M)
  rule  #splitMap(K:KItem, M:Map) => .K
    ensures notBool (K in_keys(M))
    [owise]

  rule endSplitMap => .K

  /*
  syntax Map ::= splitMap(key:KItem, Map, Map)  [function, functional]

  rule  splitMap(K:KItem, (K |-> _:KItem _:Map) #as _:Map, M:Map)
        => M
    [simplification]
  rule  splitMap(K:KItem, (K1 |-> _ M:Map) #as _:Map, N:Map)
        => splitMap(K, M, N)
    requires notBool (K ==K K1)
    [simplification]
  rule  splitMap(K:KItem, M:Map, N:Map)
        =>
            (
              (#Ceil(M #And (K |-> ?_:KItem ?_:Map)))
              #And
              {true #Equals (K in_keys(M))}
              #And N
            )
            #Or (N #And {true #Equals (notBool (K in_keys(M)))})

  rule  splitMap(K:KItem, M:Map, N:Map)
        =>(
            (
              (#Ceil(M #And (K |-> ?_:KItem ?_:Map)))
              #And
              {true #Equals (K in_keys(M))}
            )
            #Or
            ({true #Equals (notBool (K in_keys(M)))})
          )
          #And N


  rule  splitMap(K:KItem, M:Map, N:Map) => N
        ensures
          (
            (
              (#Ceil(M #And (K |-> ?_:KItem ?_:Map)))
              #And
              {true #Equals (K in_keys(M))}
            )
            #Or
            ({true #Equals (notBool (K in_keys(M)))})
          )



  */

  // Do the map lookups in a way that makes the Haskell backend happy.

  syntax KItem ::= mapLookup(KItem, Map)
  rule mapLookup(K:KItem, M:Map) => splitMap(K, M) ~> #mapLookup(K, M)
  /*rule mapLookup(K:KItem, M:Map) => #mapLookup(K, splitMap(K, M, M))*/

  syntax KItem ::= #mapLookup(KItem, Map)
  rule #mapLookup(K:KItem, ((K |-> V:KItem) _:Map) #as M:Map) => just(V)
    ensures K in_keys(M)
  rule #mapLookup(K:KItem, M:Map) => nothing
    ensures notBool (K in_keys(M))
    [owise]

  syntax KItem ::= mapDelete(key:KItem, Map)
  rule mapDelete(K:KItem, M:Map) => #mapDelete(K, M)
    requires K in_keys(M)
  rule mapDelete(K:KItem, M:Map) => M
    requires notBool (K in_keys(M))

  syntax KItem ::= #mapDelete(key:KItem, Map)
  rule #mapDelete(K:KItem, (K |-> _:KItem) M:Map) => M
  rule #mapDelete(_:KItem, M:Map) => M
    ensures false
    [owise]

  syntax KItem ::= mapSet(key:KItem, value:KItem, Map)
  rule mapSet(K:KItem, V:KItem, M:Map) => #mapSet(K, V, M)
    requires K in_keys(M)
  rule mapSet(K:KItem, V:KItem, M:Map) => K |-> V M
    requires notBool (K in_keys(M))

  syntax KItem ::= #mapSet(key:KItem, value:KItem, Map)
  rule #mapSet(K:KItem, V:KItem, (K |-> _:KItem) M:Map) => K |-> V M
  rule #mapSet(_:KItem, _:KItem, M:Map) => M
    ensures false
    [owise]

  /*
  rule X:KItem in_keys((X |-> _:KItem _:Map) #as _:Map) => true
    [simplification]
  rule X:KItem in_keys((Y:KItem |-> _:KItem M:Map) #as _:Map)
        => X in_keys(M)
    requires notBool (X ==K Y)
    [simplification]
  */
  rule X:KItem in_keys((Y:KItem |-> _:KItem M:Map) #as _:Map)
        => X ==K Y orBool X in_keys(M)
    [simplification]
endmodule

module PSEUDOCODE-MAP-UTILS
  imports MAP-UTILS
  imports PSEUDOCODE-TYPE-REFLECTION

  syntax KItem ::= nullableMapLookup(key:KItem, Map, ReflectionType)

  rule nullableMapLookup(K:KItem, M:Map, T:ReflectionType)
        => cast(orElse(mapLookup(K, M), defaultValue(T)), T)

  syntax KItem ::= nullableMapSet(key:KItem, value:KItem, Map, ReflectionType)
  rule nullableMapSet(Key:KItem, Value:KItem, M:Map, T:ReflectionType)
        => mapDelete(Key, M)
    requires Value ==K defaultValue(T)
  rule nullableMapSet(Key:KItem, Value:KItem, M:Map, T:ReflectionType)
        => mapSet(Key, Value, M)
    requires notBool (Value ==K defaultValue(T))

endmodule

module PSEUDOCODE-CONFIGURATION
  imports MAP

  imports PSEUDOCODE-SYNTAX

  syntax KItem ::= "uninitialized"

  configuration
    <T>
      <TT>
        <k color="green"> runExternalCalls($PGM:ExternalCommands) </k>

        <state>
          <multisig-state>
            <users>
              <num-users>u(0)</num-users>
              <user-id-to-address>.Map</user-id-to-address>
              <address-to-user-id>.Map</address-to-user-id>
            </users>
            <board-state>
              <num-board-members>u(0)</num-board-members>
              <num-proposers>u(0)</num-proposers>
              <user-roles>.Map</user-roles>
              <quorum>u(0)</quorum>
            </board-state>
            <action-state>
              <action-last-index>u(0)</action-last-index>
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

          <proof-state>
            <last-instrumented> .K </last-instrumented>
          </proof-state>
        </state>
    </TT>
  </T>

  syntax StateCell ::= "initialState"   [function]
  rule initialState =>
      <state>
        <multisig-state>
          <users>
            <num-users>u(0)</num-users>
            <user-id-to-address>.Map</user-id-to-address>
            <address-to-user-id>.Map</address-to-user-id>
          </users>
          <board-state>
            <num-board-members>u(0)</num-board-members>
            <num-proposers>u(0)</num-proposers>
            <user-roles>.Map</user-roles>
            <quorum>u(0)</quorum>
          </board-state>
          <action-state>
            <action-last-index>u(0)</action-last-index>
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
        <proof-state>
          <last-instrumented> .K </last-instrumented>
        </proof-state>
      </state>
endmodule