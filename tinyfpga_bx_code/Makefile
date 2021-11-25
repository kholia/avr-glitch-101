PROJ = blink

PIN_DEF = pins.pcf
DEVICE = lp8k
# https://apiodoc.readthedocs.io/en/stable/source/user_guide/util_commands/cmd_boards.html
PACKAGE = cm81

all: $(PROJ).rpt $(PROJ).bin

deps:
	pip3 install tinyprog
	# tinyprog --update-bootloader

pll_support:
	icepll -i 12 -o 50
	icepll -i 12 -o 50 -mf pll.v

%.json: %.v $(ADD_SRC) $(ADD_DEPS)
	yosys -ql $*.log -p 'synth_ice40 -top top -json $@' $< $(ADD_SRC)

%.asc: $(PIN_DEF) %.json
	nextpnr-ice40 --$(DEVICE) \
        $(if $(PACKAGE),--package $(PACKAGE)) \
        --json $(filter-out $<,$^) \
        --pcf $< \
        --asc $@ \
        $(if $(PNR_SEED),--seed $(PNR_SEED))

%.bin: %.asc
	icepack $< $@

%.rpt: %.asc
	icetime -d $(DEVICE) -mtr $@ $<

prog: $(PROJ).bin
	tinyprog -p $<

clean:
	rm -f $(PROJ).blif $(PROJ).asc $(PROJ).rpt $(PROJ).bin

.SECONDARY:
.PHONY: all prog clean
