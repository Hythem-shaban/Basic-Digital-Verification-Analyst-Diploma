class Randomization;
  rand int x;
  rand int y;
  constraint const1 {
    x inside {[1:50]};
    y inside {[1:70]};
  }
endclass: Randomization
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
    point_2: coverpoint y {
      bins bin_1[] = {[1:64]};                 //$ fatal error
      bins bin_2 = (2=>3);
      bins bin_3[] = (1=>4, 2=>5, 1=>5, 2=>4);
      bins bin_4   = (7[*3]=>8);
    }
  endgroup: group_1

  group_1 g1;
  Randomization R1;
  always #5 clk = ~clk;
  initial begin
    y = 0;
    g1 = new(x, y);
    R1 = new();
    repeat(500) begin
      @(negedge clk);
      if(R1.randomize()) begin
        x <= R1.x;
        y <= R1.y;
      end
      else
        $fatal("Randomization failed");
    end
    #10000;
    $display("Coverage = %.2f%%", g1.get_coverage());
    $finish;
  end
endmodule: top