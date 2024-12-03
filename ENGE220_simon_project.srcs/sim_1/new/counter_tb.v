module counter_tb();
	wire [7:0] count;
	reg pulse, reset, enable, clk;
	counter uut (
		.count(count),
		.pulse(pulse),
		.reset(reset),
		.enable(enable),
		.clk(clk)
	);

	always #5 clk = ~clk;
	always #5 pulse = ~pulse;

	initial begin
		clk = 0;
		pulse = 0;
		reset = 1;
		enable = 1;

		#37

		reset = 0;

		#46

		enable = 0;

		#10

		enable = 1;

		#10

		reset = 1;

		#5 reset = 0;
	end
		
endmodule
