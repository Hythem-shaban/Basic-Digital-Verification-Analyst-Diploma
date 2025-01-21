class Randomization;
  rand bit[2:0] x;
  rand bit[2:0] y;
  constraint const1 {
    x inside {[0:7]};
    y inside {[0:7]};
  }
endclass: Randomization
module top;
  bit[2:0] x, y;
  //integer y;
  bit clk;
  covergroup group_1 @(negedge clk);
    coverpoint x;
    coverpoint y;
    cross x, y {
      bins bin_7 = '{'{1,2},'{3,6}};
    }
  endgroup: group_1

  group_1 g1;
  Randomization R1;
  always #5 clk = ~clk;
  initial begin
    y = 0;
    g1 = new();
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