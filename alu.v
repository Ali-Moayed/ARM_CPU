module alu(a,b,op,z,result);

///input
input [63:0] a;
input [63:0] b;
input [3:0] op;

output reg [63:0]result;
output reg z;

always @(a,b,op)
  begin
		
    if ( a==0 ) 
      begin z=1;
      end
    else z=0;

      case (op)
	4'b0000:  result = a & b;				
	4'b0001:  result = a | b;				
	4'b0010:  result = a + b;				
	4'b0110:  result= a - b;				
        4'b1100:  result = ~(a | b);
	4'b0111:  result=b;
	default:  result = 0;
      endcase
  end
	
endmodule 
