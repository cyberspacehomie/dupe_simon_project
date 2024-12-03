module counter(
	output reg [7:0] count,
	input pulse, reset, enable,
	input clk
	);

	always @(posedge clk) begin
		if (enable) begin
			count <= count;
			if (reset) begin
				count <= 0;
			end
			if (pulse) begin
				count <= count + 1;
			end
		end	
	end
endmodule
