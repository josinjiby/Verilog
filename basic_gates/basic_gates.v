//================= Basic Logic Gates Module =================
module basic_gates(a, b, and_out, nand_out, or_out, nor_out, not_out, xor_out);
    input a, b;
    output and_out, nand_out, or_out, nor_out, not_out, xor_out;

    assign and_out  = a & b;
    assign or_out   = a | b;
    assign not_out  = ~a;       // NOT is applied only to 'a' (could also do for 'b' separately)
    assign nand_out = ~(a & b);
    assign nor_out  = ~(a | b);
    assign xor_out  = a ^ b;
endmodule


//================= Testbench =================
module basic_gates_tb;
    reg a, b;
    wire and_out, or_out, not_out, nand_out, nor_out, xor_out;

    // Instantiate the design under test (DUT)
    basic_gates uut (
        .a(a), .b(b),
        .and_out(and_out),
        .or_out(or_out),
        .not_out(not_out),
        .nand_out(nand_out),
        .nor_out(nor_out),
        .xor_out(xor_out)
    );

    initial begin
        // Create waveform file
        $dumpfile("basic_gates.vcd");
        $dumpvars(0, basic_gates_tb);

        // Print header
        $display("A B | AND OR NOT NAND NOR XOR");

        // Print changing values
        $monitor("%b %b |  %b   %b   %b    %b    %b    %b",
                 a, b, and_out, or_out, not_out, nand_out, nor_out, xor_out);

        // Apply input combinations
        a = 0; b = 0; #10;
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;

        $finish;
    end
endmodule

