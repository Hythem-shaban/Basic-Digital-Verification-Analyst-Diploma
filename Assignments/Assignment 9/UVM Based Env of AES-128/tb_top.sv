`timescale 1ns/1ns
module tb_top;
  import uvm_pkg::*;
  import my_pkg::*;
  bit clk;

  intf ifc (clk);

  AES_Encrypt 
  #(
    .N(ifc.KEY_WIDTH)
  ) 
  dut 
  (
    .in(ifc.plain_text),
    .key(ifc.cipher_key),
    .out(ifc.cipher_text)
  );

  always #5 clk = ~clk;

  initial begin
    uvm_config_db#(virtual intf)::set(null, "uvm_test_top", "my_vifc", ifc);
    run_test("my_test");
  end

  initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
  end
endmodule: tb_top