module piso (
  input clk,
  input rst,
  input load,
  input [7:0] in,
  output out
);
  reg [7:0] shift_reg;
  
  always@(posedge clk or posedge rst) begin
    if (rst) begin
      shift_reg <= 8'b0;
    end
    else if (load) begin
      shift_reg <= in;
    end
	else begin
      shift_reg <= {shift_reg[6:0],1'b0};
    end
  end
  assign out = shift_reg[7];
  
endmodule