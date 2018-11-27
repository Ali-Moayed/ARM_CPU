module test(out);

output out;

wire clock,A,B,op,z;

CLK clk(clock);
test_bench tb(out,clock,A,B,op);
alu alu0(A,B,op,z,out);

endmodule