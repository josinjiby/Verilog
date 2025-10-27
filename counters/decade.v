module jkff(j, k, clk, q, qbar);
  input j, k, clk;
  output reg q;
  output qbar;

  assign qbar = ~q;

  always @(posedge clk) begin
    case ({j,k})
      2'b00: q <= q;       // No change
      2'b01: q <= 0;       // Reset
      2'b10: q <= 1;       // Set
      2'b11: q <= ~q;      // Toggle
    endcase
  end
endmodule

module decade(clk, q0, q1, q2, q3, reset);
  input clk, reset;
  output reg q0, q1, q2, q3;
   reg [25:0] div_count;     // 26-bit counter for division
    reg slow_clk;             

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            div_count <= 26'd0;
            slow_clk <= 1'b0;
        end else begin
            div_count <= div_count + 1;
            if (div_count == 26'd49_999_999) begin  // for 100 MHz input → ~1 Hz output
                slow_clk <= ~slow_clk;              
                div_count <= 26'd0;
            end
        end
    end

  always @(posedge clk) begin
    if (reset) begin
      {q3, q2, q1, q0} <= 4'b0000;
    end else begin
      if ({q3, q2, q1, q0} == 4'b1001) begin
        {q3, q2, q1, q0} <= 4'b0000;
      end else begin
        {q3, q2, q1, q0} <= {q3, q2, q1, q0} + 1'b1;
      end
    end
  end
endmodule

module decade_test();
  reg clk, reset;
  wire q0, q1, q2, q3;

  decade D1 (.clk(clk), .q0(q0), .q1(q1), .q2(q2), .q3(q3), .reset(reset));

  initial begin
    clk = 1'b0;
    reset = 1'b1;  // Initialize with reset asserted
    #10 reset = 1'b0; // Deassert reset after 10 time units
  end

  always #5 clk = ~clk;

  initial begin
    $monitor($time, "  q3q2q1q0 = %b%b%b%b", q3, q2, q1, q0);
    $dumpfile("decade.vcd");
    $dumpvars(0, decade_test);
    #200 $finish;
  end
endmodule