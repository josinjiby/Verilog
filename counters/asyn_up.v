//================= T Flip-Flop Module =================
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

//================= Asynchronous Up Counter =================
module asyn_up(clk, q, qbar, pre, clr);
    input clk, pre, clr;
    output [3:0] q;
    output [3:0] qbar;

    // Instantiate 4 TFFs; connect each stage’s clock to previous q output
    tff t0(.t(1'b1), .clk(clk),       .q(q[0]), .qbar(qbar[0]), .pre(pre), .clr(clr));
    tff t1(.t(1'b1), .clk(qbar[0]),      .q(q[1]), .qbar(qbar[1]), .pre(pre), .clr(clr));
    tff t2(.t(1'b1), .clk(qbar[1]),      .q(q[2]), .qbar(qbar[2]), .pre(pre), .clr(clr));
    tff t3(.t(1'b1), .clk(qbar[2]),      .q(q[3]), .qbar(qbar[3]), .pre(pre), .clr(clr));
endmodule

//================= Testbench =================
module asyn_uptb;
    reg clk, pre, clr;
    wire [3:0] q;
    wire [3:0] qbar;

    asyn_up uut(.clk(clk), .q(q), .qbar(qbar), .pre(pre), .clr(clr));

    initial begin
        clk = 0;
        forever #5 clk = ~clk; // clock period = 10 time units
    end

    initial begin
        $monitor($time, " q=%b", q);
        $dumpfile("asyn_up_counter.vcd");
        $dumpvars(0, asyn_uptb);
        pre = 0; clr = 1;  // clear active
        #10 clr = 0; pre = 0;  // normal operation
        #200 $finish;
    end
endmodule
