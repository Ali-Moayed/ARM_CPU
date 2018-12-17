
module pc(inpc, reset, clock, outpc);
parameter delay=10;
input [63:0]inpc;
input reset;
input clock;
output reg [63:0]outpc;


 always @ ( posedge clock ) 
 begin

	#delay	if(reset == 1)
		outpc = 0;
	else
   		outpc = inpc ;
 
  end

endmodule