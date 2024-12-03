// Nothing goes in this module
// just module instances and the state machine!
module top(
        output [2:0] simon_led0, simon_led1, simon_led2, simon_led3,
        output [3:0] led,
        input [3:0] simon_buttons_n,
        input clk,
        input [3:0] sw
);

        wire [3:0] simon_buttons = ~simon_buttons_n;

        //  debounced simon buttons, the state machine inputs   
        wire [3:0] deb_held;
        wire [3:0] deb_press;
        wire button_ctrl_out;

        reg [7:0] score_count, round_count;


        //  states for state machine NEED TO MAKE MORE STATES, Keep it simple!
        localparam IDLE = 0, RANDOMIZE = 1, 
        SEQUENCE = 2, USERINPUT = 3,
        CORRECT = 4, SEQUENCECOMPLETE = 5, 
        INCORRECT = 6;

        reg [4:0] c_state, n_state; 

        //  state machine outputs
        //  missing lcd out and a few others, will probably be reg
        reg [1:0] color, rand_color, sel_color;
        reg led_enable, step, randomize, play_seq, rerun;
        reg reset;
        
        reg [24:0] timer_loadvalue;
        reg timer_reset, timer_enable;
        reg score_count_reset, score_count_enable;
        reg round_count_reset, round_count_enable;
        reg rand_reset;
        reg color_enable, tone_enable;
        reg [6:0] round_count, rounds, key_sequence_count;
        wire [17:0] note_wr;
        wire [2:0] note_sel;

	reg seq_count_tick, round_count_tick;
	reg round_count, seq_count;

        debouncer deb_s0 (
                .pressed(deb_press [0]), 
                .held(deb_held [0]),
                .button(simon_buttons[0]),
                .reset(reset)
        );

        debouncer deb_s1 (
                .pressed(deb_press [1]), 
                .held(deb_held [1]),
                .button(simon_buttons[1]),
                .reset(reset)
        );

        debouncer deb_s2 (
                .pressed(deb_press [2]), 
                .held(deb_held [2]),
                .button(simon_buttons[2]),
                .reset(reset)
        );

        debouncer deb_s3 (
                .pressed(deb_press [3]), 
                .held(deb_held [3]),
                .button(simon_buttons[3]),
                .reset(reset)
        );

        button_ctrl simon_button_loc (
                .button_loc(sel_color),
                .button_in(deb_press),
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
                .enable(1)
        );

        PRNG simon_rand(
                .random(rand_color),
                .step(step),
                .rerun(rerun),
                .randomize(randomize),
                .clk(clk),
                .reset(rand_reset)
        );
        scale_decoder simon_scl_dec (
                .note(note_wr),
                .sel(note_sel),
                .enable(1)       
        );
        speakerselect simon_spk (
                .speaker(speaker),
                .note(note_wr),
                .enable(tone_enable),
                .clk(clk)
        );

	counter round_ct (
		.count(round_count),
		.pulse(round_count_tick),
		.reset(round_count_reset),
		.enable(round_count_enable),
		.clk(clk)
	);

	counter seq_ct (
		.count(key_sequece_count),
		.pulse(seq_count_tick),
		.reset(seq_count_reset),
		.enable(seq_count_enable),
		.clk(clk)
	);

	counter score_ct(
		.count(score_count),
		.pulse(score_count_tick),
		.reset(score_count_reset),
		.enable(score_count_enable),
		.clk(clk)
	);

        assign led = c_state;
        
	always @(posedge clk) begin
                c_state <= n_state;  
        end

        always @* begin
                n_state = c_state;
                timer_reset = 0;
                timer_enable = 0;
                timer_loadvalue = 0;
                score_count_reset = 0;
                score_count_enable = 0;
                round_count_reset = 0;
                round_count_enable = 0;
        end

        always @* begin    
                case(c_state)
                        IDLE: begin
                                round = 1; // set round to 1
                                // this is our RESET state
                                led_enable = 0;  // keeps leds dim
                                if (deb_held[0]) begin // when button input, move to randomize
                                        led_enable = 1;
                                        n_state = RANDOMIZE;
                                end else begin  
                                        n_state = IDLE;
                                end
                                // dim unless they're lit up by button press/sequence?)
                                // waiting for button input
                                // print message to LCD welcoming to game
                        end

                        RANDOMIZE: begin
                                if (deb_held[0]) begin
                                        randomize = 1;
                                end else begin
                                        randomize = 0;
                                        n_state = SEQUENCE;
                                        led_enable = 0;
                                end
                                // randomize LFSR
                                // print score message to LCD, this should
                                // not really change until incorrect input
                                // prompts a return to IDLE
                        end

                        SEQUENCE: begin
                                // the timing and counting should happen via
                                // a counter module, which should deal with
                                // all of this
                                if (key_sequence_count <= rounds) begin
                                        rand_color = random;
                                        led_enable = 1;
                                        color = rand_color;
                                end else begin
                                        n_state = USERINPUT;
                                end


                                        
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
                                if (deb_held != 4'b0000) begin
                                        color = color_sel;
                                        if (color_sel == something /* idk something goes here */) begin
                                        
                                        end
                                end
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
