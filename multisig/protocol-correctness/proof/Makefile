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

BACKEND_COMMAND = "kore-exec --smt-timeout 200"
# BACKEND_COMMAND = "/home/virgil/runtime-verification/kore/.build/kore/bin/kore-exec --smt-timeout 200"

.PHONY: clean ${PROOF_DEBUGGERS}

proof.timestamp: ${PROOF_TIMESTAMPS} execution.timestamp
	@touch proof.timestamp

short-proofs.timestamp: proof-init-loop.timestamp proof-count-can-sign.timestamp proof-init.timestamp proof-listlen.timestamp proof-perform-add-proposer-1.timestamp  proof-perform-add-proposer-2.timestamp  proof-perform-add-proposer-3.timestamp  proof-perform-change-quorum.timestamp proof-perform-nothing.timestamp proof-perform-remove-user-1.timestamp  proof-perform-remove-user-2.timestamp proof-perform-remove-user-5.timestamp proof-perform-s-c-call.timestamp proof-perform-s-c-deploy.timestamp proof-perform-send-egld.timestamp execution.timestamp
	@touch short-proof.timestamp

proof0.timestamp: ${PROOF0_TIMESTAMPS} execution.timestamp
	@touch proof0.timestamp

proofperform.timestamp: ${PROOF_PERFORM_TIMESTAMPS} execution.timestamp
	@touch proofperform.timestamp

proof-%.timestamp: proof-%.k execution.timestamp
	@echo "Proving $*..."
	@cat /proc/uptime | sed 's/\s.*//' > proof-$*.duration.temp
	@((kprove proof-$*.k --haskell-backend-command $(BACKEND_COMMAND) > proof-$*.out 2>&1) && echo "$* done") || (cat proof-$*.out; echo "$* failed"; echo "$*" >> failures; false)
	@cat /proc/uptime | sed 's/\s.*//' >> proof-$*.duration.temp
	@./compute-duration.py proof-$*.duration.temp > proof-$*.duration
	@rm proof-$*.duration.temp
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
	-rm *.duration
	-rm *.duration.temp
