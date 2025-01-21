module enums_q1;
  enum integer {e1=0, e2=5, e3=7, e4=9} myinteger;
  initial
    begin
      $display("%p", myinteger);	// x (default value)
      $display(myinteger.name);		// empty string (the given value (x) is not a member)
      $display(myinteger);			// x (default value)
      myinteger = e2;
      $display("%p", myinteger);	// e2
      $display(myinteger.name);		// e2
      $display(myinteger);	  		// 5 (of type integer)
    end
endmodule: enums_q1

//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////

module enums_q2;
  typedef enum time {e1=1032, e2=2003, e3=2004, e4=5000} mytime_e;
  mytime_e mytime;
  initial
    begin
      $display("%p", mytime);		// x (default value)
      
      mytime = mytime.first;
      $display(mytime.name);		// e1 
      
      mytime = 2003;				// implicit casting --> warning
      $display(mytime.name);		// e2 
      
      $display(mytime.prev);		// 1032
      $display("%p", mytime.prev);	// e1
      $display(mytime.next);		// 2004
      $display(mytime.next.name);	// e3
    end
// NOTE: did not work with VCS
endmodule: enums_q2

//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////

module enums_q3;
  enum integer {e1=0, e2=5, e3=7, e4=9} myinteger;
  initial
    begin
      $display(myinteger.name); 		// empty string 
      $display("%p", myinteger.first); 	// e1
      
      myinteger = e3;
      $display("%p", myinteger.next); 	// e4
      $display("%p", myinteger.prev); 	// e2
      
      $display("%0d", myinteger.num);	// 4
    end
endmodule: enums_q3