module wrapper;
  logic [1:0] x_wrapper;
  logic [1:0] y_wrapper;
  bot2 #(.P1(10)) bot2(x_wrapper[0], y_wrapper[0]);
  bot3 #(.P1(20)) bot3(x_wrapper[1], y_wrapper[1]);
  bind top.mid1 mid2 mid2();
endmodule: wrapper

module top;
  bit [7:0] x_top;
  bit [7:0] y_top;
  mid1 #(.P1(20)) mid1();
  mid2 #(.P1(10)) mid2();
  
  initial
    begin
      mid1.x_mid1 = 5;
      $display("mid1.x_mid1 = ", mid1.x_mid1);
      mid1.GEN[0].bot1.x_bot1_var = 80;
      $display("mid1.GEN[0].bot1.x_bot1_var = ", mid1.GEN[0].bot1.x_bot1_var);
      
    end
endmodule: top

module mid1
  #(parameter P1 = 20)
  ();
  logic [2:0] x_mid1;
  logic [2:0] y_mid1;
  genvar i;
  generate
    for (i=0; i<3; i++)
      begin: GEN
     	bot1 bot1(.x_bot1(x_mid1[i]), .y_bot1(y_mid1[i]));
      end
  endgenerate
endmodule: mid1

module mid2
  #(parameter P1 = 10)
  ();
  logic x_mid2[3];
  logic y_mid2[3];
  bot1 bot1[3] (.x_bot1(x_mid2), .y_bot1(y_mid2));
endmodule: mid2

module bot1
  #()
  (
    input  logic x_bot1,
    output logic y_bot1
  );
  bit [7:0] x_bot1_var;
  initial
    begin
      $display("%m");
      top.x_top = 10;
      $display("top.x_top =", top.x_top);
      $root.top.x_top = 20;
      $display("$root.top.x_top =", $root.top.x_top);
    end
endmodule: bot1

module bot2
  #(parameter P1 = 10)
  (
    input  logic x_bot2,
    output logic y_bot2
  );
  initial
    $display("%m");
endmodule: bot2

module bot3
  #(parameter P1 = 20)
  (
    input  logic x_bot3,
    output logic y_bot3
  );
  initial
    $display("%m");
endmodule: bot3