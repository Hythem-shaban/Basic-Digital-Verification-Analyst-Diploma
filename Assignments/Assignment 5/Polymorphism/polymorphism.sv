typedef struct packed{
  bit var1;
  bit var2;
  bit [7:0] arr1;
} p_struct;

class Class1;
  p_struct var1 = 20;

  virtual function p_struct st_fun_st(integer a1, byte a2);
    int res;
    $display("res of st_fun_st: %0d", res);
    res = a1 + a2;
    return res;
  endfunction: st_fun_st
  
  virtual function p_struct dyn_fun_dyn(integer a1, byte a2);
    int res;
    $display("res of dyn_fun_dyn: %0d", res);
    res = a1 + a2;
    return res;
  endfunction: dyn_fun_dyn

  virtual function p_struct st_fun_dyn(integer a1, byte a2);
    int res;
    $display("res of st_fun_dyn: %0d", res);
    res = a1 + a2;
    return res;
  endfunction: st_fun_dyn

  virtual task st_task_st(integer a1, byte a2);
    int res;
    res = a1 + a2;
    $display("st_task_st Result: %0d", res);
  endtask: st_task_st
endclass: Class1

class Class2 extends Class1;
  function p_struct st_fun_st(integer a1, byte a2);
    int res;
    $display("res of st_fun_st: %0d", res);
    res = a1 * a2;
    return res;
  endfunction: st_fun_st
  
  function p_struct dyn_fun_dyn(integer a1, byte a2);
    int res;
    $display("res of dyn_fun_dyn: %0d", res);
    res = a1 * a2;
    return res;
  endfunction: dyn_fun_dyn

  function p_struct st_fun_dyn(integer a1, byte a2);
    int res;
    $display("res of st_fun_dyn: %0d", res);
    res = a1 * a2;
    return res;
  endfunction: st_fun_dyn

  task st_task_st(integer a1, byte a2);
    int res;
    $display("st_task_st Result: %0d", res);
    res = a1 * a2;
    if(res > 100)
      $display("hello");
    else
      $display("hi");
  endtask: st_task_st
endclass: Class2

module top;
  Class1 C1;
  Class2 C2;
  initial begin
    C1 = new();
    $display("Final Result: %0d", C1.st_fun_dyn(2, 3));
    C1.st_task_st(2, 3);
    
    C2 = new();
    $display("Final Result: %0d", C2.st_fun_dyn(2, 3));
    C2.st_task_st(2, 3);
    
    C1 = C2;
    $display("Final Result: %0d", C1.st_fun_dyn(2, 3));
    C1.st_task_st(2, 3);
    
    C1 = new();
    $display("Final Result: %0d", C1.st_fun_dyn(2, 3));
    C1.st_task_st(2, 3);
  end
endmodule: top