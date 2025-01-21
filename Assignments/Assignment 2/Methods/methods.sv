module methods_q1;
  function string myfun(input integer x, input byte y);
    $display("x = %0d, y = %0d", x, y);
    if ((x+y) > 10)
      return "hello";
    else
      return "hi";
  endfunction: myfun
  
  initial
    begin
      $display(myfun(5, 10));
      $display(myfun(1, 5));
    end
endmodule: methods_q1

module methods_q2;
  task mytask (integer x, byte y);
    $display("x = %0d, y = %0d", x, y);
    if ((x+y) > 10)
      $display("hello");
    else
      $display("hi");
  endtask: mytask
  
  initial
    begin
      mytask(5, 10);
      mytask(1, 5);
    end
endmodule: methods_q2