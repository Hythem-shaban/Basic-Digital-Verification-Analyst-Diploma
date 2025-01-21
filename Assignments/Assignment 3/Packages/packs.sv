package pack1;
  typedef integer 		intg;
  typedef byte unsigned ubyte;
  parameter int P1 = 10;
  parameter int P2 = 20;
endpackage: pack1

package pack2;
import pack1::P1;
import pack1::P2;
endpackage: pack2

package pack3;
  import pack2::*;
endpackage: pack3

module top;
  import pack3::*;
  intg x;
  ubyte y;
  initial 
    begin
      x = 5;
      y = 6;
      $display(P1, P2, x, y);	// nothiing is visible
    end
endmodule: top

/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////

package pack1;
  typedef integer 		intg;
  typedef byte unsigned ubyte;
  parameter int P1 = 10;
  parameter int P2 = 20;
endpackage: pack1

package pack2;
import pack1::P1;
import pack1::P2;
endpackage: pack2

package pack3;
  import pack2::*;
endpackage: pack3

module top;
  intg x;
  ubyte y;
  initial 
    begin
      x = 5;
      y = 6;
      $display(P1, P2, x, y);	// nothiing is visible
    end
endmodule: top

/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////

package pack1;
  typedef integer 		intg;
  typedef byte unsigned ubyte;
  parameter int P1 = 10;
  parameter int P2 = 20;
endpackage: pack1

package pack2;
import pack1::*;
export pack1::*;
endpackage: pack2

package pack3;
  import pack2::*;
  export pack2::*;
endpackage: pack3

module top;
  import pack3::*;
  intg x;
  ubyte y;
  initial 
    begin
      x = 5;
      y = 6;
      $display(P1, P2, x, y);	// nothiing is visible
    end
endmodule: top

/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////

package pack1;
  typedef integer 		intg;
  typedef byte unsigned ubyte;
  parameter int P1 = 10;
  parameter int P2 = 20;
endpackage: pack1

package pack2;
  import pack1::*;
  export pack1::*;
endpackage: pack2

package pack3;
  import pack2::*;
  export pack2::*;
endpackage: pack3

module top;
  import pack1::*;
  import pack2::*;
  import pack3::*;
  intg x;
  ubyte y;
  initial 
    begin
      x = 5;
      y = 6;
      $display(P1, P2, x, y);	// all are visible
    end
endmodule: top
