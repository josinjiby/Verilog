module johnson(D,clk);
 output reg [0:3] D;
  input clk;

  initial begin
    D = 4'b0000; // Initialize the register to 0000
  end

  // On each positive edge of the clock, shift the bits according to the Johnson sequence.
  always @(posedge clk) begin
    D[3] <= D[2];
    D[2] <= D[1];
    D[1] <= D[0];
    D[0] <= ~D[3];
  end
endmodule

`timescale 1ns / 1ps

module tb;


  reg clk;
 
  wire[3:0]D;

johnson  uut (.clk(clk),.D(D));
  
  

  initial begin clk=0;  
  forever #5 clk=~clk; end

  always@(posedge clk)
   begin 
    $monitor($time,"%b%b%b%b",D[3],D[2],D[1],D[0]); 
    $dumpfile("johnson.vcd");
    $dumpvars(0,tb);
    #100 $finish;
    end
    
  

endmodule