module CPU_Test_Piped();

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

//pipelineRegisters wires
wire [63:0]WReg_11;
wire [31:0]WReg_12;

wire [1:0]WReg_21;
wire [2:0]WReg_22;
wire [2:0]WReg_23;
wire [63:0]WReg_24;
wire [63:0]WReg_25;
wire [63:0]WReg_26;
wire [63:0]WReg_27;
wire [10:0]WReg_28;
wire [4:0]WReg_29;

wire [1:0]WReg_31;
wire [2:0]WReg_32;
wire [63:0]WReg_33;
wire [63:0]WReg_34;
wire [63:0]WReg_35;
wire [10:0]WReg_36;
wire [4:0]WReg_37;

wire [1:0]WReg_41;
wire [63:0]WReg_42;
wire [63:0]WReg_43;
wire [4:0]WReg_44;

CLK clock(clk);

//Pipeline_1
mux2to1 mux2to1_3(mux2pc, add2mux_1, add2mux_2, WReg_22 & WReg_34);
pc pc(mux2pc, pcReset, clk, pc2out);
Adder Adder_1(pc2out, 64'b0000000000000000000000000000000000000000000000000000000000000100, add2mux_1);
instr_mem instr_mem(pc2out, insMem2out);

//PRegs_1
PReg PReg_11(clk, pc2out, WReg_11); defparam PReg_11.n = 64;
PReg PReg_12(clk, insMem2out, WReg_12); defparam PReg_12.n = 32;

//Pipeline_2
controll_unit controll_unit(WReg_12[31:21], con2mux_1, con2mux_3, con2mux_2, con2reg, con2mem_1, con2mem_2, con2and, con2ALUcon_1, con2ALUcon_2);
mux2to1 mux2to1_1(mux2reg_1, WReg_12[20:16], WReg_12[4:0], con2mux_1); defparam mux2to1_1.n = 5;
RegisterBank RegisterBank(WReg_12[9:5], mux2reg_1, WReg_44, reg2ALU, reg2mux_mem, mux2reg_2, WReg_41[1], clk);
signextended signextended(WReg_12 ,sign2out);

//PRegs_2
PReg PReg_21(clk, {con2reg,con2mux_2}, WReg_21); defparam PReg_21.n = 2;
PReg PReg_22(clk, {con2and,con2mem_1,con2mem_2}, WReg_22); defparam PReg_22.n = 3;
PReg PReg_23(clk, {con2ALUcon_1,con2ALUcon_2,con2mux_3}, WReg_23); defparam PReg_23.n = 3;
PReg PReg_24(clk, WReg_11, WReg_24); defparam PReg_24.n = 64;
PReg PReg_25(clk, reg2ALU, WReg_25); defparam PReg_25.n = 64;
PReg PReg_26(clk, reg2mux_mem, WReg_26); defparam PReg_26.n = 64;
PReg PReg_27(clk, sign2out, WReg_27); defparam PReg_27.n = 64;
PReg PReg_28(clk, WReg_12[31:21], WReg_28); defparam PReg_28.n = 11;
PReg PReg_29(clk, WReg_12[4:0], WReg_29); defparam PReg_29.n = 5;

//Pipeline_3
shiftL2 shiftL2(sign2out , shift2add);
Adder Adder_2(WReg_24, shift2add, add2mux_2);
mux2to1 mux2to1_2(mux2ALU, WReg_26, WReg_27, WReg_23[0]);
alu_control alu_control({WReg_23[2],WReg_23[1]}, WReg_28, ALUcon2ALU);
alu alu(WReg_25, mux2ALU, ALUcon2ALU, ALU2and, ALU2mux_mem);

//PRegs_3
PReg PReg_31(clk, WReg_21, WReg_31); defparam PReg_31.n = 2;
PReg PReg_32(clk, WReg_22, WReg_32); defparam PReg_32.n = 3;
PReg PReg_33(clk, add2mux_2, WReg_33); defparam PReg_33.n = 64;
PReg PReg_34(clk, ALU2and, WReg_34);
PReg PReg_35(clk, ALU2mux_mem, WReg_35); defparam PReg_35.n = 64;
PReg PReg_36(clk, WReg_26, WReg_36); defparam PReg_36.n = 64;
PReg PReg_37(clk, WReg_29, WReg_37); defparam PReg_37.n = 5;

//Pipeline_4
Data_Memory Data_Memory(WReg_35, WReg_36, WReg_32[1], WReg_32[0], mem2mux);

//PRegs_4
PReg PReg_41(clk, WReg_31, WReg_41); defparam PReg_24.n = 2;
PReg PReg_42(clk, mem2mux, WReg_42); defparam PReg_24.n = 64;
PReg PReg_43(clk, WReg_35, WReg_43); defparam PReg_24.n = 64;
PReg PReg_44(clk, WReg_37, WReg_44); defparam PReg_24.n = 5;

//
mux2to1 mux2to1_4(mux2reg_2, WReg_43, WReg_42, WReg_41[0]);

endmodule
