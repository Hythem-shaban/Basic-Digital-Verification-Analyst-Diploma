module arrays_q1;
  typedef struct {
    string name;
    event done;
    real myreal;
    bit [2:0] p_arr;
  } struct_s;
  
  struct_s assoc[string];
  
  initial
    begin
      assoc = '{"hi":'{name:"hi", done:null, myreal:24.1, p_arr:1}, 
                "hello":'{name:"hello", done:null, myreal:24.2, p_arr:2}, 
                "hey":'{name:"hey", done:null, myreal:24.3, p_arr:3}};
      
      $display(assoc["hi"].name, " ", assoc["hi"].done, " ", assoc["hi"].myreal, " ", assoc["hi"].p_arr);
      $display(assoc["hello"].name, " ", assoc["hello"].done, " ", assoc["hello"].myreal, " ", assoc["hello"].p_arr);
      $display(assoc["hey"].name, " ", assoc["hey"].done, " ", assoc["hey"].myreal, " ", assoc["hey"].p_arr);
    end
endmodule: arrays_q1

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module arrays_q2;
  typedef struct {
    string name;
    event done;
    real myreal;
    bit [2:0] p_arr;
  } struct_s;
  
  struct_s assoc[*];
  
  initial
    begin
      assoc = '{"hi":'{name:"hi", done:null, myreal:24.1, p_arr:1}, 
                "hello":'{name:"hello", done:null, myreal:24.2, p_arr:2}, 
                "hey":'{name:"hey", done:null, myreal:24.3, p_arr:3}};
      
      $display(assoc["hi"].name, " ", assoc["hi"].done, " ", assoc["hi"].myreal, " ", assoc["hi"].p_arr);
      $display(assoc["hello"].name, " ", assoc["hello"].done, " ", assoc["hello"].myreal, " ", assoc["hello"].p_arr);
      $display(assoc["hey"].name, " ", assoc["hey"].done, " ", assoc["hey"].myreal, " ", assoc["hey"].p_arr);
    end
endmodule: arrays_q2

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module arrays_q3;
  string q[$];
  initial
    begin
      $display("%0d", q.size);										                // 0
      q.push_front("Hello");
      q.push_front(", ");
      q.push_front("Hythem");
      q.push_front("!");
      $display("%0d", q.size);										                // 4
      $display(q.pop_back, q.pop_back, q.pop_back, q.pop_back);		// Hello, Hythem!
      $display("%0d", q.size);										                // 0
    end
endmodule: arrays_q3

