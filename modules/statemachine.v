localparam IDLE = 0, RANDOMIZE = 1, 
            SEQUENCE = 2, USERINPUT = 3,
            CORRECT = 4, SEQUENCECOMPLETE = 5, INCORRECT = 6,

case(STATE)
    IDLE: begin
        // led duty cycle be dim
        // waiting for button input
        // when button input, move to randomize
    end

    RANDOMIZE: begin

    end

    SEQUENCE: begin

    end

    USERINPUT: begin

    end

    CORRECT: begin
    
    end

    SEQUENCECOMPLETE: begin
    
    end

    INCORRECT: begin
    
    end



endcase