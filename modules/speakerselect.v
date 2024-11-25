module speakerselect(
	output reg speaker, 
	input  [17:0] note,
	input enable, 
	input  clk 
);


	reg [17:0] count_val;
	reg [17:0] counter;

	always @* begin
		count_val = note;
	end

	always @* begin
	   if (enable) begin
            if (counter >= (count_val >> 1)) begin
                speaker = 0;
            end else begin
                speaker = 1;
            end
		end else begin
		  speaker = 0;
		end
	end

	always @(posedge clk) begin
	  	counter <= counter-1;

		if (counter == 0) 
			counter <= count_val-1;
			
		
	end
endmodule


