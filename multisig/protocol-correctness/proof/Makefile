ALL_K = $(wildcard *.k) $(wildcard ../*.k)
EXECUTION_K = $(filter-out proof.k, $(ALL_K))

proof.timestamp: proof.k proof-execution.timestamp
	@kprove proof.k
	@touch proof.timestamp

proof-execution.timestamp: proof-execution.k ${EXECUTION_K}
	@kompile $< --backend haskell
	@touch proof-execution.timestamp

clean:
	-rm *.timestamp
	-rm -r *-kompiled
	-rm -r .kprove-*
