
reg [8*16-1:0] topline, bottomline;
reg [28:0] timer;
reg lcd_string_print;
wire lcd_string_available;

always @(posedge clk) begin
  if (reset) begin
    timer <= 0;
    lcd_string_print <= 0;
  end
  else begin
    if (lcd_string_available) begin
      timer <= timer + 1;
    end
    lcd_string_print <= 0;
    if (timer == 1) begin
      topline    <= "    ENGE 220    ";
      bottomline <= "  SIMON BOARD   ";
      lcd_string_print <= 1;
    end
    if (timer == 200000000) begin
      topline    <= "  DIGITAL LOGIC ";
      bottomline <= "     IS FUN!    ";
      lcd_string_print <= 1;
    end
    if (timer >= 400000000) begin
      timer <= 0;
    end
  end
endendmodule