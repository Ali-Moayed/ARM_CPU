module instr_mem (outpc,Writeins,WriteData,instruction );
//inputs
input [63:0]outpc;
input  Writeins;
input  [63:0] WriteData;

//output
output  [31:0]instruction;
//need mem & i
 	reg [31:0] memory [31:0];
 	integer i;
         
	initial
		begin
		for (i=0; i<32; i=i+1) memory[i] = 32'b0;

		memory[0] = 32'b10001011000_00010_000000_00001_00000; // X0 = X1 + X2; 

		memory[1] = 32'b11001011000_00010_000000_00001_00000; // X0 = X1 - X2;

		memory[2] = 32'b10001010000_00010_000000_00001_00000; // X0 = X1 & X2;

		memory[3] = 32'b10101010000_00010_000000_00001_00000; // X0 = X1 | X2;

		memory[4] = 32'b11111000010_000000000_00_00100_00000;//LDUR X0, [X3, #0]

		memory[5] = 32'b10001011000_00000_000000_00000_00000; // X0 = X0 + X0;

		memory[6] = 32'b11111000010_000000000_00_00100_00000; //STUR X0, [X3, #0]

		memory[7] = 32'b10110100_0000000000000000000_00000; //CBZ X0, 0

		end

	assign instruction =  memory[outpc];
	always@(Writeins)
		begin
		if(Writeins==1)
		memory[outpc] = WriteData;
		end

endmodule