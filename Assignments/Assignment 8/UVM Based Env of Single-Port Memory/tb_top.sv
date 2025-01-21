`timescale 1ns/1ns
module tb_top;
  import uvm_pkg::*;
  import my_pkg::*;
  bit clk;

  intf ifc0 (clk);

  memory #() dut (
    .i_clk(clk),
    .i_rst_n(ifc0.rst_n),
    .i_addr(ifc0.addr),
    .i_data(ifc0.i_data),
    .i_we(ifc0.we),
    .o_data(ifc0.o_data),
    .o_valid(ifc0.valid)
  );

  always #5 clk = ~clk;

  initial begin
    uvm_config_db#(virtual intf)::set(null, "uvm_test_top", "my_vifc", ifc0);
    run_test("my_test");
  end

  initial begin
    force ifc0.rst_n = 0;
    #10; 
    force ifc0.rst_n = 1;
    release ifc0.rst_n;
  end

  initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
  end
endmodule: tb_top