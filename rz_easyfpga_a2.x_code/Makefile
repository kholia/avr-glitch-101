dummy:
	# export PATH=~/intelFPGA_lite/20.1/quartus/bin:$PATH
	quartus_sh -t blink.tcl
	quartus_map blink
	quartus_fit blink
	quartus_asm blink
	quartus_sta blink
	quartus_pgm --mode=jtag -o "p;blink.sof"
