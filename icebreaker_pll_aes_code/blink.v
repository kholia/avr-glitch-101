// https://github.com/rot256/aes-atmega328-glitching/tree/master/attacker
// https://rot256.dev/post/glitch/
parameter CLK_HZ = 25125000; // 25 MHz
parameter CONTROL_HZ = 8000000; // 8 MHz

parameter RESET = 2'b00;  // power off
parameter POWER = 2'b01;  // power on
parameter GLITCH = 2'b10; // do the glitch
parameter WAIT = 2'b11;   // wait for boot

parameter GLITCHES = 5000; // glitch 5000 times before reset

parameter WAIT_LEN = CLK_HZ;
parameter RESET_LEN = CLK_HZ;
parameter POWER_LEN = CLK_HZ / 2000;
parameter GLITCH_LEN = 1;

module top(
	input CLK,
	output reg LED1,
	output reg LED2,
	output reg LED3,
	output reg P1B1,
);
reg [1:0] state = RESET;
reg [$clog2(CLK_HZ) + 5:0] cnt;
reg [$clog2(GLITCHES):0] glitches;

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

always @(posedge PLL_CLK) begin
	LED1 <= 0;
	LED2 <= 0;
	LED3 <= 0;
	cnt <= cnt + 1;
	case (state)
		RESET : begin
			LED1 <= 1;
			P1B1 <= 0;
			if (cnt > RESET_LEN) begin
				cnt <= 0;
				state <= WAIT;
			end
		end
		WAIT : begin
			LED2 <= 1;
			P1B1 <= 1;
			if (cnt > WAIT_LEN) begin
				cnt <= 0;
				state <= GLITCH;
				glitches <= 0;
			end
		end
		POWER : begin
			LED3 <= 1;
			P1B1 <= 1;
			if (cnt > POWER_LEN) begin
				cnt <= 0;
				state <= GLITCH;
			end
		end
		GLITCH : begin
			P1B1 <= 0;
			if (cnt > GLITCH_LEN) begin
				cnt <= 0;
				state <= POWER;
				glitches <= glitches + 1;
			end
			if (glitches > GLITCHES) begin
				cnt <= 0;
				state <= RESET;
			end
		end
	endcase
end
endmodule
