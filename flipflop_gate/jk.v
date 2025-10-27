`timescale 1ns / 1ps
module jk_flipflop (j,k,clk,pre,clr,q,qbar);
     input j,k,clk;
     input  clr,pre;
    output  q;
    output qbar;
    wire w1,w2;
    nand n1 (w1,j,clk,qbar);
    nand n2 (w2,k,clk,q);
    nand n3 (q,w1,qbar,pre);
    nand n4 (qbar,w2,q,clr);
endmodule

module jk_tb;
    reg j,k,clk;
    reg clr,pre;    
    wire q,qbar;
    jk_flipflop uut (j,k,clk,pre,clr,q,qbar);
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    initial begin
    j = 0; k = 0; pre = 1; clr = 1;
end

    initial begin
        $monitor($time, " J=%b K=%b | Q=%b Qbar=%b", j, k, q, qbar);
        $dumpfile("jk_flipflop.vcd");
        $dumpvars(0,jk_tb);
        clr =1'b0;
        #10 clr=1'b1; pre=1'b1;
        #10 j = 1'b0; k = 1'b0;
                #10
        j = 1'b0; k = 1'b1; 
        #10
        j = 1'b1; k = 1'b0; 
        #10 
        j = 1'b1; k = 1'b1; 
        #10 
        j = 1'b0; k = 1'b0; 
        #1000
        $finish;
    end
endmodule


 

   