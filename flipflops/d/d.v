module d_ff (d,q,,clr,pre,qbar,clk);
input d,clk,pre,clr;
output reg q;
output qbar;
assign qbar=~q;
always @(posedge clk)
if(!clr)
begin
q<=0;
end
else if(!pre)   
begin
q<=1;
end
else
begin
q<=d;
end 
endmodule

module d_ff_test();
reg d,clk,pre,clr;
wire q,qbar;

d_ff D1(.d(d),.q(q),.qbar(qbar),.clk(clk),.clr(clr),.pre(pre));
initial 
clk=1'b0;       
always
#5 clk=~clk;
always@(posedge clk)
begin
    $monitor($time,"d=%b,q=%b,qbar=%b",d,q,qbar);
    $dumpfile("dff.vcd");
    $dumpvars(0,d_ff_test);
    #10 clr=1'b0;
    #10 clr=1'b1;
    #10 d=1'b0;
    #10 d=1'b1;
    #10 d=1'b0;
    #10 d=1'b1;
    #10 $finish;
end
endmodule