class Class1;
  rand bit [9:0] var1;
endclass: Class1

module top;
  Class1 C1;
  initial begin
    C1 = new();
    if(C1.randomize())
      $display("var1 = %0d", C1.var1);
    else
      $fatal("Randomization failed");
  end
endmodule: top