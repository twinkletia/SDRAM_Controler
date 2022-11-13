################################################################################
# Makefile : sof file generation using Quartus II
# Usage:
#		make compile for synthesis all files
#       make download for download .sof file to FPGA board
################################################################################
# 2011-09-12,13 Initial version by Y.Okuyama (based on PICO's makefile)
# 2012-10-08    CABLE is modified for linux environment
# 2013-07-09    Modified for DE0/windows environment
################################################################################

ifndef SRCDIR
SRCDIR	= .
endif

VPATH		= $(SRCDIR)
WORKDIR		= synth
DESIGN		= SDRAM
BOARD		= DE0_CV
NSL2VL    	= nsl2vl
NSLFLAGS  	= -O2 -neg_res -I$(SRCDIR)
MKPROJ		= $(SRCDIR)/mkproj-$(BOARD).tcl
Q2SH		= quartus_sh
Q2PGM		= quartus_pgm
CABLE		= "USB-Blaster [USB-0]"
PMODE		= JTAG
SIMTOP=tb
TESTBENCH=testBench
SIMSRCS 		= $(wildcard simulation/*.nsl) $(wildcard $(SRCDIR)/[^DE0_CV]*.nsl)
SIMVFILES 		= $(addprefix out/, $(patsubst %.nsl,%.v,$(notdir $(SIMSRCS))))


SRCS		:= $(wildcard $(SRCDIR)/*.nsl)
VFILES 		= $(SRCS:$(SRCDIR)/%.nsl=%.v)	#patsubst syntax sugar
LIBS		= 
RESULT		= result.txt

########

all:
	@if [ ! -d $(WORKDIR) ]; then \
		echo mkdir $(WORKDIR); \
		mkdir $(WORKDIR); \
	fi
	( cd $(WORKDIR); make -f ../Makefile SRCDIR=.. compile )

########

.SUFFIXES: .v .nsl
.PHONY: test test2

%.v: %.nsl
	$(NSL2VL) $(NSLFLAGS)  $< -o $@

test3:
	@echo $(SIMSRCS)

out/%.v: $(SIMSRCS)
	if [ ! -d out ]; then \
		mkdir out; \
	fi
	$(NSL2VL) $(NSLFLAGS) -Isimulation $(filter $(shell echo $^ | grep "[^ ]*$*.nsl" -o), $^) -o $@

sim: $(SIMVFILES)
	sed -i -e "s/#include \"V.*\.h\"/#include \"V$(SIMTOP)\.h\"/g" $(TESTBENCH).cpp
	sed -i -e"s/V.*\\\*top;/V$(SIMTOP) *top;/g" $(TESTBENCH).cpp
	sed -i -e"s/top = new V.*;/top = new V$(SIMTOP);/g" $(TESTBENCH).cpp
	cp $(SRCDIR)/simulation/sdr.v out/
	cp $(SRCDIR)/simulation/SDRAM_CTR_TB.v out/
	verilator -Wno-STMTDLY -Wno-TIMESCALEMOD -Wno-REALCVT -Wno-INFINITELOOP -Wno-IMPLICIT -Wno-WIDTH -cc --trace --trace-underscore out/*.v -Isimulation --top-module $(SIMTOP) -exe $(TESTBENCH).cpp -O3
	make -C $(SRCDIR)/obj_dir/ -f V$(SIMTOP).mk
	$(SRCDIR)/obj_dir/V$(SIMTOP)

test: $(VFILES)
	mv $(VFILES) $(WORKDIR)/

test2:
	@echo $(VFILES)

$(DESIGN).qsf: $(VFILES) $(LIBS)
	$(SRCDIR)/PLLgen.sh
	cp $(SRCDIR)/pll/pll.v ./
	$(Q2SH) -t $(MKPROJ) -project $(DESIGN) $^

$(DESIGN).sof: $(DESIGN).qsf $(MIFS)
	$(Q2SH) --flow compile $(DESIGN)

########

compile: $(DESIGN).qsf
#	@echo "**** $(DESIGN).fit.summary" | tee -a $(RESULT)
#	@cat $(DESIGN).fit.summary | tee -a $(RESULT)
#	@echo "**** $(DESIGN).tan.rpt" | tee -a $(RESULT)
#	@grep "Info: Fmax" $(DESIGN).tan.rpt | tee -a $(RESULT)

download: config-n

config: all
	$(Q2PGM) -c $(CABLE) -m $(PMODE) -o "p;$(WORKDIR)/$(DESIGN).sof"
config-n: # without re-compile
	$(Q2PGM) -c $(CABLE) -m $(PMODE) -o "p;$(WORKDIR)/$(DESIGN).sof"

clean:
	rm -rf - $(WORKDIR) obj_dir out

########

#$(DESIGN).v	: $(DESIGN).nsl
