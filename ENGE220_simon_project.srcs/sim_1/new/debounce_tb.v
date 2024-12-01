module debounce_tb;

  // Inputs
  reg button;
  reg clk;
  reg reset;

  // Outputs
  wire pressed;
  wire held;

  // Instantiate the Unit Under Test (UUT)
  debouncer uut (
    .pressed(pressed),
    .held(held),
    .button(button),
    .clk(clk),
    .reset(reset)
  );

  // Clock generation
  always #5 clk = ~clk; // 100 MHz clock (10 ns period)

  initial begin
    // Initialize Inputs
    clk = 0;
    reset = 1;
    button = 0;

    // Wait for global reset
    #34;
    reset = 0;

    // Scenario 1: Stable button press
    #50 button = 1; // Simulate button press
    #20 button = 0; // Release button after sufficient time
    #20;

    // Scenario 2: Noisy button press
    #50 button = 1;
    #200 button = 0;
    #200 button = 1;
    #50 button = 0;
    #100;

    // Scenario 3: Prolonged button press
    #50 button = 1;
    #50 button = 0;
    #10;

    // End simulation
    $finish;
  end

  initial begin
    // Monitor signals
    $monitor("Time=%0t | button=%b | pressed=%b | held=%b", $time, button, pressed, held);
  end

endmodule
