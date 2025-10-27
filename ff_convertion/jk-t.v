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

module t(t,clk,q,qbar,pre,clr);
input t,clk,pre,clr;
output q,qbar;
wire q,qbar;
jkms jk1 (.j(t),.k(t),.clk(clk),.pre(pre),.clr(clr),.q(q),.qbar(qbar));
endmodule

module ttb();
reg t,clk,pre,clr;
wire q,qbar;
t t1 (.t(t),.clk(clk),.q(q),.qbar(qbar),.pre(pre),.clr(clr));
initial begin
    clk = 0;
    t=1;
    forever #5 clk = ~clk;
end
initial begin
    $monitor($time, " T=%b | Q=%b Qbar=%b", t, q, qbar);
    pre = 1'b1;
    clr = 1'b0; t = 1'b0; #11; // assign known value for T before clr is released
    clr = 1'b1;
    #11 t = 1'b0; // T = 0
    #11 t = 1'b1; // T = 1
    #11 t = 1'b0; // T = 0
    #11 t = 1'b1; // T = 1


    #10 $finish; // End simulation
end
endmodule