`timescale 1ns / 1ps

module jkms(j,k,clk,pre,clr,q,qbar);
        input j,k,clk;
        input  clr,pre;
        output  q;
        output qbar;
        wire w1,w2,w3,w4,w5,w6;
        nand n1 (w1,j,clk,qbar);
        nand n2 (w2,k,clk,q);
        nand n3 (w3,w1,pre,w4);
        nand n4 (w4,w2,clr,w3);
        nand n5 (w5,w3,~clk);
        nand n6 (w6,w4,~clk);
        nand n7 (q,w5,qbar);
        nand n8 (qbar,w6,q);
endmodule
module jk_tb;
    reg j,k,clk;
    reg clr,pre;    
    wire q,qbar;
    jkms uut (j,k,clk,pre,clr,q,qbar);
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    initial begin
    j = 0; k = 0; pre = 1; clr = 1;
end

    initial begin
        $monitor($time, " J=%b K=%b | Q=%b Qbar=%b", j, k, q, qbar);
        $dumpfile("jkms_flipflop.vcd");
        $dumpvars(0,jk_tb);
        pre=1'b1;
       clr=1'b0; j=1'b0;k=1'b0;#10; // assign known values for J and K before clr is released
       clr=1'b1;
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