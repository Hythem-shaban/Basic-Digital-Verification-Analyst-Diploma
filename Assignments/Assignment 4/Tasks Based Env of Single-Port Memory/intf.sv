interface intf #(parameter WIDTH = 32, DEPTH = 16)(input logic clk);

  logic                     rst_n;
  logic [WIDTH-1:0]         i_data;
  logic                     we;
  logic [$clog2(DEPTH)-1:0] addr;
  logic [WIDTH-1:0]         o_data;
  logic                     valid;

endinterface: intf