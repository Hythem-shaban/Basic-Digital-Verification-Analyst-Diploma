module top;
  int x;
  integer y;
  bit clk;
  covergroup group_1(ref int x, ref integer y) @(negedge clk);
    point_1: coverpoint x {
      bins bin_1 = {1, 2, [19:21]};
      bins bin_2[] = {7, 10};
      bins bin_3[] = {24, 32, 38, 46};
      bins bin_4[] = default;
      }
    point_2: coverpoint y;
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
    
    #10000;
    $display("Coverage = %.2f%%", g1.get_coverage());
    $finish;
  end
endmodule: top