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

module d(d,clk,q,qbar,pre,clr);
input d,clk,pre,clr;
output q,qbar;
wire q,qbar;

jkms jk1 (.j(d),.k(~d),.clk(clk),.pre(pre),.clr(clr),.q(q),.qbar(qbar));
endmodule

module dtb();
reg d,clk,pre,clr;
wire q,qbar;
d d1 (.d(d),.clk(clk),.q(q),.qbar(qbar),.pre(pre),.clr(clr));
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end
initial begin
    $monitor($time, " D=%b | Q=%b Qbar=%b", d, q, qbar);
    pre = 1'b1;
    clr = 1'b0; d = 1'b0; #10; // assign known value for D before clr is released
    clr = 1'b1;
    #10 d = 1'b0; // D = 0
    #10 d = 1'b1; // D = 1
    #10 d = 1'b0; // D = 0
    #10 d = 1'b1; // D = 1

    #10 $finish; // End simulation
end
endmodule