typedef struct packed {
  logic x;
  int y;
  time t;
} pstruct;

module param
  #(
  	parameter type P1 = pstruct,
    parameter P1 P2 = 10
  )
  (
    input  logic [1:0]	a,
    input  logic [1:0]	b,
    output logic [3:0] 	y
  );
  
  generate
    if(P2 < 25)
      assign y = a + b;
    else
      assign y = a * b;
  endgenerate
endmodule: param

module top;
  
  logic [1:0] a;
  logic [1:0] b;
  logic [3:0] y;
  
  initial
    begin
      a = 2;
      b = 1;
      #1;
      $display(y);
    end
  
  param 
  #(
    .P1(int),
    .P2(50)
  )
  dut
  (
    .a(a),
    .b(b),
    .y(y)
  );
endmodule: top


module top2;
  parameter P3 = 5;
  parameter P4 = 2;
  
  logic [1:0] a[3];
  logic [1:0] b[3];
  logic [3:0] y[3];
  
  initial
    begin
      a = '{2, 2, 2};
      b = '{1, 1, 1};
      #1;
      $display("%p", y);
    end
  
  genvar i;
  generate
    for (i=P3; i>P4; i--)
      begin
        param 
        #(
          .P1(int),
          .P2(i)
        )
        dut
        (
          .a(a[P3-i]),
          .b(b[P3-i]),
          .y(y[P3-i])
        );
      end
  endgenerate
endmodule: top2
