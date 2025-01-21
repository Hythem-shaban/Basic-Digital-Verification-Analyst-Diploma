module wrapper;
  logic [4:0] x;
  logic [4:0] y;
  bot2 #(.P1(10)) bot2(x[0], y[0]);
  bot3 #(.P1(20)) bot3(x[1], y[1]);
  bind top.mid1 mid2 mid2();
endmodule: wrapper

module top;
  mid1 #(.P1(20)) mid1();
  mid2 #(.P1(10)) mid2();
endmodule: top

module mid1
  #(parameter P1 = 20)
  ();
  logic [2:0] x;
  logic [2:0] y;
  genvar i;
  generate
    for (i=0; i<3; i++)
      bot1 bot1(.x(x[i]), .y(y[i]));
  endgenerate
endmodule: mid1

module mid2
  #(parameter P1 = 10)
  ();
  logic x[3];
  logic y[3];
  bot1 bot1[3] (.x(x), .y(y));
endmodule: mid2

module bot1
  #()
  (
    input  logic x,
    output logic y
  );
  initial
    $display("%m");
endmodule: bot1

module bot2
  #(parameter P1 = 10)
  (
    input  logic x,
    output logic y
  );
  initial
    $display("%m");
endmodule: bot2

module bot3
  #(parameter P1 = 20)
  (
    input  logic x,
    output logic y
  );
  initial
    $display("%m");
endmodule: bot3