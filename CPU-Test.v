module CPU_Test();

wire [63:0]mux2pc;

wire [63:0]pc2out;

wire [63:0]add2mux_1;

wire [31:0]insMem2out;

wire con2mux_1;
wire con2and;
wire con2mem_1;
wire con2mux_2;
wire con2ALUcon_1;
wire con2ALUcon_2;
wire con2mem_2;
wire con2mux_3;
wire con2reg;

wire [4:0]mux2reg_1;

wire [63:0]reg2ALU;
wire [63:0]reg2mux_mem;

wire [63:0]sign2out;

wire [63:0]shift2add;

wire [63:0]add2mux_2;

wire [63:0]mux2ALU;

wire [3:0]ALUcon2ALU;

wire ALU2and;
wire [63:0]ALU2mux_mem;

wire [63:0]mem2mux;

wire [63:0]mux2reg_2;

wire clk;

reg pcReset;
initial  
begin  
	pcReset=1'b1;
        #10 pcReset = 1'b0; 
end 


CLK clock(clk);

pc pc(mux2pc, pcReset, clk, pc2out);
Adder Adder_1(pc2out, 64'b0000000000000000000000000000000000000000000000000000000000000100, add2mux_1);
instr_mem instr_mem(pc2out, insMem2out);

controll_unit controll_unit(insMem2out[31:21], con2mux_1, con2mux_3, con2mux_2, con2reg, con2mem_1, con2mem_2, con2and, con2ALUcon_1, con2ALUcon_2);
mux2to1 mux2to1_1(mux2reg_1, insMem2out[20:16], insMem2out[4:0], con2mux_1); defparam mux2to1_1.n = 5;
RegisterBank RegisterBank(insMem2out[9:5], mux2reg_1, insMem2out[4:0], reg2ALU, reg2mux_mem, mux2reg_2, con2reg, clk);
signextended signextended(insMem2out ,sign2out);

shiftL2 shiftL2(sign2out , shift2add);
Adder Adder_2(pc2out, shift2add, add2mux_2);
mux2to1 mux2to1_2(mux2ALU, reg2mux_mem, sign2out, con2mux_3);
alu_control alu_control({con2ALUcon_1,con2ALUcon_2}, insMem2out[31:21], ALUcon2ALU);
alu alu(reg2ALU, mux2ALU, ALUcon2ALU, ALU2and, ALU2mux_mem);

mux2to1 mux2to1_3(mux2pc, add2mux_1, add2mux_2, con2and & ALU2and);
Data_Memory Data_Memory(ALU2mux_mem, reg2mux_mem, con2mem_1, con2mem_2, mem2mux);
mux2to1 mux2to1_4(mux2reg_2, ALU2mux_mem, mem2mux, con2mux_2);

endmodule
