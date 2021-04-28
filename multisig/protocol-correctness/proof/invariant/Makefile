include ../settings.mak

.PHONY: default
default: all ;

SCRIPT_DIR = ..

PROOF_DIR = ..
include $(PROOF_DIR)/proof-dependency.mak

FUNCTIONS_DIR = ../functions
include $(FUNCTIONS_DIR)/functions-dependency.mak

INVARIANT_DIR = .
include $(INVARIANT_DIR)/invariant.mak

INVARIANT_PERFORM = $(wildcard $(INVARIANT_DIR)/proof-perform-*.k)
FINVARIANT_PERFORM = $(filter-out $(INVARIANT_DIR)/proof-perform-action-endpoint.k, $(INVARIANT_PERFORM))
INVARIANT_PERFORM_TIMESTAMPS = $(addprefix $(INVARIANT_OUT_PREFIX),$(notdir ${FINVARIANT_PERFORM:.k=.timestamp}))

INVARIANT_PROPOSE = $(wildcard $(INVARIANT_DIR)/proof-propose-*.k)
INVARIANT_PROPOSE_TIMESTAMPS = $(addprefix $(INVARIANT_OUT_PREFIX),$(notdir ${INVARIANT_PROPOSE:.k=.timestamp}))

.PHONY: all clean execution short perform

all: $(INVARIANT_OUT_PREFIX)proof.timestamp

execution: $(INVARIANT_OUT_PREFIX)execution.timestamp

short: $(INVARIANT_OUT_PREFIX)short-proofs.timestamp

perform: $(INVARIANT_OUT_PREFIX)proofperform.timestamp

propose: $(INVARIANT_OUT_PREFIX)proofpropose.timestamp

$(INVARIANT_OUT_PREFIX)proofperform.timestamp: ${INVARIANT_PERFORM_TIMESTAMPS} $(INVARIANT_OUT_PREFIX)execution.timestamp
	$(DIR_GUARD)
	@touch $(INVARIANT_OUT_PREFIX)proofperform.timestamp

$(INVARIANT_OUT_PREFIX)proofpropose.timestamp: ${INVARIANT_PROPOSE_TIMESTAMPS} $(INVARIANT_OUT_PREFIX)execution.timestamp
	$(DIR_GUARD)
	@touch $(INVARIANT_OUT_PREFIX)proofpropose.timestamp

clean: invariant.clean
