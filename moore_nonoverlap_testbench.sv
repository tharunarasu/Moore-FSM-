

//Moore FSM 11001 Testbench

module tb_moore_detector;
   logic clk,reset,in;
  logic out;
  
  moore_fsm_non_overlap dut (
    .clk(clk),
    .reset(reset),
    .in(in),
    .out(out)
  );
 // Generate clock
  always #5 clk = ~clk;

  // Apply sequence aligned to posedge clk
  task apply_sequence(input logic [31:0] pattern, input int length);
    for (int i = 0; i < length; i++) begin
      in = pattern[length - 1 - i];  // Bit-order fix: MSB first
      @(posedge clk);                // Sync with FSM
      $display("%0t\tin=%b\tout=%b", $time, in, out);
    end
  endtask

  initial begin
    clk = 0;
    reset = 1;
    in = 0;

    #10;
    reset = 0;

    // Example: test for 11001 (5-bit pattern repeated)
    apply_sequence(32'b110011100110011001101100, 24);

    #20;
    $finish;
  end

endmodule