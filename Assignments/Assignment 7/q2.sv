module top;
  int x;
  integer y;
  bit clk;
  covergroup group_1(ref int x, ref integer y) @(negedge clk);
    point_1: coverpoint x;                                    // wide range can not be covered 2^32 values
    point_2: coverpoint y;                                    // wide range can not be covered 2^32 values
  endgroup: group_1

  group_1 g1;

  always #5 clk = ~clk;
  always @(negedge clk) begin
    x = x + 1;
    y = y + 2;
  end
  initial begin
    y = 0;
    g1 = new(x, y);
    #100;
    $display("Coverage = %.2f%%", g1.get_coverage());
    $finish;
  end
endmodule: top