// look in pins.pcf for all the pin names on the TinyFPGA BX board
`define GLITCH_DURATION 25


module top (
	input CLK,    // 16MHz clock
	output USBPU, // USB pull-up resistor
	output PIN_1
);

// drive USB pull-up resistor to '0' to disable USB
assign USBPU = 0;
assign PIN_1 = outreg;

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
