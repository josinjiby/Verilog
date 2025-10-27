module demux4x1(in,sel,out);
input in;
input [1:0] sel;
output reg [3:0] out;

always@(*)
begin
out[3:0]=4'b0000;
case(sel)
2'b00: out[0]=in;
2'b01: out[1]=in;
2'b10: out[2]=in;
2'b11: out[3]=in;
default: out=4'b0000;
endcase    
end
endmodule



module demux_test();
reg in;
reg [1:0] sel;
wire [3:0] out;

demux4x1 d1(.in(in),.sel(sel),.out(out));
initial
begin
$dumpfile("demux4x1.vcd");
$dumpvars(0,demux_test);
$monitor($time,"in=%b sel=%b out=%b",in,sel,out);
in=1'b1; sel=2'b00; #10;
sel=2'b01; #10
sel=2'b10; #10;
sel=2'b11; #10;
end
endmodule

