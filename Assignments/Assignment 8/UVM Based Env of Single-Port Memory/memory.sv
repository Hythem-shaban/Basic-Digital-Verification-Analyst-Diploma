module memory 
#(
  parameter WIDTH = 32,
  parameter DEPTH = 16
) 
(
  input  logic                     i_clk,
  input  logic                     i_rst_n,
  input  logic [WIDTH-1:0]         i_data,
  input  logic                     i_we,
  input  logic [$clog2(DEPTH)-1:0] i_addr,
  output logic [WIDTH-1:0]         o_data,
  output logic                     o_valid
);

logic [WIDTH-1:0] mem [DEPTH];

always @(posedge i_clk, negedge i_rst_n) begin
  if (!i_rst_n) begin
    for (int i = 0; i < DEPTH; i++) begin
      mem[i] <= 0;
    end
    o_valid <= 1'b0;
    o_data <= 'b0;
  end
  else if (i_we) begin
    mem[i_addr] <= i_data;
    o_valid <= 1'b0;
  end
  else begin
    o_data <= mem[i_addr];
    o_valid <= 1'b1;
  end
end
  
endmodule: memory