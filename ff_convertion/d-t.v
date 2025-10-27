module d(d,clk,q,qbar,pre,clr);
input d,clk,pre,clr;
output q,qbar;
wire q,qbar;
wire w1,w2;

nand n1(w1,d,clk);
nand n2(w2,clk,~d);
nand n3(q,w1,qbar,pre);
nand n4(qbar,w2,q,clr);
endmodule

module t(t,clk,q,qbar,pre,clr);
input t,clk,pre,clr;
output q,qbar;
wire q,qbar;
wire w=t^q;

d d1 (.d(w),.clk(clk),.q(q),.qbar(qbar),.pre(pre),.clr(clr));
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

