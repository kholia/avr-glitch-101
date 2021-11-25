`define GLITCH_DURATION 25

module top (
	input  CLK,
	output LEDR_N,
	output LEDG_N,
	output P1B1
);

assign LEDR_N = outreg;
assign LEDG_N = ~outreg;
assign P1B1 = outreg;

reg outreg;
reg [31:0] counter;

initial begin
	counter <= 0;
	outreg <= 0;
end

always @(posedge CLK) begin
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
