module bkk_crypt (
  input in, clk, reset,
  output reg out
);

always @(posedge clk)
if (~reset) begin
  out <= 1'b0;
end else begin
  out <= in;
end

endmodule
