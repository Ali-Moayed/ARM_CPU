module PReg(Clock,in,out);
parameter n=1;

input Clock;
input [n-1:0]in;

output reg [n-1:0]out;

initial
    #10 out <= 0;

always@(posedge Clock)
begin
    out <= in;
end
endmodule
