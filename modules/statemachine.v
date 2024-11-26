

localparam IDLE = 0, RANDOMIZE = 1, 
            SEQUENCE = 2, USERINPUT = 3,
            CORRECT = 4, SEQUENCECOMPLETE = 5, 
            INCORRECT = 6;

case(STATE)
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
        // each tone should be played for 3/4 of a second
        // with a 1/4 gap between tones
        // after playing tones, should move to USERINPUT
        // can use key_sequence_count for this to count up
        // until it reaches round_count, where it moves to USERINPUT
    end

    USERINPUT: begin
        // when user presses a button, it lights up and plays tone
        // button debouncing necessary so that each is only registered once
        // once button released, compare to appropriate key in sequence 
        // if user presses the correct key, go to CORRECT.
        // if user presses correct key and key_sequence_count == round_count, go to SEQUENCECOMPLETE
        // if they don't, go to INCORRECT

    end

    CORRECT: begin
        // increment key_sequence_count
        // go back to USERINPUT
        
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
        next = IDLE;
    end


endcase