require "elrond-semantics/mandos.md"

module WITH-CONTRACT
  imports MANDOS

  syntax ModuleDecl ::= "multisig-contract"
  rule multisig-contract
      => aModuleDecl
              ( aTypeDefn
                    ( aFuncType
                      ( aVecType(listValTypes(i32, listValTypes(i32, listValTypes(i32, .ValTypes))))
                      , aVecType(listValTypes(i32, .ValTypes))
                      )
                    , 
                    )
                  aTypeDefn
                    ( aFuncType
                      ( aVecType(listValTypes(i32, listValTypes(i32, .ValTypes)))
                      , aVecType(listValTypes(i32, .ValTypes))
                      )
                    , 
                    )
                  aTypeDefn
                    ( aFuncType
                      ( aVecType
                        ( listValTypes(i32, listValTypes(i32, listValTypes(i32, listValTypes(i32, .ValTypes))))
                        )
                      , aVecType(.ValTypes)
                      )
                    , 
                    )
                  aTypeDefn
                    ( aFuncType
                      ( aVecType(listValTypes(i32, .ValTypes))
                      , aVecType(listValTypes(i32, .ValTypes))
                      )
                    , 
                    )
                  aTypeDefn
                    ( aFuncType
                      ( aVecType(listValTypes(i32, listValTypes(i32, .ValTypes)))
                      , aVecType(.ValTypes)
                      )
                    , 
                    )
                  aTypeDefn(aFuncType(aVecType(listValTypes(i32, .ValTypes)), aVecType(.ValTypes)), )
                  aTypeDefn
                    ( aFuncType
                      ( aVecType
                        ( listValTypes(i32, listValTypes(i32, listValTypes(i32, listValTypes(i32, .ValTypes))))
                        )
                      , aVecType(listValTypes(i32, .ValTypes))
                      )
                    , 
                    )
                  aTypeDefn
                    ( aFuncType
                      ( aVecType(listValTypes(i32, listValTypes(i32, .ValTypes)))
                      , aVecType(listValTypes(i64, .ValTypes))
                      )
                    , 
                    )
                  aTypeDefn
                    ( aFuncType
                      ( aVecType(listValTypes(i64, .ValTypes))
                      , aVecType(listValTypes(i32, .ValTypes))
                      )
                    , 
                    )
                  aTypeDefn
                    ( aFuncType
                      ( aVecType(listValTypes(i32, listValTypes(i32, listValTypes(i32, .ValTypes))))
                      , aVecType(.ValTypes)
                      )
                    , 
                    )
                  aTypeDefn(aFuncType(aVecType(.ValTypes), aVecType(listValTypes(i32, .ValTypes))), )
                  aTypeDefn
                    ( aFuncType
                      ( aVecType(listValTypes(i32, listValTypes(i32, listValTypes(i64, .ValTypes))))
                      , aVecType(listValTypes(i32, .ValTypes))
                      )
                    , 
                    )
                  aTypeDefn(aFuncType(aVecType(listValTypes(i64, .ValTypes)), aVecType(.ValTypes)), )
                  aTypeDefn
                    ( aFuncType
                      ( aVecType(listValTypes(i32, .ValTypes))
                      , aVecType(listValTypes(i64, .ValTypes))
                      )
                    , 
                    )
                  aTypeDefn(aFuncType(aVecType(.ValTypes), aVecType(.ValTypes)), )
                  aTypeDefn(aFuncType(aVecType(.ValTypes), aVecType(listValTypes(i64, .ValTypes))), )
                  aTypeDefn
                    ( aFuncType
                      ( aVecType
                        ( listValTypes
                          ( i64
                          , listValTypes
                            ( i32
                            , listValTypes
                              ( i32
                              , listValTypes
                                ( i32
                                , listValTypes
                                  ( i32
                                  , listValTypes(i32, listValTypes(i32, listValTypes(i32, listValTypes(i32, .ValTypes))))
                                  )
                                )
                              )
                            )
                          )
                        )
                      , aVecType(listValTypes(i32, .ValTypes))
                      )
                    , 
                    )
                  aTypeDefn
                    ( aFuncType
                      ( aVecType
                        ( listValTypes
                          ( i32
                          , listValTypes(i32, listValTypes(i32, listValTypes(i32, listValTypes(i32, .ValTypes))))
                          )
                        )
                      , aVecType(listValTypes(i32, .ValTypes))
                      )
                    , 
                    )
                  .EmptyStmts
              , aFuncDefn
                    ( 6
                    , aVecType(listValTypes(i32, .ValTypes))
                    , aBlock
                          ( aVecType(.ValTypes)
                          , #local.get(3)
                              #local.get(2)
                              #call(26)
                              #local.tee(4)
                              aTestOp(i32, aEqz())
                              #br_if(0)
                              #local.get(4)
                              #local.get(0)
                              #local.get(3)
                              #local.get(1)
                              #local.get(1)
                              #local.get(3)
                              aIRelOp(i32, gt_u)
                              aSelect()
                              #call(219)
                              aDrop()
                              #local.get(0)
                              #local.get(1)
                              #local.get(2)
                              #call(27)
                              .EmptyStmts
                          , 0
                          )
                        #local.get(4)
                        .EmptyStmts
                    , funcMeta(, .Map)
                    )
                  .EmptyStmts
              , aTableDefn(limitsMinMax(20, 20), ) .EmptyStmts
              , aMemoryDefn(limitsMin(17), ) .EmptyStmts
              , aGlobalDefn(aGlobalType(mutVar(), i32), aIConst(i32, 1048576) .EmptyStmts, )
                  aGlobalDefn(aGlobalType(mutConst(), i32), aIConst(i32, 1050872) .EmptyStmts, )
                  aGlobalDefn(aGlobalType(mutConst(), i32), aIConst(i32, 1050872) .EmptyStmts, )
                  .EmptyStmts
              , aElemDefn
                    ( 0
                    , aIConst(i32, 1) .EmptyStmts
                    , listInt
                      ( 35
                      , listInt
                        ( 38
                        , listInt
                          ( 46
                          , listInt
                            ( 47
                            , listInt
                              ( 48
                              , listInt
                                ( 49
                                , listInt
                                  ( 50
                                  , listInt
                                    ( 51
                                    , listInt
                                      ( 61
                                      , listInt
                                        ( 52
                                        , listInt
                                          ( 105
                                          , listInt
                                            ( 211
                                            , listInt
                                              ( 212
                                              , listInt
                                                ( 213
                                                , listInt(214, listInt(217, listInt(207, listInt(215, listInt(216, .Ints)))))
                                                )
                                              )
                                            )
                                          )
                                        )
                                      )
                                    )
                                  )
                                )
                              )
                            )
                          )
                        )
                      )
                    )
                  .EmptyStmts
              , aDataDefn
                    ( 0
                    , aIConst(i32, 1048576) .EmptyStmts
                    , String2Bytes("capacity overflowcalled `Option::unwrap()` on a `None` value     {  {\\n\\x00\\x00\\x02\\x00\\x00\\x00\\x0c\\x00\\x00\\x00\\x04\\x00\\x00\\x00\\x03\\x00\\x00\\x00\\x04\\x00\\x00\\x00\\x05\\x00\\x00\\x00,\\n\\x00\\x00\\x02\\x00\\x00\\x00\\x04\\x00\\x00\\x00\\x04\\x00\\x00\\x00\\x06\\x00\\x00\\x00\\x07\\x00\\x00\\x00\\x08\\x00\\x00\\x00} }()LayoutErrorprivate\\x00\\t\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x01\\x00\\x00\\x00\\n\\x00\\x00\\x00.itembig uint as_bytes exceed target sliceallocation errorpanic occurredbad H256 lengthstorage decode error: _id_to_addressuseruser_roleinvalid valueinput too longinput too shortcalled `Result::unwrap()` on an `Err` value\\x00\\x00\\x00\\x0b\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x01\\x00\\x00\\x00\\n\\x00\\x00\\x00wrong number of arguments\\x00\\x00\\x00\\x04\\x00\\x00\\x00\\x00\\x00\\x00\\x00argument decode error (): array decode error: ESDTTransfer\\x00\\x00\\x01\\x00\\x00\\x00\\x00\\x00\\x00\\x00.lenindex out of range_address_to_id_countinput out of rangeaction_databoard cannot be empty on init, no-one would be able to proposequorum cannot exceed board sizeduplicate board membernum_board_membersquorumonly board members and proposers can proposeaction_signer_idsaction does not existonly board members can signonly board members can un-signnum_proposersonly board members and proposers can perform actionsquorum has not been reachedcannot remove all board members and proposersonly board members and proposers can discard actionscannot discard action with valid signaturesaction_idboardboard_member_addressproposer_addressuser_addressnew_quorumtoupgradeablepayablereadable\\x0c\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x01\\x00\\x00\\x00\\r\\x00\\x00\\x00\\x0e\\x00\\x00\\x00\\x0f\\x00\\x00\\x00\\x10\\x00\\x00\\x00\\x04\\x00\\x00\\x00\\x04\\x00\\x00\\x00\\x11\\x00\\x00\\x00\\x12\\x00\\x00\\x00\\x13\\x00\\x00\\x00")
                    )
                  aDataDefn
                    ( 0
                    , aIConst(i32, 1049812) .EmptyStmts
                    , String2Bytes("uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu")
                    )
                  .EmptyStmts
              , .EmptyStmts
              , aImportDefn("env", "signalError", aFuncDesc(, 4))
                  aImportDefn("env", "bigIntUnsignedByteLength", aFuncDesc(, 3))
                  aImportDefn("env", "bigIntGetUnsignedBytes", aFuncDesc(, 1))
                  aImportDefn("env", "asyncCall", aFuncDesc(, 2))
                  aImportDefn("env", "getOriginalTxHash", aFuncDesc(, 5))
                  aImportDefn("env", "storageStore", aFuncDesc(, 6))
                  aImportDefn("env", "storageLoadLength", aFuncDesc(, 1))
                  aImportDefn("env", "storageLoad", aFuncDesc(, 0))
                  aImportDefn("env", "smallIntStorageLoadUnsigned", aFuncDesc(, 7))
                  aImportDefn("env", "getArgumentLength", aFuncDesc(, 3))
                  aImportDefn("env", "getArgument", aFuncDesc(, 1))
                  aImportDefn("env", "bigIntNew", aFuncDesc(, 8))
                  aImportDefn("env", "bigIntSetUnsignedBytes", aFuncDesc(, 9))
                  aImportDefn("env", "getNumArguments", aFuncDesc(, 10))
                  aImportDefn("env", "smallIntStorageStoreUnsigned", aFuncDesc(, 11))
                  aImportDefn("env", "smallIntFinishUnsigned", aFuncDesc(, 12))
                  aImportDefn("env", "bigIntGetUnsignedArgument", aFuncDesc(, 4))
                  aImportDefn("env", "smallIntGetUnsignedArgument", aFuncDesc(, 13))
                  aImportDefn("env", "finish", aFuncDesc(, 4))
                  aImportDefn("env", "getCaller", aFuncDesc(, 5))
                  aImportDefn("env", "checkNoPayment", aFuncDesc(, 14))
                  aImportDefn("env", "smallIntFinishSigned", aFuncDesc(, 12))
                  aImportDefn("env", "getGasLeft", aFuncDesc(, 15))
                  aImportDefn("env", "createContract", aFuncDesc(, 16))
                  aImportDefn("env", "transferValue", aFuncDesc(, 6))
                  .EmptyStmts
              , aExportDefn("memory", 0)
                  aExportDefn("getQuorum", 172)
                  aExportDefn("getNumBoardMembers", 173)
                  aExportDefn("getNumProposers", 174)
                  aExportDefn("getActionLastIndex", 175)
                  aExportDefn("getActionData", 176)
                  aExportDefn("init", 178)
                  aExportDefn("deposit", 181)
                  aExportDefn("getPendingActionFullInfo", 182)
                  aExportDefn("proposeAddBoardMember", 183)
                  aExportDefn("proposeAddProposer", 187)
                  aExportDefn("proposeRemoveUser", 188)
                  aExportDefn("proposeChangeQuorum", 189)
                  aExportDefn("proposeSendEgld", 190)
                  aExportDefn("proposeSCDeploy", 191)
                  aExportDefn("proposeSCCall", 192)
                  aExportDefn("signed", 193)
                  aExportDefn("userRole", 194)
                  aExportDefn("getAllBoardMembers", 195)
                  aExportDefn("getAllProposers", 197)
                  aExportDefn("sign", 198)
                  aExportDefn("unsign", 199)
                  aExportDefn("getActionSigners", 200)
                  aExportDefn("getActionSignerCount", 201)
                  aExportDefn("getActionValidSignerCount", 202)
                  aExportDefn("quorumReached", 203)
                  aExportDefn("performAction", 204)
                  aExportDefn("discardAction", 205)
                  aExportDefn("callBack", 206)
                  aExportDefn("__data_end", 1)
                  aExportDefn("__heap_base", 2)
                  .EmptyStmts
              , moduleMeta(, .Map, "../../wasm/code/multisig_wasm.wasm")
              )

endmodule