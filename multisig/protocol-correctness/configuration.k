module CONFIGURATION-SYNTAX
  imports BYTES
  imports INT
  imports LIST

  syntax Usize ::= Int  // TODO: int32
  syntax BigUint ::= Int  // Assumes no operations on this.
  syntax CodeMetadata ::= Int  // Assumes no operations on this.
  syntax UserRole ::= "None" | "Proposer" | "BoardMember"
  syntax BoxedBytes ::= Bytes
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
                        arguments: List)  // list of BoxedBytes
                |   SCCall(
                        to: Address,
                        amount: BigUint,
                        function: BoxedBytes,
                        arguments: List)  // list of BoxedBytes
endmodule

module CONFIGURATION
  imports INT
  imports LIST
  imports MAP

  imports CONFIGURATION-SYNTAX

  // type_abi_name_only!(Usize, "u32");

  syntax Users ::= users(numUsers:Usize, userIdToAddress:Map, addressToUserId:Map)

  syntax UserRoles ::= userRoles(Map)  // userId:Int -> UserRole
  syntax BoardState ::= boardState(
                            numBoardMembers:Usize,
                            quorum:Usize,
                            numProposers:Usize,
                            userRoles:UserRoles)

  syntax Signers ::= votes(List)  // list of userId:Int
  syntax ActionInfo ::= actionInfo(Action, Signers)
  syntax Actions ::= actions(Map)  // actionId:Int -> ActionInfo
  syntax ActionState ::= actionState(actionLastIndex:Usize, Actions)

  syntax MultisigState ::= "NoState" | multisigState(Users, BoardState, ActionState)

  syntax Command  ::= init(quorum:Usize, board:List)  // list of Address
                  |   deposit()
                  |   proposeAddBoardMember(boardMemberAddress:Address)
                  |   proposeAddProposer(proposerAddress:Address)
                  |   proposeRemoveUser(userAddress:Address)
                  |   proposeChangeQuorum(newQuorum:Usize)
                  |   proposeSendEgld(to:Address, amount:BigUint, optData:List)  // list of BoxedBytes
                  |   proposeSCDeploy(amount:BigUint, code:BoxedBytes, upgradeable:Bool, payable:Bool, readable:Bool)
                  |   proposeSCCall(to:Address, amount:BigUint, function:BoxedBytes, arguments:List)  // list of BoxedBytes
                  |   sign(actionId:Usize)
                  |   unsign(actionId:Usize)
                  |   performAction(actionId:Usize)
                  |   discardAction(actionId:Usize)

  syntax Subcommand

  syntax KItem  ::= start(Command)
                |   run(Command)
                |   run(Subcommand)
                |   "error"

  rule start(Command) => run(Command)
  rule error => .K

  configuration
    <T>
      <k>.K</k>
      <state> NoState </state>
    </T>

endmodule
