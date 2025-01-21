module structs_q1;
  typedef struct packed {
    bit a5, a4, a3, a2, a1, a0;
  } pstruct_s;
  
  typedef struct {
    event done;
    real myreal;
  } struct_s;
  
  struct {
    string mystr;
    integer myinteger;
    byte mybyte;
    pstruct_s my_pstruct;
    struct_s my_struct;
  } mystruct;
  
  initial
    begin
      mystruct.my_struct.myreal = 55.5;
      $display(mystruct.my_struct.myreal); 		// 55.5
      
      mystruct = '{mystr: "Hythem", myinteger: 24, mybyte: 1, my_pstruct: 64, my_struct: '{done: null, myreal: 22.2}};
      $display(mystruct.my_struct.myreal); 		// 22.2
      $display(mystruct.my_struct.done); 		// null
      
      $display("%p", mystruct);
    end
endmodule: structs_q1

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module structs_q2;
  struct packed {
    bit [7:0] e1;
    bit [4:0] e2;
  } mystruct;
  
  initial
    begin
      mystruct = 8191;
      $display(mystruct.e1);		// 255
      $display(mystruct.e2);		// 31
      $display("%p", mystruct);		// '{255, 31}
    end
endmodule: structs_q2

