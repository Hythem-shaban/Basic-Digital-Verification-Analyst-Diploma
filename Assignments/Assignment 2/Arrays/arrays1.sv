module arrays_q1;
  bit [32:0] arr;
  initial
    begin
      arr = 40;						
      $display("%b", arr);			// 000000000000000000000000000101000
      $display("%b", arr[0:3]);		// 0000
      $display("%b", arr[3:0]);		// 1000
      $display("%b", arr[9]);		// 0
      $display("%b", arr[5]);		// 1
    end
endmodule: arrays_q1

//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////

module arrays_q2;
  int arr[10];
  initial
    begin
      arr = '{1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
      $display("%p", arr);
    end
endmodule: arrays_q2

//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////

module arrays_q3;
  typedef struct {
    string name;
    event done;
    real myreal;
    bit [2:0] p_arr;
  } struct_s;
  
  struct_s arr[];
  initial
    begin
      arr = new[6];
      arr = '{0:'{name:"Hythem", done:null, myreal:24.22, p_arr:1}, 
              1:'{name:"Ahmed", done:null, myreal:24.22, p_arr:2}, 
              2:'{name:"Shaban", done:null, myreal:24.22, p_arr:3}, 
              3:'{name:"Ahmed", done:null, myreal:24.22, p_arr:4}, 
              4:'{name:"Ibrahim", done:null, myreal:24.22, p_arr:5}, 
              5:'{name:"Mohamed", done:null, myreal:24.22, p_arr:6}};
      $display("%p", arr);
    end
endmodule: arrays_q3