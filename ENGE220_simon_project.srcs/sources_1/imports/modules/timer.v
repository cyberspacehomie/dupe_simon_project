module timer (output reg pulse,
input clk, reset, enable, input [24:0] loadvalue);

reg [25:0] counter;

always @* begin
    if (enable) begin
        if (counter == 0) pulse = 1;
        if (reset) pulse = 0;
    end
end

always @(posedge clk) begin
    if (enable) begin
        counter = counter - 1;
        if ((counter == 0) || (reset)) counter = loadvalue;
    end
end
// basically this should load a counter with a target value (time input) 
// count down from it to 0, output pulse when it hits 0, and then reset itself 

endmodule