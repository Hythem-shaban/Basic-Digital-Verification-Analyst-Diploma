module unions_q1;
  typedef struct packed {
    bit [9:0] e1, e2, e3;
  } mystruct_s;
  
  union {
    mystruct_s mystruct;
    bit [29:0] p_arr;
  } myunion;
  
  initial
    begin
      myunion.p_arr = 1073741823;
      $display(myunion.mystruct.e1);
      $display(myunion.mystruct.e2);
      $display(myunion.mystruct.e3);
    end
endmodule: unions_q1