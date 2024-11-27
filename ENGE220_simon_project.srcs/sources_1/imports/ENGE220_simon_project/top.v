// Nothing goes in this module
// just module instances and the state machine!
module top(
    output [2:0] simon_led0, simon_led1, simon_led2, simon_led3,
    output [3:0] led,
    input [3:0] simon_buttons_n,
    input clk
	);

//  debounced simon buttons, the state machine inputs	
    wire [3:0] deb_s1_held;
    wire [3:0] deb_s1_press;
    wire button_ctrl_out;

	reg [7:0] score_count, round_count;


//  states for state machine
		localparam IDLE = 0, RANDOMIZE = 1, 
		    SEQUENCE = 2, USERINPUT = 3,
		    CORRECT = 4, SEQUENCECOMPLETE = 5, 
		    INCORRECT = 6;
		
	reg [3:0] c_state, n_state; 

//  state machine outputs
//  missing lcd out and a few others, will probably be reg
    wire [1:0] color;
    wire led_enable, step, randomize, play_seq;
    wire reset;


    debouncer deb_s0 (
	    .pressed(deb_s1_press [0]), 
	    .held(deb_s1_held [0]),
	    .button(simon_buttons_n[0]),
	    .reset(reset)
    );

    debouncer deb_s1 (
	    .pressed(deb_s1_press [1]), 
	    .held(deb_s1_held [1]),
	    .button(simon_buttons_n[1]),
	    .reset(reset)
    );
    
    debouncer deb_s2 (
	    .pressed(deb_s1_press [2]), 
	    .held(deb_s1_held [2]),
	    .button(simon_buttons_n[2]),
	    .reset(reset)
    );

    debouncer deb_s3 (
	    .pressed(deb_s1_press [3]), 
	    .held(deb_s1_held [3]),
	    .button(simon_buttons_n[3]),
	    .reset(reset)
    );

    button_ctrl simon_button_loc (
        .button_loc(color),
        .button_in(deb_s1_press),
        .button_out(button_ctrl_out),
	    .enable(1)
    );
    
    led_ctrl simon_color_ctrl (
        .led0(simon_led0), 
        .led1(simon_led1), 
        .led2(simon_led2), 
        .led3(simon_led3), 
        .clk(clk), 
        .color(color), 
        .enable(button_ctrl_out)
        );

	always @(posedge clk) begin
		c_state <= n_state;	 
	end

	always @* begin
		n_state = c_state;
	end

    always @* begin    
				case(c_state)
					IDLE: begin
							// this is our RESET stae
							// led duty cycle should keep them dim
							// (should we have an always that keeps LEDs
							// dim unless they're lit up by button press/sequence?)
							// waiting for button input
							// print message to LCD welcoming to game
							// when button input, move to randomize
					end

					RANDOMIZE: begin
							// randomize LFSR
							// print score message to LCD, this should
							// not really change until incorrect input
							// prompts a return to IDLE
					end

					SEQUENCE: begin
							// this should play a pseudorandom sequence of tones
							// how many is dependent on round counter,
							// initial round count should be 1
							// each tone should be played for 3/4 second
							// with a 1/4 second gap between tones
							// after playing tones, should move to USERINPUT
							// can use key_sequence_count for this to count up
							// until it reaches round_count, where it moves to USERINPUT
					end

					USERINPUT: begin
							// when user presses a button, it lights up and plays tone
							// button debouncing necessary so that each is only registered once
							// once button released, compare to appropriate key in sequence 
							// if user presses the correct key, go to CORRECT.
							// if user presses correct key and key_sequence_count == round_count, 
							// go to SEQUENCECOMPLETE
							// if they don't, go to INCORRECT

					end

					CORRECT: begin
							// increment key_sequence_count
							// go back to USERINPUT, unless
							
					end

					SEQUENCECOMPLETE: begin
							// if USERINPUT is successful, play a success tone
							// update score_count and LCD message
							// increment round_count and go to SEQUENCE
					end

					INCORRECT: begin
							// play failure tone
							// print failure message
							// wait a second
							// return to IDLE
					end

					default: begin
							n_state = IDLE;
					end
				endcase
			end

endmodule
