module signextended (signextendedin , signextendedout);
  
        input  [31:0] signextendedin;
        output reg [63:0] signextendedout;
        
               always@(signextendedin)
begin
               if (signextendedin[31:26]==6'b000101)        // B-type
                     begin 
                       signextendedout[25:0] = signextendedin[25:0];
                         signextendedout[63:26] = {38{signextendedout[25]}};
			 
                     end

               else if (signextendedin[31:24] == 8'b10110100)     // CBZ-type
                     begin 
                      signextendedout[18:0] = signextendedin[23:5];
                      signextendedout[63:19] = {45{signextendedout[18]}};
                     end 
          
               else      // D-type
                     begin  
                      signextendedout[8:0] = signextendedin[20:12];
                      signextendedout[63:9] = {55{signextendedout[8]}};
                     end
    end
 endmodule