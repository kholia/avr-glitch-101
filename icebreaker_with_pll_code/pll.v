/**
 * PLL configuration
 *
 * This Verilog module was generated automatically
 * using the icepll tool from the IceStorm project.
 * Use at your own risk.
 *
 * Given input frequency:        12.000 MHz
 * Requested output frequency:   50.000 MHz
 * Achieved output frequency:    50.250 MHz
 */

// https://z80.ro/post/using_pll/

module pll #(
	parameter DIVR    =  0,
	parameter DIVF    = 66,
	parameter DIVQ    =  4,
	parameter FLT_RNG =  1 ) (

	input  clock_in,
	output clock_out,
	output locked
);

SB_PLL40_PAD #(
	.FEEDBACK_PATH("SIMPLE"),
	.DIVR(DIVR),        // DIVR =  0
	.DIVF(DIVF),        // DIVF = 66
	.DIVQ(DIVQ),        // DIVQ =  4
	.FILTER_RANGE(FLT_RNG) // FILTER_RANGE = 1
) uut (
	.LOCK(locked),
	.RESETB(1'b1),
	.BYPASS(1'b0),
	.PACKAGEPIN(clock_in),
	.PLLOUTCORE(clock_out)
);

endmodule
