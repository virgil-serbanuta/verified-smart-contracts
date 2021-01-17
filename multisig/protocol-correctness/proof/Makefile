SHELL=/bin/bash -euo pipefail

ALL_K = $(wildcard *.k) $(wildcard ../*.k)
PROOFS = $(wildcard proof-*.k)
PROOFS_PERFORM = $(wildcard proof-perform-*.k)
FPROOFS_PERFORM = $(filter-out proof-perform-action-endpoint.k, $(PROOFS_PERFORM))
EXECUTION_K = $(filter-out $(PROOFS), $(ALL_K))
PROOF_TIMESTAMPS = ${PROOFS:.k=.timestamp}
PROOF_PERFORM_TIMESTAMPS = ${FPROOFS_PERFORM:.k=.timestamp}
PROOF_DEBUGGERS = ${PROOFS:.k=.debugger}
PROOFS0 = $(filter-out proof-init-loop.k, $(PROOFS))
PROOF0_TIMESTAMPS = ${PROOFS0:.k=.timestamp}

BACKEND_COMMAND = "--haskell-backend-command /home/virgil/runtime-verification/kore/.build/kore/bin/kore-exec"

.PHONY: clean ${PROOF_DEBUGGERS}

proof.timestamp: ${PROOF_TIMESTAMPS} execution.timestamp
	@touch proof.timestamp

proof0.timestamp: ${PROOF0_TIMESTAMPS} execution.timestamp
	@touch proof0.timestamp

proofperform.timestamp: ${PROOF_PERFORM_TIMESTAMPS} execution.timestamp
	@touch proofperform.timestamp

proof-%.timestamp: proof-%.k execution.timestamp
	@echo "Proving $*..."
	@((kprove proof-$*.k $(BACKEND_COMMAND) > proof-$*.out 2>&1) && echo "$* done") || (cat proof-$*.out; echo "$* failed"; echo "$*" >> failures; false)
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
	-rm -r kore-*.tar.gz
	-rm proof-*.out
	-rm failures
