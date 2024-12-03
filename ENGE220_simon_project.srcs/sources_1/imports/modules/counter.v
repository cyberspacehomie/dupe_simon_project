module counter (output reg counter_count, input reset, input pulse);
    if (pulse) begin
        if (counter_count == 0) begin
            counter_count = 1;
        end else begin
            counter_count = counter_count + 1
        end
    end
    if (reset) counter_count = 0;

endmodule