module tff(t,clk,pre,clr,q,qbar);
input t,clk,pre,clr;
output q,qbar;
assign qbar = ~q;
reg q;

always@(posedge clk or posedge pre or posedge clr)
begin
    if(pre)
        q=1'b1;
    else if(clr)
        q=1'b0;
    else if(t)
        q=~q;
end
endmodule

module tff_tb;
reg t,clk,pre,clr;
wire q,qbar;
tff uut(t,clk,pre,clr,q,qbar);
initial begin
    clk=0;
    forever #5 clk=~clk;
end
initial begin
    $monitor($time," T=%b | Q=%b Qbar=%b",t,q,qbar);
    $dumpfile("tff_flipflop.vcd");
    $dumpvars(0,tff_tb);
    pre=1'b1;
    clr=1'b0; #10; // assign known values for T before pre is released
    pre=1'b0;
    #10 t=1'b1;
    #50 t=1'b0;
    #20 t=1'b1;
    #50 t=1'b1;
    #10
    $finish;
end
endmodule