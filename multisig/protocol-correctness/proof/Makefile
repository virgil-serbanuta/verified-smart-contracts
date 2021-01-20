ALL_K = $(wildcard *.k) $(wildcard ../*.k)
PROOFS = $(wildcard proof-*.k)
EXECUTION_K = $(filter-out $(PROOFS), $(ALL_K))
PROOF_TIMESTAMPS = ${PROOFS:.k=.timestamp}
PROOF_DEBUGGERS = ${PROOFS:.k=.debugger}

.PHONY: clean ${PROOF_DEBUGGERS}

proof.timestamp: ${PROOF_TIMESTAMPS} execution.timestamp
	@touch proof.timestamp

proof-%.timestamp: proof-%.k execution.timestamp
	@echo "Proving $*..."
	@kprove proof-$*.k
	@touch proof-$*.timestamp

proof-%.debugger: proof-%.k execution.timestamp
	@echo "Debugging $*..."
	@kprove proof-$*.k --debugger --debug-script /home/virgil/runtime-verification/k/haskell-backend/src/main/native/haskell-backend/kore/data/kast.kscript

execution.timestamp: execution.k ${EXECUTION_K}
	@echo "Compiling execution..."
	@kompile $< --backend haskell
	@touch execution.timestamp

clean:
	-rm *.timestamp
	-rm -r *-kompiled
	-rm -r .kprove-*
	-rm -r kore-repl.tar.gz
