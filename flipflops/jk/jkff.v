module jkff(j, k, clk,clr,pre, q, qbar);
  input j, k, clk,clr,pre;
  output reg q;
  output qbar;

  assign qbar = ~q;

  always @(posedge clk) 
  begin
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
    case ({j,k})
      2'b00: q <= q;       // No change
      2'b01: q <= 0;       // Reset
      2'b10: q <= 1;       // Set
      2'b11: q <= ~q;      // Toggle
    endcase
  end
  end
endmodule

module jkff_test();
reg j,k,clk,pre,clr;
wire q,qbar;

jkff f1 (.j(j),.k(k),.clk(clk),.pre(pre),.clr(clr),.q(q),.qbar(qbar));
initial 
clk=1'b0;

always 
#5 clk=~clk;

always@(posedge clk)
begin
    $monitor($time,"j=%b,k=%b,q=%b,qbar=%b",j,k,q,qbar);
    $dumpfile("jkff.vcd");
    $dumpvars(0,jkff_test);
    pre =1'b1; clr=1'b1;j=1'b0;k=1'b0;
    #5 clr=1'b0;
    #5 clr=1'b1;
    #10 j=0;k=0;
    #10 j=1;k=0;
    #10 j=0;k=1;
    #10 j=1;k=1;
    #10 j=0;k=0;
    #10 $finish;
end
endmodule
