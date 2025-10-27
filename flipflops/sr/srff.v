module srff(clk,s,r,q,qbar);
input clk,s,r;
output q,qbar;
wire [1:0]w;


assign w[0]=~(s&clk);
assign w[1]=~(r&clk);
assign q=~(w[0]&qbar);
assign qbar=~(w[1]&q);

endmodule

module srff_test();
reg clk,s,r;
wire q,qbar;

srff f1 (.clk(clk),.s(s),.r(r),.q(q),.qbar(qbar));

initial clk = 1'b0;
always #5 clk = ~clk;

initial begin
    $monitor($time," s=%b, r=%b, q=%b, qbar=%b", s, r, q, qbar);
    $dumpfile("srff.vcd");
    $dumpvars(0,srff_test);
    s=0; r=1;
    #10 s=1; r=0;
    #10 s=0; r=0;
    #10 s=0; r=1;
    #10 s=1; r=1;
    #10 $finish;
end

endmodule