module alu_control(ALUOp, opCode, op);

input [1:0] ALUOp;
input [10:0] opCode;
output reg [3:0] op;

// figure 4.13
// page 273
always @(ALUOp,opCode) 
begin
    casex(ALUOp)
	2'b00: op <= 4'b0010;
	2'bx1: op <= 4'b0111;
	2'b1x: 
	begin
            if(opCode == 11'b10001011000)
                op <= 4'b0010;
            else if(opCode == 11'b11001011000)
                op <= 4'b0110;
            else if(opCode == 11'b10001010000)
                op <= 4'b0000;
            else if(opCode == 11'b10101010000)
                op <= 4'b0001;
        end
    endcase
end

endmodule 