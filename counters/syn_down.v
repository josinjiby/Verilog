module tff(t, clk, q, qbar, pre, clr);
    input t, clk, pre, clr;
    output q, qbar;
    reg q;                  // must be 'reg' because assigned inside always
    assign qbar = ~q;       // continuous assignment (combinational)

    always @(posedge clk or posedge pre or posedge clr)
    begin
        if (clr)
            q <= 1'b0;      // use non-blocking assignment
        else if (pre)
            q <= 1'b1;
        else if (t)
            q <= ~q;
    end
endmodule

module syn_down(t,clk,q,qbar,pre,clr);
input t,clk,pre,clr;
output [3:0] q;
output [3:0] qbar;
wire [3:0] q;
wire [3:0] qbar;

tff t0(1'b1,clk,q[0],qbar[0],pre,clr);
tff t1(qbar[0],clk,q[1],qbar[1],pre,clr);
tff t2(qbar[0]&qbar[1],clk,q[2],qbar[2],pre,clr);
tff t3(qbar[0]&qbar[1]&qbar[2],clk,q[3],qbar[3],pre,clr);
endmodule

module syn_downtb;
    reg clk, pre, clr;
    wire [3:0] q;
    wire [3:0] qbar;

    syn_down uut(.clk(clk), .q(q), .qbar(qbar), .pre(pre), .clr(clr));

    initial begin
        clk = 0;
        forever #5 clk = ~clk; // clock period = 10 time units
    end

    initial begin
        $monitor($time, " q=%b", q);
        $dumpfile("syn_down_counter.vcd");
        $dumpvars(0, syn_downtb);
        pre = 0; clr = 1;  // clear active
        #10 clr = 0; pre = 0;  // normal operation
        #200 $finish;
    end
endmodule