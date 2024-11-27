module button_ctrl(
    output reg [1:0] button_loc,
    output button_out,
    input [3:0] button_in,
    input enable
    );
  	wire button_down = button_in [0] | button_in [1] | button_in [2] | button_in [3]; 
  	
    always @* begin
        if (enable && button_down) begin
            case (button_in)
                4'b0001: button_loc = 2'b00;
                4'b0010: button_loc = 2'b01;
                4'b0100: button_loc = 2'b10;
                4'b1000: button_loc = 2'b11;
            endcase
        end
    end 

    assign button_out = button_down;
endmodule
