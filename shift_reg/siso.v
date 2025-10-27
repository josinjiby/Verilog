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

module siso(d,clk,q,qbar,pre,clr);
input d,clk,pre,clr;
output [3:0] q;
output [3:0] qbar;
wire [3:0] q;
wire [3:0] qbar;
d d1 (.d(d),.clk(clk),.q(q[0]),.qbar(qbar[0]),.pre(pre),.clr(clr));
d d2 (.d(q[0]),.clk(clk),.q(q[1]),.qbar(qbar[1]),.pre(pre),.clr(clr));
d d3 (.d(q[1]),.clk(clk),.q(q[2]),.qbar(qbar[2]),.pre(pre),.clr(clr));
d d4 (.d(q[2]),.clk(clk),.q(q[3]),.qbar(qbar[3]),.pre(pre),.clr(clr));
endmodule

module sisotb;
reg d,clk,pre,clr;
wire [3:0] q;
wire [3:0] qbar;
siso uut(.d(d),.clk(clk),.q(q),.qbar(qbar),.pre(pre),.clr(clr));
initial begin
    clk=0;
    forever #5 clk=~clk;
end
initial begin
    $monitor($time," d=%b q=%b",d,q);
    pre=1;
    clr=0;
    #11 clr=1;
    d=1;
    #11 d=0;
    #11 d=1;
    #11 d=0;
    #10000 $finish;
end
endmodule