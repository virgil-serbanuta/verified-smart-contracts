TESTS = $(wildcard tests/*.golden)
TEST_COMPARISON = ${TESTS:.golden=.cmp}

CHECK_RESULT_RUN = if [ $$? -eq 0 ] ; then echo "passed $<"; mv $@.tmp $@; else echo "failed $<"; cat $@.tmp; exit 1; fi

.PRECIOUS: tests/*.out

execution.timestamp: execution.k *.k
	@kompile $< --backend haskell
	@touch execution.timestamp

test: ${TEST_COMPARISON}

tests/%.cmp: tests/%.out tests/%.golden
	@echo -n "Comparing $^... "
	@diff --strip-trailing-cr $^ > $@.tmp 2>&1; ${CHECK_RESULT_RUN}

tests/%.out: tests/%.msig execution.timestamp
	@echo "Running $<"
	@krun $< > $@ 2>&1

clean:
	-rm *.timestamp tests/*.out tests/*.cmp
	-rm -r execution-kompiled
	-rm -r .krun*