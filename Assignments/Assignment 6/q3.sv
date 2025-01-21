class Class1;
  rand bit [9:0] var1;
  randc time var2;						// not working in VCS
  constraint const1 {
    var1 inside {[10:20], 40, 45, 7};
  }
  constraint const2 {
    var2 dist {10:=1, 12:=4, 6:=4};
  }
  constraint const3 {
    unique {var1, var2};
  }
endclass: Class1

module top;
  Class1 C1;
  initial begin
    C1 = new();
    if(C1.randomize()) begin
      $display("var1 = %0d", C1.var1);
      $display("var2 = %0d", C1.var2);
    end
    else
      $fatal("Randomization failed");
  end
endmodule: top