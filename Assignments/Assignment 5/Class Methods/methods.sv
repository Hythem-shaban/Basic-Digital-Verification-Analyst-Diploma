typedef struct packed{
  bit var1;
  bit var2;
  bit [7:0] arr1;
} p_struct;

class Class1;
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

module top;
  Class1 C1;
  bit [9:0] res1, res2, res3;
  initial begin
    C1 = new();
    for(int i=0; i<3; i++) begin
      res1 = 1 + Class1::st_fun_st(i, i);
      $display("st_fun_st Result[%0d]: %0d", i, res1);

      res2 = 1 + C1.dyn_fun_dyn(i, i);
      $display("dyn_fun_dyn Result[%0d]: %0d", i, res2);

      res3 = 1 + C1.st_fun_dyn(i, i);
      $display("dyn_fun_dyn Result[%0d]: %0d", i, res3);

      C1.st_task_st(i, i, i);
      
      $display("");
    end
    $display("st_fun_st Final Result: %0d", res1);
    $display("dyn_fun_dyn Final Result: %0d", res2);
    $display("st_fun_dyn Final Result: %0d", res3);
  end
endmodule: top
