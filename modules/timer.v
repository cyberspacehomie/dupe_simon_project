module timer (output reg pulse,
input clk, input reset, input [24:0] time);

reg [25:0] counter;

always @* begin
    if (counter == 0) pulse = 1;
    if (reset) pulse = 0;
end

always @(posedge clk) begin
    counter = counter - 1;
    if ((counter == 0) || (reset)) counter = time;

end
// basically this should take a target value (time) 
// count up to it, output pulse when done 

endmodule