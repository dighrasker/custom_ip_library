# ---- Tools ----
VCS = vcs -sverilog -full64 -debug_access+all -line
GREP = grep -E

# ---- Files ----
RTL = ip/arbiter/rtl/arbiter.sv
TB  = ip/arbiter/test/arbiter_test.sv

# ---- Default target ----
.DEFAULT_GOAL := arbiter.pass

# ---- Build simulation executable ----
build/arbiter.simv: $(RTL) $(TB) | build
	$(VCS) $^ -o $@

# ---- Run simulation ----
build/arbiter.out: build/arbiter.simv
	cd build && ./arbiter.simv | tee arbiter.out

# ---- Pass / Fail check ----
arbiter.pass: build/arbiter.out
	@$(GREP) "@@@ Passed" build/arbiter.out || \
	 (echo "@@@ Failed" && exit 1)

# ---- Directories ----
build:
	mkdir -p build

# ---- Cleanup ----
clean:
	rm -rf build simv* csrc *.daidir *.key *.vpd

.PHONY: clean arbiter.pass
