interface ifc #(parameter type P1 = int, parameter int P2 = 20)(input bit clk);
  parameter int X1 = 5;
  localparam int X2 = 11;
endinterface: ifc

module top
  #(
    parameter type P1 = shortint,
    parameter int  P2 = 10
  )
  ();
  
  bit clk;
  
  ifc #(.X1(8), .P2(P2)) ifc1 (.clk(clk));
endmodule