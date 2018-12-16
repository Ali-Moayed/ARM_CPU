module shiftL2 (shiftin , shiftout);

input [63:0] shiftin;
output [63:0] shiftout;

assign shiftout = shiftin << 2 ;

endmodule