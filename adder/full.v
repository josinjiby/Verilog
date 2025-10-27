module full_adder(sum,cout,a,b,cin);
input a,b,cin;
output sum,cout;
wire w1,w2,w3;

xor x(sum,a,b,cin);
and a1(w1,a,b);
xor x2(w2,a,b);
and a2(w3,cin,w2);
or o(cout,w1,w3);

endmodule


module full_adder_sim();
reg a,b,cin;
wire sum,cout;

full_adder f(.a(a),.b(b),.cin(cin),.cout(cout),.sum(sum));
initial 
begin 
$monitor($time,"a=%b,b=%b,cin=%b,sum=%b,cout=%b",a,b,cin,sum,cout);
$dumpfile("full_adder.vcd");
$dumpvars(0,full_adder_sim);
#5 a=0;b=0;cin=0;
#5 cin=1;
#5 b=1;cin=0;
#5 cin=1;
#5 a=1;b=0;cin=0;
#5 cin=1;
#5 b=1;cin=0;
#5 cin=1;
#5 $finish;
end
endmodule