module CONFIGURATION-SYNTAX
  imports INT

  syntax Usize ::= Int  // TODO: int32
  syntax UserRole ::= "None" | "Proposer" | "BoardMember"
endmodule

module CONFIGURATION
  imports BYTES
  imports INT
  imports LIST
  imports MAP

  imports CONFIGURATION-SYNTAX

  // type_abi_name_only!(Usize, "u32");

  syntax Users ::= users(numUsers:Usize, userIdToAddress:Map, addressToUserId:Map)
  syntax Address ::= address(Int)

  syntax UserRoles ::= userRoles(Map)  // userId:Int -> UserRole
  syntax BoardState ::= boardState(
                            numBoardMembers:Usize,
                            quorum:Usize,
                            numProposers:Usize,
                            userRoles:UserRoles)

  syntax BigUint ::= Int  // Assumes no operations on this.
  syntax BoxedBytes ::= Bytes
  syntax CodeMetadata ::= Int  // Assumes no operations on this.
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
      <state> NoState </state>
    </T>

endmodule
