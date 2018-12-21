module controll_unit(opcode,Reg2Loc,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUOp1,ALUOp0);
//11 bit for opcode
input [10:0]opcode;

//outputs
output reg Reg2Loc,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUOp1,ALUOp0;

//base on book in page 281, FIGURE 4.22
always@(opcode)
	begin
	casex(opcode)
			//R-format
			11'b1xx0101x000: 
			begin
				{Reg2Loc,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUOp1,ALUOp0} <= 9'b000100010;
			end
			//LDUR
			11'b11111000010: begin 
				{Reg2Loc,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUOp1,ALUOp0} <= 9'b011110000;
              	  
			end
			//STUR
			11'b11111000000: begin
				{Reg2Loc,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUOp1,ALUOp0} <= 9'b110001000;
				
			end
			//CBZ
			11'b10110100xxx: begin
				{Reg2Loc,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,Branch,ALUOp1,ALUOp0} <= 9'b100000101;
			end
		endcase
	end
endmodule 
