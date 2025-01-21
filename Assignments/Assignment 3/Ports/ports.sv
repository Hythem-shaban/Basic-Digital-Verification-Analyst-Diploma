module ports_q1
  #()
  (
    inout tri0 logic tri0_net
  );
  logic driver1;
  logic driver2;
  
  logic values[4];
  
  assign tri0_net = driver1;
  assign tri0_net = driver2;
  
  initial
    begin
      $monitor("[%0t] driver1=%0b driver2=%0b tri0=%0b", $time, driver1, driver2, tri0_net);
    end
  
  initial
    begin
      values = '{1'b0, 1'b1, 1'bx, 1'bz};
      
      foreach(values[i])
        foreach(values[j])
          begin
            driver1 = values[i];
            driver2 = values[j];
            #1;
          end
    end
  
  //tri0 || 0 | 1 | x | z
  //_____||___|___|___|___
  //   0 || 0 | x | x | 0
  //   1 || x | 1 | x | 1
  //   x || x | x | x | x
  //   z || 0 | 1 | x | 0
  
endmodule: ports_q1

////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

module ports_q2
  #(
  )
  (
    input var bit i_var_port,
    output var bit o_var_port,
    //inout var bit io_var_port,		// Non-net variable 'io_var_port' cannot be an inout port. check LRM2012 P668
    ref var int r_var_port
  );
  
  initial
    begin
      o_var_port = i_var_port;
      #100;
      $display(i_var_port);
      $display(o_var_port);
      $display(r_var_port);

    end
endmodule: ports_q2

module top_q2;
  bit i_var;
  bit o_var;
  int r_var;
  
  initial
    begin
      i_var = 1'b1;
      r_var = 5 * i_var;
    end
  
  ports_q2 dut (
    .i_var_port(i_var),
    .o_var_port(o_var),
    .r_var_port(r_var)
  );
endmodule: top_q2