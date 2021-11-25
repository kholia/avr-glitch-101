`default_nettype none
`define GLITCH_DURATION 95

// https://github.com/z80-ro/verilog-tests/tree/master/02_pll

module top (
	input CLK,
	output LEDR_N,
	output LEDG_N,
	output P1B1
);

assign LEDR_N = outreg;
assign LEDG_N = ~outreg;
assign P1B1 = outreg;

reg outreg;
reg [31:0] counter;
wire PLL_CLK;       // new clock signal driven by pll instance
wire PLL_LOCK;      // indicates is PLL_CLK is locked to the pll source

//-----------------------------------------------------
// pll module instantiation
//-----------------------------------------------------
pll pll_instance (
	.clock_in  (     CLK),
	.clock_out ( PLL_CLK),
	.locked    (PLL_LOCK)
);

//-----------------------------------------------------
// Main always block
//-----------------------------------------------------
initial begin
	counter <= 0;
	outreg <= 0;
end

always @(posedge PLL_CLK) begin
	if (counter == 20000000 && outreg) begin
		counter <= 0;
		outreg <= 0;
	end
	else if (counter == `GLITCH_DURATION && !outreg) begin
		counter <= 0;
		outreg <= 1;
	end
	else begin
		counter <= counter +1;
	end
end

endmodule
