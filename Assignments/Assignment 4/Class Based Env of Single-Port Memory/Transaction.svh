`ifndef TRANSACTION_SVH
`define TRANSACTION_SVH

class Transaction #(parameter WIDTH = 32, DEPTH = 16);
  rand bit                     rst_n;
  rand bit [WIDTH-1:0]         i_data;
  rand bit                     we;
  rand bit [$clog2(DEPTH)-1:0] addr;
       bit [WIDTH-1:0]         o_data;
       bit                     valid;

  constraint c_rstn
    {
      rst_n dist {0:=5, 1:=95};
    }

  function void print(string tag = "");
    $display("[T=%0tns]: [%s] rst_n=%0d i_data=%0d addr=%0d we=%0d o_data=%0d valid=%0d", $time, tag, rst_n, i_data, addr, we, o_data, valid);
  endfunction: print

endclass: Transaction

`endif // TRANSACTION_SVH