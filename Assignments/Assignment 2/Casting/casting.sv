module casting_q1;
  int x1, x2;
  byte y1, y2;
  initial
    begin
      y1 = 10;
      x1 = y1; 								// implicit casting
      $display("x1=%0d, y1=%0d", x1, y1);	// x=10, y=10
      
      y2 = 20;
      x2 = int'(y2);						// explicit casting
      $display("x2=%0d, y2=%0d", x2, y2);	// x=20, y=20
    end
endmodule: casting_q1

////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////

module casting_q2;
  enum integer {e0, e1, e2, e3, e4} myenum;
  time t;
  initial
    begin
      myenum = e3;
      
      t = e2;					// implicit casting
      $display("t=%0d", t);		// t=2
      
      t = time'(e3);			// explicit casting
      $display("t=%0d", t);		// t=3
    end
endmodule: casting_q2

////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////

module casting_q3;
  int x;
  byte y;
  enum integer {e0, e1, e2, e3, e4} myenum;
  time t;
  initial
    begin
      y = 10;
      $display($cast(x, y));			// 1
      $display("x=%0d, y=%0d", x, y);	// x=10, y=10
      
      myenum = e3;
      $display($cast(t, e3));			// 1
      $display("t=%0d", t);				// t=3
      
    end
endmodule: casting_q3