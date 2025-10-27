//JOSIN JIBY
//Roll no:39
module mux_4_1(in,sel,out);
input [3:0] in;
input[1:0]sel;
output reg out;

always@(*)
begin
case(sel)
2'b00:out=in[0];
2'b01:out=in[1];
2'b10:out=in[2];
2'b11:out=in[3];
default:out=2'b00;
endcase
end
endmodule

module mux_test();
reg [3:0]in;
reg [1:0]sel;
wire out;

mux_4_1 m (.in(in),.sel(sel),.out(out));
initial
begin
$dumpfile("mux.vcd");
$dumpvars(0,mux_test);
$monitor($time,"in=%b sel=%b out=%b",in,sel,out);
in=4'b1010;sel=2'b00;
#10 sel=2'b01;
#10 sel=2'b10;
#10 sel=2'b11;
#10 $finish;
end 
endmodule