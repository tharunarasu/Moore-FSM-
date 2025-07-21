//Moore FSM Non Overalp Sequence 11001


// Code your design here


module moore_fsm_non_overlap(

  input logic clk, reset, in,
  output logic out
);
  
  typedef enum logic [2:0] {
    S0, S1, S2,S3, S4, S5
  } state_t;
  
  
  state_t curr_state, next_state;
  
  always_ff @(posedge clk or negedge reset)
    begin
      if(reset)
        curr_state <= S0;
      else
        curr_state <= next_state;
    end
  
  always_comb 
    begin
      case(curr_state)
        S0: next_state = (in) ? S1: S0;
        S1: next_state = (in) ? S2: S0;
        S2: next_state = (in) ? S2: S3;
        S3: next_state = (in) ? S2 : S4;
        S4: next_state = (in) ? S5: S0;
        S5: next_state = S0;
        default  : next_state =S0;
      endcase
    end
  
  always_comb 
    begin
      case(curr_state)
        S5 : out = 1;
        default : out = 0;
      endcase
    end
endmodule


  