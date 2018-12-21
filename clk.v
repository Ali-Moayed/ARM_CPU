module CLK(clk);

output reg clk;

always
  begin
    clk = 1'b1;

    #100 clk = 1'b0;
    #100;
  end
endmodule
