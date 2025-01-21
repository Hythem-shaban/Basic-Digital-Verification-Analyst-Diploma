typedef struct packed{
  bit var1;
  bit var2;
  bit [7:0] arr1;
} p_struct;

typedef bit [7:0] p_array;

class Class1 #(parameter type TP = integer, parameter VP = 10);
  p_struct var1 = 20;

  static function static p_struct st_fun_st(TP a1, byte a2);
      int res;
      res = a1 + a2 + VP;
      $display("res of st_fun_st: %0d", res);
      return res;
    endfunction: st_fun_st

endclass: Class1

class Class2 #(parameter p_array VP = 88) extends Class1;

endclass: Class2

module top;

  initial begin
    Class1#(int, 20)::st_fun_st(1, 1);
    Class2#(90)::st_fun_st(1, 1);
  end
endmodule: top