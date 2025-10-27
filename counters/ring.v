`timescale 1ns / 1ps
module ring_counter(clk, q);
  input clk;
  output reg [3:0] q;

  initial begin
    q = 4'b1000; // Initialize the counter to 0001
  end

  // On each positive edge of the clock, rotate the bits to the left
  always @(posedge clk) begin
    q <= {q[0],q[3:1]};
  end

endmodule

module tb;
  reg clk;
  wire [3:0] q;

  ring_counter uut (.clk(clk), .q(q));

  initial begin
    clk = 0;  
    forever #5 clk = ~clk; 
  end

  always @(posedge clk) begin 
    $monitor($time, "%b%b%b%b", q[3], q[2], q[1], q[0]); 
    $dumpfile("ring.vcd");
    $dumpvars(0, tb);
    #100 $finish;
  end
endmodule