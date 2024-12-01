`timescale 1ns / 1ps
`timescale 1ns/1ps

module button_ctrl_tb;
    // Testbench signals
    reg [3:0] button_in;
    reg enable;
    wire [1:0] button_loc;
    wire button_out;

    // Instantiate the module under test (MUT)
    button_ctrl uut (
        .button_loc(button_loc),
        .button_out(button_out),
        .button_in(button_in),
        .enable(enable)
    );

    // Testbench logic
    initial begin
        // Initialize inputs
        button_in = 4'b0000;
        enable = 1'b0;

        // Apply test cases
        $display("Starting Testbench...");

        // Test 1: No button pressed, enable = 0
        #10;
        $display("Test 1: button_in = %b, enable = %b, button_out = %b, button_loc = %b",
                 button_in, enable, button_out, button_loc);

        // Test 2: Button 0 pressed, enable = 1
        button_in = 4'b0001;
        enable = 1'b1;
        #10;
        $display("Test 2: button_in = %b, enable = %b, button_out = %b, button_loc = %b",
                 button_in, enable, button_out, button_loc);
				button_in = 4'b0000;
				#10;
        // Test 3: Button 1 pressed, enable = 1
        button_in = 4'b0010;
        #10;
        $display("Test 3: button_in = %b, enable = %b, button_out = %b, button_loc = %b",
                 button_in, enable, button_out, button_loc);

				button_in = 4'b0000;
				#10;
        // Test 4: Button 2 pressed, enable = 1
        button_in = 4'b0100;
        #10;
        $display("Test 4: button_in = %b, enable = %b, button_out = %b, button_loc = %b",
                 button_in, enable, button_out, button_loc);

				button_in = 4'b0000;
				#10;
        // Test 5: Button 3 pressed, enable = 1
        button_in = 4'b1000;
        #10;

				button_in = 4'b0000;
				#10;

				
        button_in = 4'b1001;
        #10;

				button_in = 4'b0000;
				#10;
		end
endmodule
  

