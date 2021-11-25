PROJ = blink

PIN_DEF = icebreaker.pcf
DEVICE = up5k
PACKAGE = sg48

all: $(PROJ).rpt $(PROJ).bin

pll_support:
	icepll -i 12 -o 50
	icepll -i 12 -o 50 -mf pll.v

%.json: %.v pll.v $(ADD_SRC) $(ADD_DEPS)
	yosys -ql $*.log -p 'synth_ice40 -top top -json $@' $< $(ADD_SRC) pll.v

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
	iceprog $<

sudo-prog: $(PROJ).bin
	@echo 'Executing prog as root!!!'
	sudo iceprog $<

clean:
	rm -f $(PROJ).blif $(PROJ).asc $(PROJ).rpt $(PROJ).bin

.SECONDARY:
.PHONY: all prog clean
