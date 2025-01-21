`timescale 1ns/1ns
`include "intf.sv"
`include "memory.sv"
`include "pkg.svh"
`include "test.sv"
module top;
  bit clk;
  
  intf #() ifc(clk);

  memory #() dut (
    .i_clk(clk),
    .i_rst_n(ifc.rst_n),
    .i_addr(ifc.addr),
    .i_data(ifc.i_data),
    .i_we(ifc.we),
    .o_data(ifc.o_data),
    .o_valid(ifc.valid)
  );

  test #() tb (ifc);

  always #5 clk = ~clk;

  initial begin
    force ifc.rst_n = 0;
    #10; 
    force ifc.rst_n = 1;
    release ifc.rst_n;
  end

  initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
  end
endmodule: top