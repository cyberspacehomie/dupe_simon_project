module debouncer(
	output pressed, held,
	input button, clk, reset
	);

	localparam sampletime = 1999999;//20ms
	reg [20:0] timer;
	reg bt_samp, bt_deb, bt_deb_d;

	always @(posedge clk) begin
		if (reset) begin
			timer <=sampletime;
		end
		else begin
			timer <= timer -1;
			if (timer == 0) begin
				timer <= sampletime;
			end
		end
	end

	always@(posedge clk) begin
		bt_deb_d <= bt_deb;
		if (timer == 0) begin
			bt_samp <= button;
			if (bt_samp == button)
				bt_deb <= button;
		end
	end	
	
	assign held = bt_deb;
	assign pressed = bt_deb & ~bt_deb_d; // falling edge detection
endmodule
