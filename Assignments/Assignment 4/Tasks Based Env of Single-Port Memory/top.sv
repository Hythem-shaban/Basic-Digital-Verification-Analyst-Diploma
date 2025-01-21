`include "mem.sv"
`include "intf.sv"
`include "env.sv"
module top;
bit clk;
int errors;

intf intf1 (clk);

memory dut (
  .i_clk(intf1.clk),
  .i_rst_n(intf1.rst_n),
  .i_addr(intf1.addr),
  .i_data(intf1.i_data),
  .i_we(intf1.we),
  .o_data(intf1.o_data),
  .o_valid(intf1.valid)
);

always #5 clk = ~clk;

env env1;

initial begin
  env1 = new();
  fork
    env1.generator(20);
    env1.driver(intf1);
    env1.monitor(intf1);
    env1.scoreboard(errors);
  join_none
end

final
  begin
    $display("number of errors = %0d", errors);
  end

initial begin
  intf1.rst_n = 0;
  #10;
  intf1.rst_n = 1;
  #500;
  $finish;
end

initial begin
  $dumpfile("wave.vcd");
  $dumpvars;
end
endmodule: top