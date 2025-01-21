typedef struct packed{
  bit var1;
  bit var2;
  bit [7:0] arr1;
} p_struct;

class Class1;
  p_struct var1 = 20;

  static function static p_struct st_fun_st(integer a1, byte a2);
    int res;
    $display("res of st_fun_st: %0d", res);
    res = a1 + a2;
    return res;
  endfunction: st_fun_st
  
  function p_struct dyn_fun_dyn(integer a1, byte a2);
    int res;
    $display("res of dyn_fun_dyn: %0d", res);
    res = a1 + a2;
    return res;
  endfunction: dyn_fun_dyn

  static function p_struct st_fun_dyn(integer a1, byte a2);
    int res;
    $display("res of st_fun_dyn: %0d", res);
    res = a1 + a2;
    return res;
  endfunction: st_fun_dyn

  static task static st_task_st(integer a1, byte a2, int i);
    int res;
    $display("st_task_st Result[%0d]: %0d", i, res);
    res = a1 + a2;
  endtask: st_task_st
endclass: Class1

class Class2 extends Class1;

endclass: Class2

module top;
  Class1 C1;
  Class2 C2;
  initial begin
    C2 = new();
    $display("var1 of class1: %0d", C2.var1);
    $display("Final Result: %0d", C2.st_fun_st(1, 1));
    
    C1 = C2;
    $cast(C2, C1);
  end
endmodule: top