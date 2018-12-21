module RegisterBank(A,B,C,Adata,Bdata,Cdata,W,CLK);

input [4:0]A;
input [4:0]B;
input [4:0]C;
input [63:0]Cdata;
input W;
input CLK;

parameter delay = 10;

output  [63:0]Adata;
output  [63:0]Bdata;

reg [63:0] registersTable [31:0];

integer i;
initial
begin
    for (i=0; i<32; i=i+1) registersTable[i] = i;
end
//assigning data of addressed registers into outputs


assign  Adata = registersTable[A];
assign  Bdata = registersTable[B];


//writing data into addressed register
always@(posedge CLK)
  begin
  if(W)
    begin
    #delay registersTable[C] = Cdata;
    end
  end

endmodule
