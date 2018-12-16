module mux2to1(out, in0, in1, select);
	
	parameter n=64;
        ///
        output  [n-1:0] out;
	///
	input [n-1:0] in0;
	input [n-1:0] in1;
	input select;
	///
 	
      assign   out = select ? in1 : in0;
 
endmodule
