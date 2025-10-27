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