module adder(sum,carry,a,b);
input a,b;
output sum,carry;
wire a,b;
wire sum,carry;

and y(carry,a,b);
xor x(sum,a,b);
endmodule

module half_adder_sim();
reg a,b;
wire carry,sum;
adder a1(.sum(sum),.carry(carry),.a(a),.b(b));
initial 
begin
$monitor($time,"a=%b,b=%b.sum=%b.carry=%b",a,b,sum,carry);
$dumpfile("half_adder.vcd");
$dumpvars(0,half_adder_sim);
#5 a=0;b=0;
#5 a=0;b=1;
#5 a=1;b=0;
#5 a=1;b=1;
#5 $finish;
end
endmodule