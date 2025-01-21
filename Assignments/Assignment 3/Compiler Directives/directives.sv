`define M1(a1, a2) \
initial \
  begin \
    $display(a1); \
    $display(a2); \
  end
`define M2(b1, b2) \
initial \
  begin \
    $display("net_",`"b1`",`"b2`","=", net_``b1````b2``); \
  end
module directives;
  int x, y;
  logic net_00;
  logic net_01;
  logic net_10;
  logic net_11;
  `M1(x, y)
  `undef M1
  `M2(0, 0)
  `M2(0, 1)
  `M2(1, 0)
  `M2(1, 1)
  `undef M2
endmodule