module led_ctrl(
    output reg [2:0] led0, led1, led2, led3, 
    input [1:0] color,
    input clk, enable
    );
    
    localparam MS=100000;
    localparam RED=3'b001, GREEN=3'b010, BLUE=3'b100, YELLOW=3'b011, BLACK=3'b000;
    
    reg [18:0] timer;
    always @* begin
        led0 = BLACK;
        led1 = BLACK;
        led2 = BLACK;
        led3 = BLACK;
        
        if (timer < MS) begin
            led0 = GREEN;
            led1 = RED;
            led2 = BLUE;
            led3 = YELLOW;
        end
        
        if (enable) begin
            case (color)
                0: led0 = GREEN;
                1: led1 = RED;
                2: led2 = BLUE;
                3: led3 = YELLOW;
            endcase
        end
     end
     
     always @(posedge clk) begin
        timer <= timer + 1;
        if (timer >= ((5*MS)-1))
            timer <= 0;
        end
endmodule
