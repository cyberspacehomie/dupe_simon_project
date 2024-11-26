module timer (output reg pulse,
input clk, input reset, input [24:0] time);

reg [25;0] counter;

always @* begin

end

always @(posedge clk) begin
    counter = counter + 1;

end
// basically this should take a target value (time) 
// count up to it, output pulse when done 

endmodule